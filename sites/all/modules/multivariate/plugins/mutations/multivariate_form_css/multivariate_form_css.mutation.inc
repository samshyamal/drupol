<?php

/**
 * @file
 * Form CSS mutation settings form.
 */

/**
 * Returns mutation settings form.
 * 
 * @param array $values
 *   Array that holds form default values. It also hold additional helper
 *   values - like $values['variant_id'] which indicates key of current variant
 *   in array.
 */
function multivariate_form_css_settings_form(array $values) {
  $form = array();
  if ($values['variant_id'] == 0) {
    $form['form_id'] = array(
      '#type' => 'textfield',
      '#title' => t('Form id'),
      '#default_value' => isset($values['form_id']) ? $values['form_id'] : '',
      '#description' => t('Enter Drupal form id. Can be any Drupal form including Webforms also.'),
    );
  }
  $form['form_css_classes'] = array(
    '#type' => 'textfield',
    '#title' => t('CSS classes'),
    '#default_value' => isset($values['form_css_classes']) ? $values['form_css_classes'] : '',
    '#description' => t('Enter CSS classes.'),
  );
  $form['form_inline_css'] = array(
    '#type' => 'textfield',
    '#title' => t('Inline CSS'),
    '#default_value' => isset($values['form_inline_css']) ? $values['form_inline_css'] : '',
    '#description' => t('Enter inline CSS styles.'),
  );
  return $form;
}
