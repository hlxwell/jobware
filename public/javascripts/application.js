// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function(){
  show_and_hide_ajax_loading_bar();
  
  if (navigator.platform != "iPad") {
    $("img.lazyload").lazyload({
      effect : "fadeIn",
      threshold : 200,
      placeholder : "/images/lazyload.gif"
    });
  }

  $.each($(".city_selector"), function(i, n){ $(n).CitySelector(); });

  $(".datepicker").datepicker();

  $(".stars-wrapper").stars({
      // captionEl: $(".stars-cap"),
      callback: function(ui, type, value){
        $(".stars-wrapper").closest("form").submit();
      }
  });

  // top page slider
  $('#slider-center').coinslider({
    width: 510,
    height: 250,
    navigation: true,
    delay: 3000,
    effect: 'swirl', // random, swirl, rain, straight
    sDelay: 10 // delay beetwen squares in ms
    // hoverPause: true
    // opacity: 0.7, // opacity of title and navigation
    // titleSpeed: 500, // speed of title appereance in ms
    // navigation: true, // prev next and buttons
    // links : true, // show images as links
  });

  // form tip for normal form
  $("form [title]:not(#search_term)").tipsy({fade: true, trigger: 'focus', gravity: 'w', title: 'title'});
  $(".with_tooltip").tipsy({trigger: 'hover', gravity: 's', title: 'title'});

  // form tip for search input
  $("form input#search_term").formtips({ tippedClass: 'tipped' });

  $(".transaction-list").tabs({
    ajaxOptions: {
      error: function(xhr, status, index, anchor) {
        $(anchor.hash).html("加载列表出错，请稍后再试。");
      }
    }
  });

  $(".show_dialog").click(function(){
    $(".dialog-modal").dialog({
      width: 500,
      height: 350,
      modal: true
    });
  });

  $("#slider").easySlider({
    prevText:'前一页',
    nextText:'后一页',
    orientation:'vertical',
    pager_put_at: '#pager',
    speed: 200
  });

  $(".optional_option_tag").click(function(){
    if($(this).parent().parent().prev('div').children('fieldset').find("input[value=" + $(this).html() + "]").length > 0) {
      alert("该项已经存在。");
    } else {
      $(this).parent().parent().prev('div').children("input").click();
      $(this).parent().parent().prev('div').children('fieldset').last().find("input:text:first").val($(this).html());
      $(this).parent().parent().prev('div').children('fieldset').last().find("input:text:last").val($(this).attr('desc'));
    }
  });

  $(".copy_options_from_other_job").click(function(){
    var job_id           = $(this).prev("select").val();
    var copy_option_type = $(this).attr("option_type");
    var add_item_button  = $(this).parent().parent().find('input[value=添加自定义项]');

    $.get("/company/jobs/"+job_id+"/get_options", {'type':copy_option_type}, function(data){
      $.each( data, function(i, item){
        exist_item_name_input = add_item_button.parent().children('fieldset').find("input[value=" + item[0] + "]");
        exist_item_desc_input = exist_item_name_input.parents('fieldset.optional_option').find("input[value=" + item[1] + "]");

        if(exist_item_name_input.length == 0 || exist_item_desc_input.length == 0) {
          add_item_button.click();
          add_item_button.prev('fieldset').find("input:text:first").val(item[0]);
          add_item_button.prev('fieldset').find("input:text:last").val(item[1]);
        }
      });
    });
  });

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

function add_fields(link, association, content) {
  if( $(link).parent().children("fieldset").size() == 0 ) {
    $(link).parent().children("div.notice").fadeOut("slow");
  }

  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).before(content.replace(regexp, new_id));
  $("#" + new_id).hide().fadeIn("slow");
  $("#" + association + "_notice").fadeOut("show");
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

function hide_fields(link) {
  $(link).next("input[type=hidden]").val("1");
  $(link).closest("fieldset").fadeOut("slow");
}