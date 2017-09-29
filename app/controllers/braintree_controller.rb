class BraintreeController < ApplicationController

  def new

  @client_token = Braintree::ClientToken.generate
  @reservation = Reservation.find(params[:id])

  end

  def checkout

    @reservation = Reservation.find(params[:id])

  nonce_from_the_client = params[:checkout_form][:payment_method_nonce]

  result = Braintree::Transaction.sale(
   :amount => "#{@reservation.payment_amount}", #this is currently hardcoded
   :payment_method_nonce => nonce_from_the_client,
   :options => {
      :submit_for_settlement => true
    }
   )

  if result.success?
    @reservation.update(:payment => true)
      ReservationMailerJob.perform_later(@user, @reservation.host, @reservation.id)

    redirect_to :root, :flash => { :success => "Transaction successful!" }
  else
    redirect_to :root, :flash => { :error => "Transaction failed. Please try again." }
  end
end

end
