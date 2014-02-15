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
//= require_self
$('.datepickering').pickadate();

$(function(){
  $(document).foundation();
    var visibleDivs = $('.section-tabs');
    var targetWidth = 100 / visibleDivs.children('dd').length;
    tabArray = visibleDivs.children('dd')
    for (var i = 0; i < tabArray.length; i++) {
      $(tabArray[i]).addClass('expand');
    }
    if (($('.tabs').css('width') < "625px") && window.innerWidth < 650) {
      $('.expand').css('width', '100%');
    } else {
      $('.expand').css('width', targetWidth + '%');
    }
    $(window).resize(function(){
      if (($('.tabs').css('width') < "625px") && window.innerWidth < 650) {
        $('.expand').css('width', '100%');
      } else {
        $('.expand').css('width', targetWidth + '%');
      }
    });

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

// window.onload = function() {
//   var sectionDivs = $('.section-wrapper')
//   sectionsArray = sectionDivs.children('h3')
//   for (var i = 0; i < sectionsArray.length; i++) {
//     panelHeight = sectionsArray[i].parentNode.parentNode.parentNode.parentNode.clientHeight;
//     sectionsArray[i].style["margin-top"] = panelHeight / 4
//   }
// }

