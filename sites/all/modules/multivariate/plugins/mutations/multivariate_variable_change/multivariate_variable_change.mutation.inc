<?php

/**
 * @file
 * Multivariate variable change mutation settings.
 */

/**
 * Returns muatation settings form.
 * 
 * @param array $values
 *   Array that holds form default values. It also hold additional helper
 *   values - like $values['variant_id'] which indicates key of current variant
 *   in array.
 */
function multivariate_variable_change_settings_form(array $values) {
  $form = array();
  if ($values['variant_id'] == 0) {
    $form['variable_name'] = array(
      '#type' => 'textfield',
      '#title' => t('Variable name'),
      '#autocomplete_path' => 'multivariate_variable/autocomplete',
      '#default_value' => isset($values['variable_name']) ? $values['variable_name'] : '',
      '#description' => t('Drupal system variable name.'),
      // @todo: js completition part and then also setting default value for
      // first mutation value.
    );
  }
  $form['variable_value'] = array(
    '#type' => 'textfield',
    '#title' => t('Variable value'),
    '#default_value' => isset($values['variable_value']) ? $values['variable_value'] : '',
  );
  return $form;
}
