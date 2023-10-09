class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_if_active_subscription, only: [:new]

  def new; end

  def edit
    @subscription = Stripe::Subscription.retrieve(
      current_user.active_subscription.stripe_subscription_id,
    )
  end

  private

  def redirect_if_active_subscription
    redirect_to root_path if current_user.active_subscription
  end
end