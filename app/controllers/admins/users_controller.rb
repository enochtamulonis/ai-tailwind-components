module Admins
  class UsersController < Admins::BaseController
    def index
      @users = User.all.order(created_at: :desc)
    end
  end
end