if(document.createElement && document.getElementById && document.createTextNode && typeof JobletWidget != 'undefined' ) {
  JobletWidget.size.width  = Math.max(JobletWidget.size.width, 600);
  JobletWidget.size.height = Math.max(JobletWidget.size.height, 72);
  JobletWidget.type        = JobletWidget.type || 'flashWidget';
  for (var i in JobletWidget.color) { JobletWidget.color[i] = JobletWidget.color[i].replace(/^(#)?(\w)(\w)(\w)$/,"$1$2$2$3$3$4$4"); }
  var isIE = !+"\v1";
  // Widget Modes
  with (JobletWidget) {
    var Widgets = {
      flashWidget : function () {
        var htmlWidgetColor = {};
        for (var i in JobletWidget.color) {
          htmlWidgetColor[i] = JobletWidget.color[i].replace(/^(#)/,"");
        }

        with(htmlWidgetColor) {
          var frameUrl  = joblet_url + '/inline_widget?content=' + content + '&content_bg=' + content_bg;
          var frame = document.createElement('iframe');
          frame.setAttribute('width' ,size.width);
          frame.setAttribute('height',size.height);
          frame.setAttribute('scrolling', 'no');
          frame.setAttribute('src',frameUrl);
          frame.style.border = "solid 1px #" + title_bg;
          return frame;
        }
      }
    }
  }

  // get joblet url from src attr of script
  var elem       = document.getElementById('joblet_inline_widget');
  var joblet_url = elem.getAttribute('src').replace(/((\w+):\/\/[^\/]*)\/.*/,'$1');
  if (!joblet_url.match(/^http/)) joblet_url = location.protocol + '//' + location.host;

  var parent     = elem.parentNode || elem.parentElement;
  parent.replaceChild(Widgets[JobletWidget.type].apply(), elem); // replace script element with iframe
}