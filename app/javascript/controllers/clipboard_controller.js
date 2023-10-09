import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="clipboard"
export default class extends Controller {
  static targets = ["input"]
  add() {
    // Get the text field  
    // Select the text field
    this.inputTarget.select();
    this.inputTarget.setSelectionRange(0, 99999); // For mobile devices
  
      // Copy the text inside the text field
    navigator.clipboard.writeText(this.inputTarget.value);
  
    // Alert the copied text
    alert("Copied the text: " + this.inputTarget.value);
  
  }
}
