import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="apply-filter"
export default class extends Controller {
  connect() {
    this.element.addEventListener("change", this.submitForm.bind(this));
  }

  submitForm() {
    this.element.requestSubmit();
  }
}
