(function ($) {

/**
 * Attaches the multivariate test form behavior.
 */
Drupal.behaviors.multivariateTestForm = {
  attach: function(context) {
    $('.variants-number-control-show:not(.processed)', context).each(function (i, v) {
      var $varShowControl = $(v).addClass('processed');
      var $varNumControl = $varShowControl.siblings('.variants-number-control');
      $varShowControl.show();
      $varNumControl.hide();
      $varShowControl.find('a.variant-change').click(function () {
        $varShowControl.hide();
        $varNumControl.show();
        return false;
      });
    });
  }
};

})(jQuery);
