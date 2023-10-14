import { Controller } from "@hotwired/stimulus"
import { post } from "@rails/request.js"
// Connects to data-controller="sign-in-modal"
export default class extends Controller {
  connect() {
    setTimeout(async () => {
      await post("/sign_in_modal")
    }, 5000) 
  }
}
