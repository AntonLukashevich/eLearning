// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

//= require jquery3

//= require jquery-ui
//= require jquery-ui/widget
//= require jquery-ui/sortable
//= require popper
//= require bootstrap-sprockets
//= require trix

//= require_tree





import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import 'trix/dist/trix.css'
//import "app/javascript/youtube"


Rails.start()
Turbolinks.start()
ActiveStorage.start()


require("trix")
require("@rails/actiontext")
import "controllers"
import "youtube"



$(document).on('turbolinks:load', function() {
    setTimeout(function() {
        $('.alert').fadeOut('slow','swing');
    }, 5000);
})



