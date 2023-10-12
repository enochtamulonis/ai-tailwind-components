class AdminsController < Admins::BaseController
  def index
    @active_subscriptions = Subscription.where(ignore_subscription: false, status: :active).count
  end
end