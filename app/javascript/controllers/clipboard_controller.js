import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="clipboard"
export default class extends Controller {
  static targets = ["input", "success", "copy"]
  
  copy(event) {
    event.preventDefault()
    // Get the text field  
    this.inputTarget.select();
    this.inputTarget.setSelectionRange(0, 99999); // For mobile devices

    navigator.clipboard.writeText(this.inputTarget.value);
    this.copyTarget.classList.add("hidden")
    this.successTarget.classList.remove("hidden")
    setTimeout(() => {
      this.copyTarget.classList.remove("hidden")
      this.successTarget.classList.add("hidden")
    }, 1500)
  }
}
