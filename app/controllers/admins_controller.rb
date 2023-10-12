class AdminsController < Admins::BaseController
  def index
    @active_subscriptions = Subscription.joins(:user)
    .where.not("users.email LIKE ? OR users.email LIKE ?", "%wavclouds@gmail.com%", "%tailwindgenius@gmail.com%")
    .where(status: :active).count
  end
end