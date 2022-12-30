import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="versions"
export default class extends Controller {
  initialize() {
    console.log("Versions controller connecting...")
  }

  connect() {
    console.log("Versions controller connected")
  }
}
