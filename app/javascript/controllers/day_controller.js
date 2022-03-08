import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['day']
  static values = {
    recipeId: Number
  }

  connect() {
    this.locked = false
  }

  toggleLock() {
    this.locked = !this.locked
    this.dayTarget.classList.toggle('locked', this.locked)
    const csrfToken = document.querySelector("[name='csrf-token']").content;
    const method = this.locked ? 'add' : 'remove'
    const url = `/plans/${method}?recipe_id=${this.recipeIdValue}`

    fetch(url, {
     method: 'POST',
     headers:  {
        "X-CSRF-Token": csrfToken
     }
   })
  }
}
