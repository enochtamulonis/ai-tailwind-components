class PurchaseController < ApplicationController
  def new
    if !current_user
      cookies["user_return_to"] = request.original_url
      session[:return_to] = request.original_url
      authenticate_user!
    end
  end
end