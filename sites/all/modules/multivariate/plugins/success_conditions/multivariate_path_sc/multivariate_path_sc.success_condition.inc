<?php

/**
 * @file
 * Multivariate path sucecss condition settings.
 */

/**
 * Returns muatation settings form.
 *
 * @param array $values
 *   Array that holds form default values. It also hold additional helper
 *   values.
 */
function multivariate_path_sc_settings_form(array $values) {
  $form = array();
  $form['system_path'] = array(
    '#type' => 'textarea',
    '#title' => t('System path'),
    '#description' => t("Enter Drupal paths, one path per line. The '*' character is a wildcard. Example paths are blog for the blog page and blog/* for every personal blog. &lt;front&gt; is the front page."),
     '#default_value' => isset($values['system_path']) ? $values['system_path'] : '',
  );
  return $form;
}
