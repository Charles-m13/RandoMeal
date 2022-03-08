import { preventOverflow } from "@popperjs/core"
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['day']

  unlockDays() {
    return this.dayTargets.filter(x => !x.classList.contains('locked'))
  }

  replaceCardHtml(recipeCardHtml) {
    const currentDayElements = this.unlockDays()
    recipeCardHtml.forEach((recipeCardHtml, index) => {
      const currentDayElement = currentDayElements[index]
      currentDayElement.querySelector('.card-recipe').outerHTML = recipeCardHtml
    })
  }

  randomize() {
    fetch('/plans/refresh')
      .then(response => response.json())
      .then((data) => this.replaceCardHtml(data.recipe_cards))
  }
}
