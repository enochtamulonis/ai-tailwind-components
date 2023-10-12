module Admins
  class UsersController < Admins::BaseController
    before_action :set_user, only: [:listen_to_subscription, :ignore_subscription]
    def index
      @users = User.all.order(created_at: :desc)
    end

    def listen_to_subscription
      return head :ok if !@user.active_subscription
      @user.active_subscription.update(ignore_subscription: false)
      render turbo_stream: turbo_stream.replace(ActionView::RecordIdentifier.dom_id(@user, :dropdown), partial: "dropdown", locals: { user: @user })
    end

    def ignore_subscription
      return head :ok if !current_user.active_subscription
      @user.active_subscription.update(ignore_subscription: true)
      render turbo_stream: turbo_stream.replace(ActionView::RecordIdentifier.dom_id(@user, :dropdown), partial: "dropdown", locals: { user: @user })
    end

    private

    def set_user
      @user = User.find(params[:user_id])
    end

  end
end