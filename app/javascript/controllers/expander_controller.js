import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "output" ]

  connect() {
    // event listener (en stimulus) sur le click de la flèche bas
    // au click on appel la method expand
    // dans cette methode on enlève la height de la card
    this.expand = false;

  }

  expandcard() {
    this.expand = !this.expand;
    this.outputTarget.classList.toggle('expand', this.expand);
  }
}
