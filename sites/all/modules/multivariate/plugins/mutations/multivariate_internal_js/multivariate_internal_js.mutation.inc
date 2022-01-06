<?php

/**
 * @file
 * Settings file for Internal Javascript mutation.
 */

/**
 * Returns mutation settings form.
 *
 * @param array $values
 *   Array that holds form default values. It also hold additional helper
 *   values - like $values['variant_id'] which indicates key of current variant
 *   in array.
 */
function multivariate_internal_js_settings_form(array $values) {
  $form = array();
  $form['internal_js'] = array(
    '#type' => 'textarea',
    '#title' => t('Internal Javascript'),
    '#default_value' => isset($values['internal_js']) ? $values['internal_js'] : '',
    '#description' => t('Enter internal Javascript without jQuery(document).ready wrapper. Do not input &lt;script&gt; tag.'),
  );
  $form['internal_js_scope'] = array(
    '#type' => 'select',
    '#title' => t('Internal Javascript scope'),
    '#options' => array(
      'header' => t('Header'),
      'footer' => t('Footer'),
    ),
    '#default_value' => isset($values['internal_js_scope']) ? $values['internal_js_scope'] : '',
    '#description' => t('The location in which you want to place the script.'),
  );
  return $form;
}
