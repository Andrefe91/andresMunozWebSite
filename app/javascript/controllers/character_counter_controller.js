import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="character-counter"
export default class extends Controller {
  static targets = ["field", "counter"]

  connect() {
    this.updateCount()
  }

  updateCount() {
    const text = this.fieldTarget.value.trim()
    const wordCount = text ? text.length : 0
    this.counterTarget.textContent = wordCount
  }
}
