module Purchase
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

      payment_intent = Stripe::PaymentIntent.create({
        amount: 499,
        currency: 'usd',
        automatic_payment_methods: {enabled: true},
        customer: current_user.customer_id,
        metadata: {
          user_id: current_user.id,
        },
      })


      respond_to do |format|
        format.json {
          render json: { 
            clientSecret: payment_intent['client_secret']
          }
        }
      end
    end
  end
end