<?php

/**
 * @file
 * Multivariate path redirection mutation settings.
 */

/**
 * Returns muatation settings form.
 * 
 * @param array $values
 *   Array that holds form default values. It also hold additional helper
 *   values - like $values['variant_id'] which indicates key of current variant.
 *   array.
 */
function multivariate_path_redirection_settings_form(array $values) {
  $form = array();
  $form['path'] = array(
    '#type' => 'textfield',
    '#title' => t('Path redirection'),
    '#default_value' => isset($values['path']) ? $values['path'] : '',
  );
  if ($values['variant_id'] < 1) {
    $form['path']['#description'] = t("The '*' character is a wildcard. If you use '*' operator you need to be sure that you have added 'String: URL path' in run connditions and that you are using '*' character there also.");
  }
  return $form;
}
