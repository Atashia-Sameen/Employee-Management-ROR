import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="timeout-alert"
export default class extends Controller {
  connect() {
    console.log("conneted to stimulus");

    setTimeout(() => {
      this.element.remove();
    }, 2000);
  }
  
  disconnect() {
    console.log("disconneted to stimulus");
    clearTimeout(this.timeout);
  }
}
