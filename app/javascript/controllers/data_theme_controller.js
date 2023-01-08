import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="data-theme"
export default class extends Controller {
  connect() {
    let themeButton = document.getElementById("themeButton")
    let theme = "light"
    themeButton.addEventListener("click", function () {
      if (theme === "light") {
        document.documentElement.setAttribute("data-bs-theme", "dark")
        theme = "dark"
        themeButton.innerHTML = "Dark"
      } else {
        document.documentElement.setAttribute("data-bs-theme", "light")
        theme = "light"
        themeButton.innerHTML = "Light"
      }
    })
  }
}
