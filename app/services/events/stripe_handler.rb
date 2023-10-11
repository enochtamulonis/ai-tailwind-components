module Events
  class StripeHandler
    def self.process(event)
      stripe_event = Stripe::Event.construct_from(event.data)
      puts "Processing stripe event #{stripe_event.type}"
      case stripe_event.type
      when 'customer.subscription.updated'
        # Create subscription update user
        if Rails.env.production?
          sleep 3
        end
        if stripe_event.data.object.status == "active"
          metadata = stripe_event.data.object.metadata
          user = User.find(metadata.user_id)
          subscription_id = stripe_event.data.object.id
          subscription = Subscription.find_or_create_by(user: user, stripe_subscription_id: subscription_id)
          subscription.active!
          WelcomeMailer.send_welcome_email(user)
          user.broadcast_replace_to(user, partial: "subscriptions/success/success", target: ActionView::RecordIdentifier.dom_id(user, :success))
        end
      when 'invoice.payment_failed'
      # Inform the user of failed payment
      when 'customer.subscription.deleted'
        # Do something when deleted
      end
    end
  end
end