// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function(){
  $.each($(".city_selector"), function(i, n){ $(n).CitySelector(); });

  $(".datepicker").datepicker();

  $(".stars-wrapper").stars({
      // captionEl: $(".stars-cap"),
      callback: function(ui, type, value){
        $(".stars-wrapper").closest("form").submit();
      }
  });

  $('#slider').coinslider({
    width: 670,
    height: 300,
    navigation: true,
    delay: 5000,
    effect: 'random'
  });

  $("form [title]:not(#search_term)").tipsy({fade: true, trigger: 'focus', gravity: 'e', title: 'title'});
  
  $("form input#search_term").formtips({ tippedClass: 'tipped' });
});

function show_tooltip() {
  $('form [title]').tipsy({fade: true, trigger: 'manual', gravity: 'e'});
  $("input, select, radio, textarea").each(function(){ $(this).tipsy("show") });
}

function hide_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest("fieldset").fadeOut("slow");
}

function remove_fields(link) {
  $(link).closest("fieldset").fadeOut("slow", function(){ $(this).remove() });
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).before(content.replace(regexp, new_id));
  $("#" + new_id).hide().fadeIn("slow");
}
