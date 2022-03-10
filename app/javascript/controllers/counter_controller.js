import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "quantity","input", "buttons" ]
  static values = {
    people: Number
  }

  connect() {
    this.peopleReference = this.peopleValue
    this.locked = false
  }

  lock() {
    console.log("je suis dans counter controller lock")
    this.locked = true
    this.buttonsTarget.classList.add("block")
  }

  unlock() {
    console.log("je suis dans counter controller unlock")
    this.locked = false
    this.buttonsTarget.classList.remove("block")
  }

  increase(event) {
    if (!this.locked) {
      this.peopleValue++
      this.peopleUpdated()
    }
  }

  decrease(event) {
    if (!this.locked && this.peopleValue > 1) {
      this.peopleValue --
      this.peopleUpdated()
    }
  }

  peopleUpdated() {
    this.updateQuantities()
    const event = new CustomEvent('peopleUpdated', { detail: this.peopleValue });
    this.element.dispatchEvent(event);
  }

  updateQuantities() {
    this.inputTarget.innerHTML = this.peopleValue
    this.quantityTargets.forEach(quantityTarget => {
      if (quantityTarget.dataset.quantity != '')
        quantityTarget.innerHTML = (this.peopleValue * (quantityTarget.dataset.quantity / this.peopleReference)).toFixed(1)
    });
  }
}
