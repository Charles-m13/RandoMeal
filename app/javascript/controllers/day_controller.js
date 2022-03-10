import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['day', 'nbPerson','increase','decrease']
  static values = {
    recipeId: Number,
    people: Number
  }

  connect() {
    this.locked = false
  }

  peopleUpdated(event) {
    this.peopleValue = event.detail
  }

  toggleLock() {
    this.locked = !this.locked
    this.element.classList.toggle('locked', this.locked)

    this.element.dispatchEvent(new Event(this.locked ? 'lock' : 'unlock'));
    this.element.dispatchEvent(new Event('toggleLock'));

    const nbPerson = this.peopleValue
    const csrfToken = document.querySelector("[name='csrf-token']").content;
    const method = this.locked ? 'add' : 'remove'
    const url = `/plans/${method}?recipe_id=${this.recipeIdValue}&nb_person=${nbPerson}`

    fetch(url, {
      method: 'POST',
      headers:  {
        "X-CSRF-Token": csrfToken
      }
    })
  }
}
