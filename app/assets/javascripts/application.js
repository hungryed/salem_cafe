// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require pickadate/picker
//= require pickadate/picker.date
//= require_tree .

$('.datepickering').pickadate();

$(function(){
  $(document).foundation();

  //$('[section-order-id]').on('click', '[data-order-complete-button="complete"]', function(event) {
  $('.order-actions').on('submit', '.order-complete-button', function(event) {

    event.preventDefault();
    $target = $(event.target);
    var url = $target.attr('action');

    $.ajax({
      type: "PUT",
      url: url,
      dataType: "json",
      success: function(order) {
        $target.closest('.order').toggleClass('order-completed');
      },
      failure: function(data) {
        console.log(data);
      }
    });
  });

  $('.order-actions').on('submit', '.order-working-button', function(event) {

    event.preventDefault();
    $target = $(event.target);
    var url = $target.attr('action');

    $.ajax({
      type: "PUT",
      url: url,
      dataType: "json",
      success: function(order) {
        $target.closest('.order').toggleClass( "order-progress" );
      },
      failure: function(data) {
        console.log(data);
      }
    });
  });
});
