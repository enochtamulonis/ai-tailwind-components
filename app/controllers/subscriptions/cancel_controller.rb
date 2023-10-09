class Subscription::CancelController < ApplicationController
  def create
    subscription = current_user.subscription
    Stripe::Subscription.delete(subscription.stripe_subscription_id)
    if subscription.destroy!
      redirect_to root_path, notice: "Your subscription was cancelled"
    end
  end
end