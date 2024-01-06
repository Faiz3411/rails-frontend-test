// app/javascript/controllers/sortable_controller.js

import { Controller } from "@hotwired/stimulus";
import Sortable from "sortablejs";

export default class extends Controller {
  static targets = ["output"];

  connect() {
    this.sortable = new Sortable(this.element, {
      onEnd: this.updateOrder.bind(this),
    });
  }

  updateOrder(event) {
    const url = this.element.dataset.sortableUrlValue;

    let orderedIds = Array.from(this.element.children).map((child, index) => ({
      id: child.id.split('_')[1],
      ordering: index + 1
    }));

    fetch(url, {
      method: "PATCH",
      headers: {
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content,
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: JSON.stringify({ reasons: orderedIds }),
      credentials: "include",
    }).then(response => {
      if (response.ok) {
        console.log("Order updated");
      } else {
        console.error("Error updating order");
      }
    });
  }

  disconnect() {
    this.sortable.destroy();
  }
}
