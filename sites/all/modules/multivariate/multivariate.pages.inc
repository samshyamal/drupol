<?php

/**
 * @file
 * Page callbacks.
 */

/**
 * Multivariate test view callback.
 */
function multivariate_view($test) {
  drupal_set_title(entity_label('multivariate_test', $test));
  return entity_view('multivariate_test', array(entity_id('multivariate', $test) => $test), 'full');
}
