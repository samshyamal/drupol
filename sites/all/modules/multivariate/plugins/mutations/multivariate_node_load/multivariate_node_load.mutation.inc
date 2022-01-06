<?php

/**
 * @file
 * Node load mutation settings.
 */

/**
 * Returns muatation settings form.
 * 
 * @param array $values
 *   Array that holds form default values. It also hold additional helper
 *   values - like $values['variant_id'] which indicates key of current variant
 *   in array.
 */
function multivariate_node_load_settings_form(array $values) {
  $form = array();
  if ($values['variant_id'] == 0) {
    $form['target_nid'] = array(
      '#type' => 'textfield',
      '#title' => t('Target node id'),
      '#default_value' => isset($values['target_nid']) ? $values['target_nid'] : '',
      '#description' => t('This is node nid which you want to change during a node load.'),
    );
  }
  $form['nid'] = array(
    '#type' => 'textfield',
    '#title' => t('Node id'),
    '#default_value' => isset($values['nid']) ? $values['nid'] : '',
  );
  return $form;
}
