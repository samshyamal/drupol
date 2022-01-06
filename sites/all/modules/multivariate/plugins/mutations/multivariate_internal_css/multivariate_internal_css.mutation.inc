<?php

/**
 * @file
 * Multivariate internal CSS mutation settings form.
 */

/**
 * Returns mutation settings form.
 * 
 * @param array $values
 *   Array that holds form default values. It also hold additional helper
 *   values - like $values['variant_id'] which indicates key of current variant
 *   in array.
 */
function multivariate_internal_css_settings_form(array $values) {
  $form = array();
  $form['internal_css'] = array(
    '#type' => 'textarea',
    '#title' => t('Internal CSS'),
    '#default_value' => isset($values['internal_css']) ? $values['internal_css'] : '',
    '#description' => t('Enter internal CSS style sheet. Do not input &lt;style&gt; tag.'),
  );
  return $form;
}
