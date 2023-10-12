module Admins
  class EmailsController < Admins::BaseController
    def new
      @email = Admin::Email.new
    end

    def create
      @email = Admin::Email.new(email_params)
      if @email.save
        redirect_to admin_path, notice: "Email was succesfully sent"
      else
        render :new
      end
    end

    private

    def email_params
      params.require(:email).permit(:subject, :body, :to_user_ids)
    end
  end
end