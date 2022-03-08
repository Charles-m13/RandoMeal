import { preventOverflow } from "@popperjs/core"
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['day', 'filter']

  connect() {
    this.locked = false
  }

  toggleLock() {
    this.locked = !this.locked
    this.filterTarget.classList.toggle('locked', this.locked)
  }

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
    console.log(this.filter)
    fetch(`/plans/refresh?filter=${this.filter}`, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
      }
    })
      .then(response => response.json())
      .then((data) => this.replaceCardHtml(data.recipe_cards))
  }

  addFilter(event) {
    this.filter = event.target.dataset.filter
    this.toggleLock()
  }
}
