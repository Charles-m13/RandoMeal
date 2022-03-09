import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "quantity","input" ]

  connect() {

  }

  increase(event) {
    event.preventDefault()
    this.inputTarget.innerHTML ++
    this.quantityTargets.forEach(quantity => {
      quantity.innerHTML = this.inputTarget.innerHTML * (quantity.innerHTML / (this.inputTarget.innerHTML - 1))
    });
    
  }
  decrease(event) {
    event.preventDefault()
    if (this.inputTarget.innerHTML > 1) {
      this.quantityTargets.forEach(quantity => {
        quantity.innerHTML = (quantity.innerHTML / this.inputTarget.innerHTML) * (this.inputTarget.innerHTML - 1)
      });
      this.inputTarget.innerHTML --
    }
  }
}
