// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "day", "card-recipe" ]

  connect() {
    console.log("je suis dans le lockrecipe")
  }

  lock() {
    this.dayTargets.forEach(day => {
      if (day.classList.contains("locked")) {
        console.log("je suis blocked")
      }
    })

  }
}
// if (this.dayTarget.classList.contains("locked")) {
//   console.log("je suis locked");
// }
