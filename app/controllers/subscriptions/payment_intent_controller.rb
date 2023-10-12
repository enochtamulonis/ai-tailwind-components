module Subscriptions
  class PaymentIntentController < ApplicationController
    def create
      if !current_user.customer_id.present?
        stripe_customer = Stripe::Customer.create({
          description: 'Registered user for Tailwind Genius account.',
          email: current_user.email,
          name: current_user.full_name
        })
        current_user.customer_id = stripe_customer.id
        current_user.save!
      end

      subscription = Stripe::Subscription.create(
        customer: current_user.customer_id,
        items: [{
          price: Rails.application.credentials.dig(:stripe, :monthly_subscription_price),
        }],
        payment_behavior: 'default_incomplete',
        payment_settings: {save_default_payment_method: 'on_subscription'},
        expand: ['latest_invoice.payment_intent'],
        metadata: {
          user_id: current_user.id,
        },
      )


      respond_to do |format|
        format.json {
          render json: { 
            subscriptionId: subscription.id, 
            clientSecret: subscription.latest_invoice.payment_intent.client_secret 
          }
        }
      end
    end
  end
end