class UsersController < ApplicationController

# before_action :require_login


  def create
    create user
    if user.save
      flash[:success] = "Congrats"
    else
      flash[:error]
  end
end
