<?php

/**
 * @file
 * Theme functions.
 */

/**
 * Theme single result label - set and variant titles.
 *
 * @param array $variables
 * 
 * @return string
 *   Rendered label.
 */
function theme_multivariate_result_label($variables) {
  return t('Set %set_title - Variant %variant_title (S!set_num:V!variant_num)', array(
    '%set_title' => $variables['test']->variants_set[$variables['set_id']]['title'],
    '%variant_title' => $variables['test']->variants_set[$variables['set_id']]['variants'][$variables['variant_id']]['title'],
    '!set_num' => $variables['set_id'] + 1,
    '!variant_num' => $variables['variant_id'] + 1,
  ));
}

/**
 * Theme all set-variant combinations lables of one unique variant combination.
 * 
 * @param array $variables
 * 
 * @return string
 *   Rendered labels.
 */
function theme_multivariate_result_labels($variables) {
  return implode('<br/>', $variables['labels']);
}
