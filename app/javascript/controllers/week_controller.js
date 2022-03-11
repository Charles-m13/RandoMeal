import { preventOverflow } from "@popperjs/core"
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['day', 'filter', 'export1', 'export2', 'countrecipe']

  connect() {
    this.export = false
  }

  toggleActive(event) {
    this.filterTargets.forEach((filterElement) => {
      if (filterElement == event.currentTarget)
        filterElement.classList.toggle('active')
      else
        filterElement.classList.remove('active')
    })
    this.randomize()
  }

  activeFilter() {
    const filterElement = this.filterTargets.find(fe => fe.classList.contains('active'))
    if (filterElement)
      return filterElement.dataset.filter
  }

  toggleExport() {
    const is_all_locked = this.dayTargets.every(x => x.classList.contains('locked'))
    this.export1Target.classList.toggle('d-none', is_all_locked)
    this.export2Target.classList.toggle('d-none', !is_all_locked)
  }

  remainingRecipesToUnlock() {
    const remaining = 5 - this.dayTargets.filter(x => x.classList.contains('locked')).length
    this.countrecipeTarget.innerHTML = remaining
  }

  unlockDays() {
    return this.dayTargets.filter(x => !x.classList.contains('locked'))
  }

  replaceCardHtml(recipeCardHtml) {
    const currentDayElements = this.unlockDays()
    recipeCardHtml.forEach((recipeCardHtml, index) => {
      const currentDayElement = currentDayElements[index]
      currentDayElement.querySelector('.card-recipe').outerHTML = recipeCardHtml

      const recipeCard = currentDayElement.querySelector('.card-recipe')
      const event = new CustomEvent('recipeIdChanged', { detail: recipeCard.dataset.recipeId });
      currentDayElement.dispatchEvent(event)
    })
  }

  keyUp(e) {
    if (e.code == "Space")
      this.randomize()
  }


  randomize() {
    const filter = this.activeFilter() ? `filter=${this.activeFilter()}` : ''
    fetch(`/plans/refresh?${filter}`, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
      }
    })
      .then(response => response.json())
      .then((data) => this.replaceCardHtml(data.recipe_cards))
  }
}
