class WebhookEventsController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def create
    if !valid_signatures?
      render json: {message: "Invalid sigs" }, status: 400
      return
    end

    if !WebhookEvent.find_by(source: params[:source], external_id: external_id).nil?
      render json: {message: "Already processed #{ external_id }"}
      return
    end

    event = WebhookEvent.create!(webhook_params)
    
    ProcessEventsJob.perform_later(event.id)

    respond_to do |format|
      format.js
      format.json
    end
  end

private

  def external_id
    return params[:id] if params[:source] == 'stripe' # 'evt_xxxxxx'
    SecureRandom.hex
  end

  def valid_signatures?
    if params[:source] == 'stripe'
      begin
        Stripe::Webhook.construct_event(
          request.body.read,
          request.env['HTTP_STRIPE_SIGNATURE'],
          wh_secret,
        )
      rescue Stripe::SignatureVerificationError => e
        return false
      end
    end

    true
  end
  def webhook_params
    {
      source: params[:source],
      data: params.except(:source, :action, :controller).permit!,
      external_id: external_id
    }
  end

  def wh_secret
    Rails.application.credentials.dig(:stripe, :wh_secret)
  end
end
