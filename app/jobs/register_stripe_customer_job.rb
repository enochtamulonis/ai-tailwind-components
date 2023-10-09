class RegisterStripeCustomerJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    # Do something later
    user = User.find(user_id)
    stripe_customer = Stripe::Customer.create({
      description: 'Registered user for Tailwind Genius account.',
      email: user.email,
      name: user.full_name
    })
    user.customer_id = stripe_customer.id
    user.save!
  end
end
