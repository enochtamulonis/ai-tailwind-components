import { Controller } from "@hotwired/stimulus"
import { loadStripe } from '@stripe/stripe-js';
import { post } from "@rails/request.js"
// Connects to data-controller="stripe-purchase"
export default class extends Controller {
  static values = {
    paymentIntentUrl: String,
    successUrl: String,
  }
  static targets = ["container", "submit", "spinner", "message"]

  async initialize() {
    this.initialSubmitHTML = this.submitTarget.innerHTML
    this.stripe = await loadStripe(this.publicStripeKey);
    const response = await post(this.paymentIntentUrlValue, {
      responseKind: "json",
    })
    if (response.ok) {
      const json = await response.json
      this.clientSecret = json.clientSecret
    }

    this.elements = this.stripe.elements({
      clientSecret: this.clientSecret,
    });

    const paymentElement = this.elements.create("payment")
    paymentElement.on("ready", () => {
      this.submitTarget.classList.remove("hidden")
    })
    paymentElement.mount(this.containerTarget)
  }

  async submit(e) {
    e.preventDefault();
    this.submitTarget.innerHTML = "<i class='fa fa-spinner fa-spin'> processing transaction </i>"
    const elements = this.elements
    const { error } = await this.stripe.confirmPayment({elements,
      confirmParams: {
        // Make sure to change this to your payment completion page
        return_url: this.successUrlValue,
      },
    });

    // This point will only be reached if there is an immediate error when
    // confirming the payment. Otherwise, your customer will be redirected to
    // your `return_url`. For some payment methods like iDEAL, your customer will
    // be redirected to an intermediate site first to authorize the payment, then
    // redirected to the `return_url`.
    if (error.type === "card_error" || error.type === "validation_error") {
      this.messageTarget.textContent = error.message
    } else {
      this.messageTarget.textContent = "An unexpected error occured."
    }

    this.submitTarget.innerHTML = this.initialSubmitHTML
  }

  async connect() {
     const clientSecret = new URLSearchParams(window.location.search).get(
      "payment_intent_client_secret"
    );

    if (!clientSecret) {
      return;
    }

    const { paymentIntent } = await this.stripe.retrievePaymentIntent(clientSecret);

    switch (paymentIntent.status) {
      case "succeeded":
        this.messageTarget.textContent = "Payment succeeded!"
        break;
      case "processing":
        this.messageTarget.textContent = "Your payment is processing."
        break;
      case "requires_payment_method":
        this.messageTarget.textContent = "Your payment was not successful, please try again."
        break;
      default:
        this.messageTarget.textContent = "Something went wrong."
        break;
    }
  }

  get publicStripeKey() {
    let stripeMeta = document.querySelector("meta[name='stripe-public-key']")
    let key = stripeMeta.getAttribute("content")
    return key
  }
}
