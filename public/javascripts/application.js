// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function(){
  $.each($(".city_selector"), function(i, n){ $(n).CitySelector(); });

  $(".datepicker").datepicker('option', {showAnim: "show"});

  $(".stars-wrapper").stars({
      // captionEl: $(".stars-cap"),
      callback: function(ui, type, value){
        $(".stars-wrapper").closest("form").submit();
      }
  });

  // top page slider
  $('#slider-center').coinslider({
    width: 520,
    height: 200,
    navigation: true,
    delay: 5000,
    effect: 'random'
  });

  // form tip for normal form
  $("form [title]:not(#search_term)").tipsy({fade: true, trigger: 'focus', gravity: 'e', title: 'title'});

  // form tip for search input
  $("form input#search_term").formtips({ tippedClass: 'tipped' });

  // adjust company logo size
  // $(".post .company_logo").each(function() {
  //   //Get the width of the image
  //   var width = $(this).width();
  // 
  //   //Max-width substitution (works for all browsers)
  //   if (width > 100) {
  //     $(this).css("width", "100px");
  //   }
  // });

  show_and_hide_ajax_loading_bar();
});

function show_and_hide_ajax_loading_bar() {
  $("#loading").ajaxStart(function(){
    $(this).slideDown("fast");
  });

  $("#loading").ajaxStop(function(){
    $(this).slideUp("fast");
  });
}

function show_tooltip() {
  $('form [title]').tipsy({fade: true, trigger: 'manual', gravity: 'e'});
  $("input, select, radio, textarea").each(function(){ $(this).tipsy("show") });
}

function hide_fields(link) {
  $(link).next("input[type=hidden]").val("1");
  $(link).closest("fieldset").fadeOut("slow");
}

function remove_fields(link) {
  $(link).closest("fieldset").fadeOut("slow", function(){
    // if it's the last one, then show notice message
    if( $(link).parent().parent().children("fieldset").size() == 1 ) {
      $(link).parent().parent().children("div.notice").fadeIn("slow");
    }
    $(this).remove();
  });
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).before(content.replace(regexp, new_id));
  $("#" + new_id).hide().fadeIn("slow");
  $("#" + association + "_notice").fadeOut("show");
}
