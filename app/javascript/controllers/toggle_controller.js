import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["field", "eye", "eyeSlash"]

  change() {
    let isActive = this.fieldTarget.value === "true";
    this.fieldTarget.value = isActive ? "false" : "true";
    
    this.eyeTarget.classList.toggle("hidden", isActive);
    this.eyeSlashTarget.classList.toggle("hidden", !isActive);
  }
}
