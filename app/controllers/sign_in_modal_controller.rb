class SignInModalController < ApplicationController
  def create
    render turbo_stream: turbo_stream.append("body", partial: "modal")
  end
end