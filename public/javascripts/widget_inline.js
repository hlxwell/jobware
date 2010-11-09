if(document.createElement && document.getElementById && document.createTextNode && typeof JobletWidget != 'undefined' ) {
  JobletWidget.size.width  = Math.max(JobletWidget.size.width, 600);
  JobletWidget.size.height = Math.max(JobletWidget.size.height, 72);
  JobletWidget.type        = JobletWidget.type || 'flashWidget';

  var isIE = !+"\v1";
  // Widget Modes
  with (JobletWidget) {
    var Widgets = {
      flashWidget : function () {
        var frameUrl  = joblet_url + '/inline_widget?content=' + content;
        var frame = document.createElement('iframe');
        frame.setAttribute('width' ,size.width);
        frame.setAttribute('height',size.height);
        frame.setAttribute('scrolling', 'no');
        frame.setAttribute('src',frameUrl);
        frame.style.border = "1px #ccc solid";
        return frame;
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