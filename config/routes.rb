Rails.application.routes.draw do
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "users", only: [:create, :update, :show, :edit] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
    resources :listings
    resources :reservations
  end

  root 'static#home'

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  get "/listings/all" => "listings#all"
  put "/users/:user_id/listings/:id/verify" => "listings#verify", as: "verify_property"
  get "/listings/:id" => "listings#show", as: "show_listing"
  get "/reservations/:id/checkout" => "braintree#checkout", as: "braintree_checkout"
  get "/reservations/:id/braintree/new" => "braintree#new", as: "braintree_new"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
