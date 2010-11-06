if(document.createElement && document.getElementById && document.createTextNode && typeof JobletWidget != 'undefined' ) {
  JobletWidget.size.width  = Math.max(JobletWidget.size.width, 150);
  JobletWidget.size.height = Math.max(JobletWidget.size.height,140);
  JobletWidget.type        = JobletWidget.type || 'flashWidget';
  for (var i in JobletWidget.color) { JobletWidget.color[i] = JobletWidget.color[i].replace(/^(#)?(\w)(\w)(\w)$/,"$1$2$2$3$3$4$4"); }
  var isIE = !+"\v1";
  // Widget Modes
  with (JobletWidget) {
    var Widgets = {
      flashWidget : function () {
        with (color) {
          var lang   = JobletWidget.lang;
          var vars   = 'title_color=' + title + '&frame_color=' + title_bg + '&content_color=' + content + '&content_bg_color=' + content_bg + '&service_url=' + joblet_url + '/jobs.xml';
          var widget = '<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"                          \
                          id="joblet_ads_widget" width="' + size.width + '" height="' + size.height + '"      \
                          codebase="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab">    \
                          <param name="movie" value="' + joblet_url + '/flash_widget/joblet_ads_widget.swf" />\
                          <param name="quality" value="high" />                                               \
                          <param name="bgcolor" value="#ffffff" />                                            \
                          <param name="allowScriptAccess" value="always" />                                   \
                          <param name="flashvars" value="' + vars + '">                                       \
                          <embed src="' + joblet_url + '/flash_widget/joblet_ads_widget.swf" quality="high" bgcolor="#ffffff" \
                            width="' + size.width + '" height="' + size.height + '" name="joblet_ads_widget" align="middle" \
                            play="true"                                                                       \
                            loop="false"                                                                      \
                            quality="high"                                                                    \
                            flashvars="' + vars + '"                                                          \
                            allowScriptAccess="always"                                                        \
                            type="application/x-shockwave-flash"                                              \
                            pluginspage="http://www.adobe.com/go/getflashplayer"/>                            \
                        </object>';
          var tmp_elem = document.createElement('span');
          tmp_elem.innerHTML = widget;
          return tmp_elem.childNodes[0];
        }
      }
    }
  }

  // get joblet url from src attr of script
  var elem       = document.getElementById('joblet_sidebar_widget');
  var joblet_url = elem.getAttribute('src').replace(/((\w+):\/\/[^\/]*)\/.*/,'$1');
  if (!joblet_url.match(/^http/)) joblet_url = location.protocol + '//' + location.host;

  var parent     = elem.parentNode || elem.parentElement;
  parent.replaceChild(Widgets[JobletWidget.type].apply(), elem); // replace script element with iframe
}