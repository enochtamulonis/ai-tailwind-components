import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="auto-disappear"
export default class extends Controller {
  connect() {
    setTimeout(() => {
      this.element.remove()
    }, 4000)
  }
}
