(function($) {

/**
 * Multivariate chart js drawing.
 */

$(document).ready(function() {
  var data = new Array();
  $.each(Drupal.settings.multivariate_chart.data, function(i, val) {
    data.push(new Array(val.ratio * 100, val.labels));
  });

  $.jqplot.config.enablePlugins = true;
  var plot = $.jqplot('multivariate-chart', [data], {
    // Only animate if we're not using excanvas (not in IE 7 or IE 8).
    // @todo - jquery is breaking here, ao.canvas._elem.jqplotEffect is not a 
    // function error.
    // animate: !$.jqplot.use_excanvas,
    seriesDefaults: {
      renderer: $.jqplot.BarRenderer,
      pointLabels: {
        show: true,
        location: 'e',
        edgeTolerance: -15,
        formatString: '%.2f'
      },
      rendererOptions: {
        barDirection: 'horizontal'
      },
      shadowAngle: 135
    },
    axes: {
      yaxis: {
        renderer: $.jqplot.CategoryAxisRenderer
      }
    },
    highlighter: {show: false}
  });

});

})(jQuery);
