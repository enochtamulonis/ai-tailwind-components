import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="highlight"
export default class extends Controller {
  connect() {
    hljs.highlightAll();
  }
}
