// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import 'bootstrap'
import '../stylesheets/application'
import "channels"

function initMoveInputs(moveInputs) {
  moveInputs.forEach((move)=> {
    document.getElementById(move).addEventListener("click", (event) => {
      unselectItems(moveInputs);

      event.currentTarget.classList.add("selected_button");
      document.getElementById("move").value = move;
    });
  })

  function unselectItems(items) {
    items.forEach((item) => {
      document.getElementById(item).classList.remove("selected_button");
    })
  }
}

Rails.start()
window.initMoveInputs = initMoveInputs;
ActiveStorage.start()