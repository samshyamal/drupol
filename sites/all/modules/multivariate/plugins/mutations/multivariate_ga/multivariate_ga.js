(function ($) {

/**
 * GA mutation js part - creating track event.
 */

// Ready event can be fired more then one when we are sending mutation ga events
// over ajax (for example ctools modal forms), but because we are removing 
// pushed events from our events array we will not do multiple pushing.
$(document).ready(function () {
  // When executing each ga event we will remove pushed events from our events
  // array. We are doing this so we can support ajax ga events - for example
  // ctools modal forms and similar. Removing pushed events will ensure that 
  // we don't push this events multiple times.
  var gaEvent;
  while(typeof (gaEvent = Drupal.settings.multivariate_ga.events.shift()) !== 'undefined') {
    _gaq.push(['_trackEvent', gaEvent.ga_event_category, gaEvent.ga_event_action, gaEvent.ga_event_label]);
  }
});

})(jQuery);
