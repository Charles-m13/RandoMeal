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
    let toggleButton = true
    this.dayTargets.forEach((day) => {
      if(day.classList.contains('unlocked')) {
        toggleButton = false
      }
    })
    if (toggleButton) {
      this.export1Target.classList.add('d-none')
      this.export2Target.classList.remove('d-none')
    } else {
      this.export2Target.classList.add('d-none')
      this.export1Target.classList.remove('d-none')
    }
  }

  remainingRecipesToUnlock(event) {
    if (event.currentTarget.parentNode.classList.contains('unlocked')) {
      console.log("je décrémente")
      this.countrecipeTarget.innerHTML ++
    }
    if (!event.currentTarget.parentNode.classList.contains('unlocked')) {
      console.log("j'incrémente")
      this.countrecipeTarget.innerHTML --
    }
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
