import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    initialize() {
        console.log("ResetFormController initializing, please wait...");
    }

    connect() {
        console.log("ResetFormController connected!");
    }

    reset() {
        this.element.reset();
    }
}