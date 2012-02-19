/**
 * DropDown jQuery Plugin v1.0
 * 
 * Created by Andrew Timney, http://www.andytimney.com
 */

$(function(){
  
  $.fn.dropdown = function(options){
    
    var opts  = $.extend({}, $.fn.dropdown.defaults, options);
    
    $('.'+opts.optionClassName).die('click');
    $('.'+opts.optionClassName).live('click', function(e){
      var img = $(this).children('img:first');
      var isChecked = false;
      if(img.attr('src') === opts.checkedImage){
        img.attr('src', opts.image);
      }else{
        img.attr('src', opts.checkedImage);
        isChecked = true;
      }
      opts.itemClick($(this).text(), $(this).attr('id'), isChecked);
      e.preventDefault();
    });
      
    return this.each(function(i){
      var button = $(this);
      $(button).click(function(e){
        
        var offset = $(this).parent().offset();
              var top = offset.top + opts.positionOffset;
        
        if ($('.'+opts.className).length > 0) {
                  $('.'+opts.className).remove();
              }else{
          
          $('<div class="'+opts.className+'"></div>')
          .css({ top: top, left: offset.left })
          .appendTo('body');
          
          $.each(opts.items, function(i, item){
            var image = opts.image;
            if (item.isChecked)
              image = opts.checkedImage;
            $('<div class="'+opts.optionClassName+'" id="' + item.key + '" ><img src="' + image + '" alt="checkbox" />' + item.value + '</div>')
                        .appendTo('.'+opts.className);
          });
          $('.'+opts.className).show();
        }
        e.preventDefault();
      });
    });
    
  };
  
  $.fn.dropdown.defaults = {
    items:[],
    image:'/images/jquery.dropdown/checkbox.png',
    checkedImage:'/images/jquery.dropdown/checked.png',
    positionOffset: 20,
    className: 'dropDownMenu',
    optionClassName: 'optionCheckbox',
    itemClick: function(key, value, isChecked){}
  };
  
});