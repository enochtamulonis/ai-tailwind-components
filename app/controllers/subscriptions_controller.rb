class SubscriptionsController < ApplicationController
  before_action :authenticate_user!, only: [:edit]

  def new
    redirect_to root_path, notice: "You already have an active subscription" if current_user&.active_subscription
    if !current_user
      cookies["user_return_to"] = request.original_url
      session[:return_to] = request.original_url
      authenticate_user!
    end
  end

  def edit
    @subscription = Stripe::Subscription.retrieve(
      current_user.active_subscription.stripe_subscription_id,
    )
  end
end