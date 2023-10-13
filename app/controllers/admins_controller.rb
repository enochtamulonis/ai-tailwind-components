class AdminsController < Admins::BaseController
  def index
    @active_subscriptions = Subscription.where(ignore_subscription: false, status: :active).count
    @components_by_subscribed = AiComponent.joins(user: :subscription)
        .where(created_at: Time.zone.now.beginning_of_day..Time.zone.now)
        .where(subscriptions: { status: :active })
        .where.not(users: { id: nil }).count
  end
end