import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="timeout-alert"
export default class extends Controller {
  connect() {
    setTimeout(() => {
      this.element.remove();
    }, 2000);
  }
  
  disconnect() {
    clearTimeout(this.timeout);
  }
}
