<?php

/**
 * @file
 * Form submit success condition settings form.
 */

/**
 * Returns muatation settings form.
 * 
 * @param array $values
 *   Array that holds form default values. It also hold additional helper
 *   values.
 */
function multivariate_form_submit_sc_settings_form(array $values) {
  $form = array();
  $form['form_id'] = array(
    '#type' => 'textfield',
    '#title' => t('Form id'),
    '#default_value' => isset($values['form_id']) ? $values['form_id'] : '',
    '#description' => t('Enter Drupal form id.'),
  );
  $form['rebuild_disabled'] = array(
    '#type' => 'checkbox',
    '#title' => t('Rebuild disabled'),
    '#default_value' => isset($values['rebuild_disabled']) ? $values['rebuild_disabled'] : 1,
    '#description' => t('Measure the form submission only if form rebuild is disabled. If you want to messure form submission of multistep form you need to enable this. Most of the time you will want to leave this enabled.'),
  );
  return $form;
}
