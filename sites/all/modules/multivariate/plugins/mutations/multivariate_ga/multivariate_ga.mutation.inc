<?php

/**
 * @file
 * Multivariate ga settings form.
 */

/**
 * Returns mutation settings form.
 * 
 * @param array $values
 *   Array that holds form default values. It also hold additional helper
 *   values - like $values['variant_id'] which indicates key of current variant
 *   in array.
 */
function multivariate_ga_settings_form(array $values) {
  $form = array();
  if ($values['variant_id'] == 0) {
    $form['ga_event_category'] = array(
      '#type' => 'textfield',
      '#title' => t('GA event category'),
      '#default_value' => isset($values['ga_event_category']) ? $values['ga_event_category'] : '',
      '#description' => t('The name you supply for the group of objects you want to track.'),
      '#required' => TRUE,
    );
  }
  $form['ga_event_action'] = array(
    '#type' => 'textfield',
    '#title' => t('GA event action'),
    '#default_value' => isset($values['ga_event_action']) ? $values['ga_event_action'] : '',
    '#required' => TRUE,
  );
  $form['ga_event_label'] = array(
    '#type' => 'textfield',
    '#title' => t('GA event label'),
    '#default_value' => isset($values['ga_event_label']) ? $values['ga_event_label'] : '',
  );
  if ($values['variant_id'] == 0) {
    $form['ga_event_action']['#description'] = t('A string that is uniquely paired with each category, and commonly used to define the type of user interaction for the web object.');
    $form['ga_event_label']['#description'] = t('An optional string to provide additional dimensions to the event data.');
  }
  return $form;
}
