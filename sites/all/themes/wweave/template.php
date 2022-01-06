<?php
/**
 * @file
 * The primary PHP file for this theme.
 */

function globular_breadcrumb($variables) {
  global $drubiz_domain;
  if (!empty($variables['breadcrumb'])) {
    $category_names_hasti = json_decode(json_decode(json_encode(variable_get('drubiz_category_names'))),true);
    $category_names = $category_names_hasti[$drubiz_domain['catalog']];
    $breadcrumb_value = $variables['breadcrumb'];
    $catalog = $drubiz_domain['catalog'];
    $breadcrumb_value = getBreadcrumbValue($catalog, $breadcrumb_value);
    $breadcrumb_value = getBreadcrumbValue('Search', $breadcrumb_value);
    $breadcrumb_value = getBreadcrumbValue('Home', $breadcrumb_value);
    $breadcrumb_value = array_values($breadcrumb_value);
    foreach ($breadcrumb_value as $breadcrumb_key => $breadcrumb) {
      if (!is_array($breadcrumb)) {
        // $link = preg_match("/\>(.*)<\/a>/i", $breadcrumb, $matches);
        if (!empty($matches[1])) {
          if (!empty($category_names[(string)$matches[1]])) {
            $breadcrumb_value[$breadcrumb_key] = str_replace('>' . $matches[1] . '</a>', '>' . $category_names[(string)$matches[1]] . '</a>', $breadcrumb);
            continue;
          }
        }
        // $standalone = preg_match("/^[0-9]+$/i", $breadcrumb);
        if (!empty($category_names[(string)$breadcrumb])) {
          $breadcrumb_value[$breadcrumb_key] = $category_names[(string)$breadcrumb];
        }
        //drupal_set_message("ctype=".ctype_digit($breadcrumb)."<pre>".print_r($breadcrumb, 1)."</pre>"." and ".$category_names[(string)$breadcrumb]);
        // if(isset($category_names[(string)$breadcrumb])) {}
        // else {
        //   unset($a[$breadcrumb_key]);
        // }
      }
    }
  }
  $breadcrumb_final = array_slice($breadcrumb_value, 0, -1);
  $breadcrumb_final = $breadcrumb_value;
  global $base_path;
  $home_breadcrumb = '<a href="'.$base_path.'">Home</a>';
  if(count($breadcrumb_final) > 0) {
    array_unshift($breadcrumb_final, $home_breadcrumb);
  }
  $output = theme('item_list', array(
    'attributes' => array(
      'class' => array('breadcrumb'),
    ),
    'items' => $breadcrumb_final,
    'type' => 'ol',
  ));
    return $output;
}

function getBreadcrumbValue($value,$array) {
  $match = preg_grep('/\>(.*)'.$value.'<\/a>/i', $array);
  $key = array_keys($match);
  unset($array[$key[0]]);
  return $array;
}