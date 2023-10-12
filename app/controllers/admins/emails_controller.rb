module Admins
  class EmailsController < Admins::BaseController
    def new
      @email = Admin::Email.new
    end

    def create
      @email = Admin::Email.new(email_params)
      if @email.save
        AdminEmailJob.perform_later(@email.id)
        redirect_to admin_path, notice: "Email was succesfully sent"
      else
        render :new
      end
    end

    private

    def email_params
      params.require(:admin_email).permit(:subject, :body, :send_to_all)
    end
  end
end