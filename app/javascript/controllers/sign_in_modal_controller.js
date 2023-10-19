import { Controller } from "@hotwired/stimulus";
import { post } from "@rails/request.js";
// Connects to data-controller="sign-in-modal"
export default class extends Controller {
  connect() {
    this.timeout = setTimeout(async () => {
      await post("/sign_in_modal");
    }, 10000);
  }
  disconnect() {
    if (this.timeout) {
      clearTimeout(this.timeout);
    }
  }
}
