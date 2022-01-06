<?php

/**
 * @file
 * Theme change mutatation plugin definition.
 */

$plugin = array(
  'label' => t('Theme Change'),
  'description' => t('Theme change multivariation.'),
  'settings form' => 'theme_change_settings_form',
  'events' => array('hook_init'),
  'condition check' => 'theme_change_condition',
);

/**
 * Returns multivariation study settings form.
 * 
 * @param array $values
 *   Array that holds form default values.
 */
function theme_change_settings_form(array $values) {
  $form = array();
  $form['condition'] = array(
    '#type' => 'textfield',
    '#title' => 'Condition',
    '#default_value' => isset($values['condition']) ? $values['condition'] : '',
    '#description' => t('Path of page on which you want to change active theme.'),
  );
  
  foreach (list_themes() as $key => $theme) {
    $options[$key] = $theme->info['name'];
  }
  $form['variations'] = array();
  if ($values['variations']) {
    foreach ($values['variations'] as $key => $variation) {
      $form['variations'][] = array(
        'variation' => array(
          '#type' => 'select',
          '#title' => t('Theme variation !num', array('!num' => $key + 1)),
          '#options' => $options,
          '#default_value' => isset($variation['variation']) ? $variation['variation'] : '',
        ),
      );
    }
  }
  else {
    // Lets add one empty variation element.
    $form['variations'][] = array(
      'variation' => array(
        '#type' => 'select',
        '#title' => t('Theme variation !num', array('!num' => $key + 1)),
        '#options' => $options,
      ),
    );
  }
  return $form;
}

/**
 * Check on which path we need to change theme and if we are on condition
 * path will change theme based on current session mutation.
 * 
 * @param type $study
 * @param type $multivariation
 * 
 * @return bool
 */
function theme_change_condition($study, $multivariation) {
  global $custom_theme;

  // Check if we are hitting condition url.
  if (isset($multivariation['options']['condition']) && multivariate_match_current_path($multivariation['options']['condition'])) {

    // Check to see if there is an existig cookie for this $test_nid.
    $mutation = multivariate_get_assigned_test($study->test_nid);

    // Find the URL for this variation mutation.
    $custom_theme = $multivariation['options']['variations'][$mutation[$multivariation['id']]]['variation'];
    return TRUE;
  }

  return FALSE;
}
