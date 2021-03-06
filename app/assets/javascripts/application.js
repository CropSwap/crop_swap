// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .

// Profile tabs

$('.nav-tabs a').click(function (e) {
  e.preventDefault()
  $(this).tab('show')
});

$('.nav-tabs a a[href="#my-swap-crops"]').tab('show')
$('.nav-tabs a a[href="#my-crops"]').tab('show')
$('.nav-tabs a a[href="#my-swaps"]').tab('show')

// Wishlist button

$(function() {
  $(".wishlist-shared a").css({"color": "gray"});
  $(".wishlist-shared a").on("click", function (){
    $(this).addClass("wishlisted").css("color", "#d37538");
  })
});

$(function() {
  $(".wishlisted a").css({"color": "#d37538"});
  $(".wishlisted a").on("click", function (){
    $(this).removeClass("wishlisted").css("color", "gray").closest(".card").fadeOut();
  })
});
