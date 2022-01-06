<?php

use ICanBoogie\Inflector;

define('wweave_IMPORT_LONG_DELIMITER', '======================================================================');
define('wweave_IMPORT_DELIMITER', '-------------------------------');

/**
 * Get Guzzle Client for API communications.
 */
function wweave_api_client() {
  global $user;
  static $client = NULL;
  if (is_null($client)) {
    global $wweave_domain;
    $wweave_ofbiz_url = variable_get('wweave_ofbiz_url', '');
    $client = new GuzzleHttp\Client(array(
      'base_uri'  => $wweave_ofbiz_url . $wweave_domain['catalog'] . '/',
      'timeout'   => 300,
      'headers'   => array(
        'Cookie'  => extract_ofbiz_cookies(),
      ),
      'verify'    => FALSE,
    ));
  }
  return $client;
}

/**
 * Extract Ofbiz Cookies for subsequent requests.
 */
function extract_ofbiz_cookies() {
  $cookies = array();
  foreach ((array)@$_SESSION['wweave']['headers']['Set-Cookie'] as $set_cookie) {
    $set_cookie = explode(';', $set_cookie);
    $cookie_pieces = explode('=', $set_cookie[0]);
    $cookies[$cookie_pieces[0]] = $set_cookie[0];
  }
  return implode('; ', $cookies);
}

/**
 * Extract jsessionid from Ofbiz Cookies.
 */
function get_user_jsessionid() {
  foreach ((array)@$_SESSION['wweave']['headers']['Set-Cookie'] as $set_cookie) {
    $set_cookie = explode(';', $set_cookie);
    $cookie_pieces = explode('=', $set_cookie[0]);
    if (strtolower($cookie_pieces[0]) == 'jsessionid') {
      array_shift($cookie_pieces);
      return implode('=', $cookie_pieces);
    }
  }
  return NULL;
}

/**
 * Change User's password on Ofbiz
 */
function wweave_change_password($current_password, $new_password) {
  // /changePassword?CUSTOMER_EMAIL=ramesh@gmail.com&partyId=10010&PASSWORD=sonata&CONFIRM_PASSWORD=sonata&OLD_PASSWORD=ofbiz&USERNAME=ramesh
  global $user;
  $client = wweave_api_client();
  $request = 'changePassword?' . http_build_query(array(
    'partyId' => get_user_party_id(),
    'USERNAME' => $user->mail,
    'CUSTOMER_EMAIL' => $user->mail,
    'OLD_PASSWORD' => $current_password,
    'PASSWORD' => $new_password,
    'CONFIRM_PASSWORD' => $new_password,
  ));
  $response = $client->get($request);
  $raw_json = $response->getBody();
  $data = json_decode($raw_json, TRUE);
  // $party_id = get_user_party_id(); watchdog(__FUNCTION__, '<pre>' . print_r(compact('party_id', 'request', 'data'), 1) . '</pre>');
  return $data;
}

/**
 * Idempotently import data from Excel spreadsheet.
 */
function wweave_import_data($xls_files) {
  variable_del('wweave_category_tree');
  variable_del('wweave_category_parents');
  variable_del('wweave_category_names');

  foreach ($xls_files as $catalog_name => $xls_file) {
    echo wweave_IMPORT_LONG_DELIMITER . PHP_EOL;
    echo "Reading XLS data ($xls_file)...";
    $xls = PHPExcel_IOFactory::load($xls_file);
    echo " DONE!" . PHP_EOL;

    // Get worksheet dimensions
    $data = array();
    $sheet_count = $xls->getSheetCount();
    for ($sheet = 0; $sheet < $sheet_count; $sheet++) {
      $xls_sheet      = $xls->getSheet($sheet);
      $highest_row    = $xls_sheet->getHighestRow();
      $highest_column = $xls_sheet->getHighestColumn();

      $sheet_title = trim($xls_sheet->getTitle());

      // Loop through each row of the worksheet in turn
      $data[$sheet_title] = array();
      for ($row = 1; $row <= $highest_row; $row++) {
        // Read a row of data into an array
        $row_data = $xls_sheet->rangeToArray('A' . $row . ':' . $highest_column . $row, NULL, TRUE, FALSE);
        $data[$sheet_title][] = $row_data[0];
      }
    }

    $category             = $data['Category'];
    $product              = $data['Product'];
    $product_association  = $data['Product Association'];
    $facet_group          = $data['Facet Group'];
    $facet_value          = $data['Facet Value'];
    $manufacturer         = $data['Manufacturer'];
    $store_price          = $data['Store Price'];

    $category_tree              = array();
    $category_names             = array();
    $category_parents           = array();
    $catalog_keyed              = array();
    $category_keyed             = array();
    $product_keyed              = array();
    $product_association_keyed  = array();
    $facet_group_keyed          = array();
    $facet_value_keyed          = array();
    $store_price_keyed          = array();

    $master_product_lookup = array();

    echo "Catalog: $catalog_name" . PHP_EOL;
    echo wweave_IMPORT_DELIMITER . PHP_EOL;

    // Categories Sheet
    echo "Getting keyed Categories...";
    foreach ($category as $i => $c) {
      if ($i == 0) {
        $category_header = array_map('variableize', $c);
        continue;
      }
      $c = array_combine($category_header, $c);
      $product_category_id = trim((string)$c['product_category_id']);
      $parent_category_id = trim((string)$c['parent_category_id']);
      $category_keyed[$product_category_id] = $c;
      $category_names[$product_category_id] = $c['category_name'];
      // Build Category Tree.
      if (strpos(strtoupper($parent_category_id), '_CATEGORY_ROOT') !== FALSE) {
        // It's a category.
        if (!is_array($category_tree[$product_category_id])) {
          $category_tree[$product_category_id] = array();
        }        
      }
      else {
        // It's a subcategory or sub-subcategory
        if (is_array($category_tree[$parent_category_id])) {
          // It's a subcategory
          $category_parents[$product_category_id] = $parent_category_id;
          $category_tree[$parent_category_id][$product_category_id] = array();
        }
        else {
          // It's a sub-subcategory
          $category_parents[$product_category_id] = $parent_category_id;
          $parent_parent_category_id = $category_parents[$parent_category_id];
          $category_tree[$parent_parent_category_id][$parent_category_id][$product_category_id] = array();
        }
      }
    }
    $wweave_category_tree = json_decode(variable_get('wweave_category_tree', '[]'), TRUE);
    $wweave_category_tree[$catalog_name] = $category_tree;
    variable_set('wweave_category_tree', json_encode($wweave_category_tree));

    $wweave_category_parents = json_decode(variable_get('wweave_category_parents', '[]'), TRUE);
    $wweave_category_parents[$catalog_name] = $category_parents;
    variable_set('wweave_category_parents', json_encode($wweave_category_parents));

    $wweave_category_names = json_decode(variable_get('wweave_category_names', '[]'), TRUE);
    $wweave_category_names[$catalog_name] = $category_names;
    variable_set('wweave_category_names', json_encode($wweave_category_names));
    echo " DONE!" . PHP_EOL;
    echo wweave_IMPORT_DELIMITER . PHP_EOL;

    // Product Sheet
    echo "Getting keyed Products...";
    foreach ($product as $i => $p) {
      if ($i == 0) {
        $product_header = array_map('variableize', $p);
        continue;
      }
      $p = array_combine($product_header, $p);
      // print_r($p);
      $master_product_id    = trim((string)$p['master_product_id']);
      $product_id           = trim((string)$p['product_id']);
      if (empty($product_id)) {
        echo "Empty product_id, using master_product_id: {$master_product_id}" . PHP_EOL;
        $product_id = $master_product_id;
        $p['product_id'] = $product_id;
      }
      if (empty($product_keyed[$product_id])) {
        $product_keyed[$product_id] = $p;
        $master_product_lookup[$product_id] = $master_product_id;
      }
      else {
        // Product is repeated.
        echo "Repeat Product: {$product_id}" . PHP_EOL;
        continue;
      }
    }
    echo "... DONE!" . PHP_EOL;
    echo wweave_IMPORT_DELIMITER . PHP_EOL;

    // Store price
    echo "Getting keyed Store Prices...";
    foreach ($store_price as $i => $c) {
      if ($i == 0) {
        $store_price_header = array_map('variableize', $c);
        continue;
      }
      $c = array_combine($store_price_header, $c);
      $product_id           = trim((string)$c['product_id']);
      $product_store_id     = trim((string)$c['product_store_group_id']);

      $master_product_id = $master_product_lookup[$product_id];
      if (empty($store_price_keyed[$master_product_id])) {
        $store_price_keyed[$master_product_id] = array();
      }
      $store_price_keyed[$master_product_id][$product_id][$product_store_id]['list_price'] = $c['list_price'];
      $store_price_keyed[$master_product_id][$product_id][$product_store_id]['sales_price'] = $c['sales_price'];
    }
    echo "... DONE!" . PHP_EOL;
    echo wweave_IMPORT_DELIMITER . PHP_EOL;

    // Product Association Sheet
    echo "Getting keyed Product Associations...";
    foreach ($product_association as $i => $pa) {
      if ($i == 0) {
        $product_association_header = array_map('variableize', $pa);
        continue;
      }
      $pa = array_combine($product_association_header, $pa);
      if (empty($product_association_keyed[$pa['product_id']])) {
        $product_association_keyed[$pa['product_id']] = array();
      }
      $product_association_keyed[$pa['product_id']][$pa['product_id_to']] = $pa;
    }
    echo " DONE!" . PHP_EOL;
    echo wweave_IMPORT_DELIMITER . PHP_EOL;

    // Check if Main Menu already exists for Catalog, if not create it.
    //$language_param = variable_get('locale_language_negotiation_session_param', 'language');
    //$l
    //$main_menu_suffix = (empty($_SESSION[$language_param]) || @$_SESSION[$language_param] == 'en') ? '' : '-' . $_SESSION[$language_param];
    $languages = language_list('enabled'); 
    foreach($languages[1] as $language){
    $main_menu_name = 'main-menu-' . $catalog_name . '-' . $language->language;
    $main_menu_exists = (menu_load($main_menu_name) !== FALSE);
    if ($main_menu_exists) {
      echo "Main Menu ($main_menu_name) exists..." . PHP_EOL;
    }
    else {
      echo "Main Menu ($main_menu_name) does not exist; creating...";
      $new_main_menu = array(
        'menu_name' => $main_menu_name,
        'title' => "Main menu ($catalog_name)",
        'description' => "Main menu for $catalog_name",
      );
      menu_save($new_main_menu);
      echo " DONE!" . PHP_EOL;
    }
  

    // file_put_contents('category_tree_' . $catalog_name . '.log', print_r($category_tree, 1));
    // file_put_contents('category_keyed_' . $catalog_name . '.log', print_r($category_keyed, 1));
    // exit;

    echo "Building Categories Menus... " . PHP_EOL;
    // TODO: Avoid having to destroy & rebuild menus. Use a smarter algo.
    db_query("DELETE FROM {menu_links} WHERE menu_name = :main_menu_name", array(':main_menu_name' => $main_menu_name));
    foreach ($category_tree as $category_id => $subcategories) {
      $category_name = trim((string)$category_keyed[$category_id]['category_name']);
      $item = array(
        'link_title' => $category_name,
        'link_path' => 'search/site',
        'options' => array(
          'alter' => TRUE,
          'query' => array(
            'f' => array(
              'sm_field_catalog:' . htmlentities($catalog_name),
              'sm_field_category:' . htmlentities($category_name),
            ),
          ),
        ),
        'menu_name' => $main_menu_name,
        'plid' => 0, // Top level Category
      );
      $category_mlid = menu_link_save($item);
      echo "  Category $category_mlid: " . $category_name . PHP_EOL;

      foreach ($subcategories as $subcategory_id => $sub_subcategories) {
        $subcategory_name = trim((string)$category_keyed[$subcategory_id]['category_name']);
        $item = array(
          'link_title' => $subcategory_name,
          'link_path' => 'search/site',
          'options' => array(
            'alter' => TRUE,
            'query' => array(
              'f' => array(
                'sm_field_catalog:' . htmlentities($catalog_name),
                'sm_field_category:' . htmlentities($category_name),
                'sm_field_subcategory:' . htmlentities($subcategory_name),
              ),
            ),
          ),
          'menu_name' => $main_menu_name,
          'plid' => $category_mlid,
        );
        $subcategory_mlid = menu_link_save($item);
        echo "    Subcategory $subcategory_mlid: " . $subcategory_name . PHP_EOL;

        foreach ($sub_subcategories as $sub_subcategory_id => $sub_sub_subcategories) {
          $sub_subcategory_name = trim((string)$category_keyed[$sub_subcategory_id]['category_name']);
          $item = array(
            'link_title' => $sub_subcategory_name,
            'link_path' => 'search/site',
            'options' => array(
              'alter' => TRUE,
              'query' => array(
                'f' => array(
                  'sm_field_catalog:' . htmlentities($catalog_name),
                  'sm_field_category:' . htmlentities($category_name),
                  'sm_field_subcategory:' . htmlentities($sub_subcategory_name),
                ),
              ),
            ),
            'menu_name' => $main_menu_name,
            'plid' => $subcategory_mlid,
          );
          $sub_subcategory_mlid = menu_link_save($item);
          echo "      Sub-subcategory $sub_subcategory_mlid: " . $sub_subcategory_name . PHP_EOL;
        }
      }
    }
  }
    echo "... DONE!" . PHP_EOL;
    echo wweave_IMPORT_DELIMITER . PHP_EOL;

    // Facet Group Sheet
    echo "Getting keyed Facet Groups...";
    foreach ($facet_group as $i => $fg) {
      if ($i == 0) {
        $facet_group_header = array_map('variableize', $fg);
        continue;
      }
      $fg = array_combine($facet_group_header, $fg);
      $facet_group_id       = trim((string)$fg['facet_group_id']);
      $product_category_id  = trim((string)$fg['product_category_id']);
    
      if (is_null($facet_group_keyed[$product_category_id])) {
        $facet_group_keyed[$product_category_id] = array();
      }
      $facet_group_keyed[$product_category_id][$facet_group_id] = $fg;
    }
    echo " DONE!" . PHP_EOL;

    // Facet Values Sheet
    echo "Getting keyed Facet Values...";
    foreach ($facet_value as $i => $fv) {
      if ($i == 0) {
        $facet_value_header = array_map('variableize', $fv);
        continue;
      }
      $fv = array_combine($facet_value_header, $fv);
      $facet_group_id = $fv['facet_group_id'];
      if (is_null($facet_value_keyed[$facet_group_id])) {
        $facet_value_keyed[$facet_group_id] = array();
      }
      $facet_value_keyed[$facet_group_id][] = $fv;
    }
    echo " DONE!" . PHP_EOL;
    echo wweave_IMPORT_DELIMITER . PHP_EOL;

    // Verify Products
    echo "Verifying Products..." . PHP_EOL;
    // Verification.
    $oks = array();
    $errors = array();
    $warnings = array();
    $final_products = array();
    $count = 0;
    foreach ($product_keyed as $product_id => $p) {
      $count++;
      echo "  {$count} - Parsing Product {$product_id}...";

      $is_master_product = FALSE;
      $master_product_id = (string)$p['master_product_id'];

      if ($product_id == $master_product_id) {
        $is_master_product = TRUE;
      }

      if (empty($product_keyed[$master_product_id])) {
        $errors[] = "Master Product {$master_product_id} does not exist for Product {$product_id}";
        continue;
      }
      else {
        $oks[] = "Master Product {$master_product_id} EXISTS for Product {$product_id}";

        $master_product = $product_keyed[$master_product_id];

        $product_category_ids = trim((string)$p['product_category_id']);
        if (empty($product_category_ids)) {
          // Inherit from Master Product.
          $product_category_ids = trim((string)$master_product['product_category_id']);
        }
        $product_category_ids = explode(',', str_replace(' ', '', $product_category_ids));

        $valid_product_categories = array();

        foreach ($product_category_ids as $product_category_id) {
          // Check Product Category
          if (empty($category_keyed[$product_category_id])) {
            $errors[] = "Product Category {$product_category_id} does not exist for Product {$product_id}";
          }
          else {
            $oks[] = "Product Category {$product_category_id} EXISTS for Product {$product_id}";
            $valid_product_categories[$product_category_id] = $product_category_id;

            // Check Facet Groups.
            if (empty($facet_group_keyed[$product_category_id])) {
              $warnings[] = "Product Category {$product_category_id} does not have any facet groups.";
            }
            else {
              $oks[] = "Product Category {$product_category_id} DOES have facet groups.";
              // Check Facet Values.
              // Facet Group does exist. Check if each Facet Group has associated Facet Values.
              $fgs = $facet_group_keyed[$product_category_id];
              foreach ($fgs as $facet_group_id => $fg) {
                if (empty($facet_value_keyed[$facet_group_id])) {
                  $warnings[] = "Facet Group {$facet_group_id} does not have any Facet Values.";
                }
              }
            }
          }
        }

        if (!empty($valid_product_categories)) {
          // Upsert product data.
          // product = $p

          if ($is_master_product) {
            if (empty($final_products[$product_id])) {
              $final_products[$product_id] = product_first_or_create($product_id, $catalog_name);
            }

            $final_product = &$final_products[$product_id];

            $final_product->title = $p['product_name'];
            $final_product->field_price[LANGUAGE_NONE][0]['value'] = trim($p['sales_price']);

            $body_text = $p['long_description'];
            $final_product->body[LANGUAGE_NONE][0]['value']   = $body_text;
            $final_product->body[LANGUAGE_NONE][0]['summary'] = text_summary($body_text);
            $final_product->body[LANGUAGE_NONE][0]['format']  = filter_default_format();

            $category_delta = 0;
            $subcategory_delta = 0;

            $final_product->field_category = array();
            $final_product->field_category_id = array();
            $final_product->field_subcategory = array();
            $final_product->field_subcategory_id = array();
            foreach ($valid_product_categories as $product_category_id) {
              $parent_category_id = $category_parents[$product_category_id];
              $parent_parent_category_id = $category_parents[$parent_category_id];

              // Determine if we are looking at categories, sub-categories or sub-subcategories!
              if (empty($parent_category_id) || !empty($category_tree[$product_category_id])) {
                if (!field_value_exists($final_product, 'field_category_id', $product_category_id)) {
                  $final_product->field_category[LANGUAGE_NONE][$category_delta]['value'] = trim((string)$category_keyed[$product_category_id]['category_name']);
                  $final_product->field_category_id[LANGUAGE_NONE][$category_delta]['value'] = $product_category_id;
                  $category_delta++;
                }
              }
              else {
                if (!empty($parent_parent_category_id)) {
                  // Category -> Subcategory -> Sub-subcategory
                  if (!field_value_exists($final_product, 'field_category_id', $parent_parent_category_id)) {
                    $final_product->field_category[LANGUAGE_NONE][$category_delta]['value'] = trim((string)$category_keyed[$parent_parent_category_id]['category_name']);
                    $final_product->field_category_id[LANGUAGE_NONE][$category_delta]['value'] = $parent_parent_category_id;
                    $category_delta++;
                  }

                  if (!field_value_exists($final_product, 'field_subcategory_id', $parent_category_id)) {
                    $final_product->field_subcategory[LANGUAGE_NONE][$subcategory_delta]['value'] = trim((string)$category_keyed[$parent_category_id]['category_name']);
                    $final_product->field_subcategory_id[LANGUAGE_NONE][$subcategory_delta]['value'] = $parent_category_id;
                    $subcategory_delta++;
                  }

                  if (!field_value_exists($final_product, 'field_subcategory_id', $product_category_id)) {
                    $final_product->field_subcategory[LANGUAGE_NONE][$subcategory_delta]['value'] = trim((string)$category_keyed[$product_category_id]['category_name']);
                    $final_product->field_subcategory_id[LANGUAGE_NONE][$subcategory_delta]['value'] = $product_category_id;
                    $subcategory_delta++;
                  }
                }
                else {
                  // Category -> Subcategory only
                  if (!field_value_exists($final_product, 'field_category_id', $parent_category_id)) {
                    $final_product->field_category[LANGUAGE_NONE][$category_delta]['value'] = trim((string)$category_keyed[$parent_category_id]['category_name']);
                    $final_product->field_category_id[LANGUAGE_NONE][$category_delta]['value'] = $parent_category_id;
                    $category_delta++;
                  }

                  if (!field_value_exists($final_product, 'field_subcategory_id', $product_category_id)) {
                    $final_product->field_subcategory[LANGUAGE_NONE][$subcategory_delta]['value'] = trim((string)$category_keyed[$product_category_id]['category_name']);
                    $final_product->field_subcategory_id[LANGUAGE_NONE][$subcategory_delta]['value'] = $product_category_id;
                    $subcategory_delta++;
                  }
                }
              }
            }

            if (empty($final_product->field_system_data[LANGUAGE_NONE][0]['value'])) {
              $final_product->field_system_data[LANGUAGE_NONE][0]['value'] = new stdClass;
              $final_product->field_system_data[LANGUAGE_NONE][0]['value']->product_raw = $p;
              $final_product->field_system_data[LANGUAGE_NONE][0]['value']->product_variants = new stdClass;
            }
            else {
              if (is_string($final_product->field_system_data[LANGUAGE_NONE][0]['value'])) {
                $final_product->field_system_data[LANGUAGE_NONE][0]['value'] = json_decode($final_product->field_system_data[LANGUAGE_NONE][0]['value']);
              }
              $final_product->field_system_data[LANGUAGE_NONE][0]['value']->product_raw = $p;
            }

            $final_product->field_system_data[LANGUAGE_NONE][0]['value']->product_associations = $product_association_keyed[$product_id];
            $final_product->field_system_data[LANGUAGE_NONE][0]['value']->product_store_prices = $store_price_keyed[$product_id];
          }
          else {
            $final_product = &$final_products[$master_product_id];
            if (is_string($final_product->field_system_data[LANGUAGE_NONE][0]['value'])) {
              $final_product->field_system_data[LANGUAGE_NONE][0]['value'] = json_decode($final_product->field_system_data[LANGUAGE_NONE][0]['value']);
            }
            if (!product_variant_exists($final_product, $p['product_id'])) {
              $final_product->field_system_data[LANGUAGE_NONE][0]['value']->product_variants->{$p['product_id']} = $p;
            }
          }

          // Common code for both master & variants.

          $selectable_features_1 = $p['selectable_features_1'];
          $selectable_features_2 = $p['selectable_features_2'];
          $selectable_features_3 = $p['selectable_features_3'];
          $selectable_features_4 = $p['selectable_features_4'];
          $selectable_features_5 = $p['selectable_features_5'];

          $descriptive_features_1   = $p['descriptive_features_1'];
          $descriptive_features_2   = $p['descriptive_features_2'];
          $descriptive_features_3   = $p['descriptive_features_3'];
          $descriptive_features_4   = $p['descriptive_features_4'];
          $descriptive_features_5   = $p['descriptive_features_5'];
          $descriptive_features_6   = $p['descriptive_features_6'];
          $descriptive_features_7   = $p['descriptive_features_7'];
          $descriptive_features_8   = $p['descriptive_features_8'];
          $descriptive_features_9   = $p['descriptive_features_9'];
          $descriptive_features_10  = $p['descriptive_features_10'];

          $all_selectable_features = array($selectable_features_1, $selectable_features_2, $selectable_features_3, $selectable_features_4, $selectable_features_5, $descriptive_features_1, $descriptive_features_2, $descriptive_features_3, $descriptive_features_4, $descriptive_features_5, $descriptive_features_6, $descriptive_features_7, $descriptive_features_8, $descriptive_features_9, $descriptive_features_10);

          foreach ($all_selectable_features as $selectable_feature) {
            $selectable_feature = trim($selectable_feature);
            if (!empty($selectable_feature)) {
              list($field_name, $field_value) = explode(':', $selectable_feature);
              if (!empty($field_name)) {
                $drupal_field_name = 'field_' . variableize($field_name);
                ensure_product_field($drupal_field_name, ucwords($field_name));
                if (!field_value_exists($final_product, $drupal_field_name, $field_value)) {
                  $final_product->{$drupal_field_name}[LANGUAGE_NONE][] = array(
                    'value' => $field_value,
                  );
                }
              }
            }
          }
        }
      }

      echo " DONE!" . PHP_EOL;
    }
    echo "... DONE!" . PHP_EOL;
    echo wweave_IMPORT_DELIMITER . PHP_EOL;

    echo "Saving Products..." . PHP_EOL;

    unset($final_product); // Break pointer refs from previous loop. See: Warning @ http://php.net/manual/en/control-structures.foreach.php
    $final_product_count = 0;
    foreach ($final_products as $i => $final_product) {
      $final_product_count++;
      echo "{$final_product_count} - {$i}. Saving Product {$final_product->field_product_id[LANGUAGE_NONE][0]['value']}...";
      // Serialize field_system_data
      $all_product_variants = get_object_vars($final_product->field_system_data[LANGUAGE_NONE][0]['value']->product_variants);
      if (empty($all_product_variants)) {
        // Master product only; no variants! Add master product itself as a variant.
        $p = $final_product->field_system_data[LANGUAGE_NONE][0]['value']->product_raw;
        $final_product->field_system_data[LANGUAGE_NONE][0]['value']->product_variants->{$p['product_id']} = $p;
        echo " no variants; using master product...";
      }
      $final_product->field_system_data[LANGUAGE_NONE][0]['value'] = json_encode($final_product->field_system_data[LANGUAGE_NONE][0]['value']);
      node_save($final_product);
      echo " DONE! Node NID: {$final_product->nid}" . PHP_EOL;
    }
    echo "... DONE!" . PHP_EOL;
    echo wweave_IMPORT_DELIMITER . PHP_EOL;

    // print_r(compact('errors', 'warnings'));
    $output = print_r(compact('errors', 'warnings', 'oks'), 1) . PHP_EOL;
    file_put_contents('errors_warnings_' . $catalog_name . '.log', print_r(compact('output', 'final_products'), 1));
  }

  // Done! :)
  echo "IMPORT COMPLETE!" . PHP_EOL;
}

/**
 * Data Import Helpers
 */

/**
 * Check if a field value already exists (to avoid duplicate data being stored)
 */
function product_variant_exists($node, $product_id) {
  if (!empty($node->field_system_data[LANGUAGE_NONE][0]['value']->product_variants)) {
    $product_variants = get_object_vars($node->field_system_data[LANGUAGE_NONE][0]['value']->product_variants);
    return array_key_exists($product_id, $product_variants);
  }
  return FALSE;
}

/**
 * Check if a field value already exists (to avoid duplicate data being stored)
 */
function field_value_exists($node, $field_name, $field_value) {
  if (!empty($node->{$field_name}[LANGUAGE_NONE])) {
    foreach ($node->{$field_name}[LANGUAGE_NONE] as $delta => $value) {
      $str_value = $value['value'];
      if ($str_value == $field_value) {
        return TRUE;
      }
    }
  }
  return FALSE;
}

/**
 * Creates a node instance of a particular type.
 */
function new_node($type) {
  $node = new stdClass;
  $node->type = $type;
  $node->status = 1;
  $node->uid = 1;
  node_object_prepare($node);
  $node->language = LANGUAGE_NONE;
  return $node;
}

/**
 * Gets the Product ID given a single Node ID
 */
function get_product_id_from_nid($nid) {
  $product_ids = get_product_ids_from_nids(array($nid));
  if (!empty($product_ids)) {
    return reset($product_ids);
  }
  return NULL;
}

/**
 * Gets the Product IDs given an array of Node IDs
 */
function get_product_ids_from_nids($nids) {
  return db_query("SELECT DISTINCT field_product_id_value FROM {field_data_field_product_id} WHERE entity_id IN (" . implode(',', $nids) . ")")->fetchCol();
}

/**
 * Gets the Node ID from Product ID, if it exists.
 */
function get_nid_from_product_id($product_id) {
  return db_query("SELECT {field_data_field_product_id}.entity_id FROM {field_data_field_product_id} WHERE field_product_id_value = :product_id", array(':product_id' => $product_id))->fetchField();
}

/**
 * Gets the Node ID from *variant* Product ID, if it exists.
 */
function get_nid_from_variant_product_id($variant_product_id) {
  return db_query("SELECT {field_data_field_system_data}.entity_id FROM {field_data_field_system_data} WHERE field_system_data_value LIKE :variant_product_id", array(':variant_product_id' => '%product_variants%"' . $variant_product_id . '"%'))->fetchField();
}

/**
 * Creates a new product node or returns an existing product node.
 */
function product_first_or_create($product_id, $catalog_name) {
  $existing_nid = get_nid_from_product_id($product_id);
  if (!empty($existing_nid)) {
    $node = node_load($existing_nid);
  }
  else {
    $node = new_node('product');
  }
  $node->uid = 1;
  $node->field_product_id[LANGUAGE_NONE][0]['value'] = $product_id;
  $node->field_catalog[LANGUAGE_NONE][0]['value'] = $catalog_name;
  return $node;
}

/**
 * Ensures a field exists, or creates one if it doesn't.
 */
function ensure_product_field($field_name, $field_label) {
  $fields = field_info_fields();
  if (strpos($field_name, 'field_') === 0) {
    // Begins with "field_"
    if (empty($fields[$field_name])) {
      $field = array(
        'field_name' => $field_name,
        'type' => 'text',
        'cardinality' => FIELD_CARDINALITY_UNLIMITED,
      );
      $field = field_create_field($field);

      $instance = array(
        'field_name' => $field_name,
        'cardinality' => FIELD_CARDINALITY_UNLIMITED,
        'entity_type' => 'node',
        'bundle' => 'product',
        'label' => $field_label,
        'settings' => array(
          'text_processing' => 0,
        ),
        'widget' => array('type' => 'text_textfield'),
        'weight' => 100,
        'display' => array(
          'teaser' => array(
            'label' => 'inline',
            'type' => 'text_plain',
          ),
          'default' => array(
            'label' => 'inline',
            'type' => 'text_default',
          ),
        ),
      );
      $instance = field_create_instance($instance);
      watchdog(__FUNCTION__, 'Created field instance: "'.$field_label.'" ('.$field_name.')');
    }
    // Else, field already exists!
    return TRUE;
  }
  return FALSE;
}

/**
 * Converts any English string into a correspoding variable after trimming.
 */
function variableize($string) {
  return trim(
    preg_replace("/[_]+/", '_',
      Inflector::get()->underscore(
        str_replace(array(' ', '-', '#'), array('', '_', '_'),
          trim(
            preg_replace("/[^a-z0-9\s-#]+/i", '', $string)
          )
        )
      )
    ), ' _');
}

/**
 * Helper function to get the global theme path.
 */
function current_theme_path() {
  static $current_theme_path = array();
  if (empty($current_theme_path[$GLOBALS['theme']])) {
    $current_theme_path[$GLOBALS['theme']] = url(drupal_get_path('theme', $GLOBALS['theme']));
  }
  return $current_theme_path[$GLOBALS['theme']];
}

/**
 * Sets up the wweave Demo Context.
 */
function wweave_setup_demo_context() {
  global $wweave_demo_theme_options;

  if (!empty($_GET['wweave_demo_theme'])) {
    $wweave_demo_theme = $_GET['wweave_demo_theme'];
    if (!empty($wweave_demo_theme_options[$wweave_demo_theme])) {
      $_SESSION['wweave_demo_theme'] = $wweave_demo_theme;
      header('Location: ' . str_replace('?' . $_SERVER['QUERY_STRING'], '', $_SERVER['REQUEST_URI']));
      drupal_exit();
    }
  }

  if (!empty($_SESSION['wweave_demo_theme'])) {
    global $wweave_domain;
    $wweave_domain = $wweave_demo_theme_options[$_SESSION['wweave_demo_theme']];
  }
}

/**
 * Sets up the Domain Context.
 */
function wweave_setup_domain_context() {
  if (php_sapi_name() != 'cli') {
    global $wweave_domain;
    if (empty($wweave_domain)) {
      $wweave_domain_config = variable_get("wweave_domain_config", array());
      if (!empty($wweave_domain_config[$_SERVER["SERVER_NAME"]])) {
        $wweave_domain = $wweave_domain_config[$_SERVER["SERVER_NAME"]];
      }
      else {
        $possible_domains = array();
        $http_host = explode('.', $_SERVER["SERVER_NAME"]);
        $http_host_len = sizeof($http_host);
        for ($i = 0; $i < $http_host_len; $i++) {
          $http_host_copy = $http_host;
          for ($j = 0; $j <= $i; $j++) {
            $http_host_copy[$j] = '*';
          }
          $possible_domain = implode('.', $http_host_copy);
          while (strpos($possible_domain, '*.*') !== FALSE) {
            $possible_domain = preg_replace("/(\*\.\*)+/i", '*', $possible_domain);
          }
          $possible_domains[] = $possible_domain;
        }
        foreach ($possible_domains as $domain) {
          if (!empty($wweave_domain_config[$domain])) {
            $wweave_domain = $wweave_domain_config[$domain];
            break;
          }
        }
      }
    }
    if (empty($wweave_domain)) {
//      die('Invalid Domain!');
    }
  }
}

/**
 * Sort size facet values.
 */
function size_sort($array) {
  // If all values are numeric, return the ksort value.
  $is_numeric = TRUE;
  foreach ($array as $k => $v) {
    // drupal_set_message('<pre>BEFORE: '.print_r($k, 1).'</pre>', 'error');
    $k = preg_replace("/[^0-9]/i", '', $k);
    // drupal_set_message('<pre>AFTER: '.print_r($k, 1).'</pre>', 'error');
    if (!is_numeric($k)) {
      $is_numeric = FALSE;
      break;
    }
  }
  if ($is_numeric) {
    ksort($array);
    return $array;
  }
  $size_array = array('XS', 'S', 'M', 'L', 'XL', 'XXL');
  $array_keys = array_keys($array);
  $array_keys_mapped = array();
  // drupal_set_message('<pre>'.print_r($array, 1).'</pre>', 'error');
  foreach ($array_keys as $array_key) {
    $array_keys_mapped[] = array_search($array_key, $size_array);
  }
  // drupal_set_message('<pre>'.print_r($array_keys_mapped, 1).'</pre>', 'error');
  asort($array_keys_mapped);
  $return = array();
  foreach ($array_keys_mapped as $array_key_mapped) {
    $size_value = $size_array[$array_key_mapped];
    $return[$size_value] = $array[$size_value];
  }
  return $return;
}

/**
 * Get all the possible facet value options for product variants.
 */
function get_facet_values($system_data, $eliminate_facets_without_options = TRUE) {
  $facet_values = array();
  foreach ($system_data->product_variants as $product_variant) {
    $selected_features = get_selected_features($product_variant);
    foreach ($selected_features as $facet_name => $facet_value) {
      $facet_values[$facet_name][$facet_value] = $product_variant->product_id;
    }
  }
  foreach ($facet_values as $facet_name => $facet_value) {
    if (strtolower($facet_name) == 'size') {
      $facet_values[$facet_name] = size_sort($facet_value);
    }
    else {
      ksort($facet_value);
      $facet_values[$facet_name] = $facet_value;
    }
  }

  if ($eliminate_facets_without_options) {
    // Eliminate $facet_values without multiple options
    foreach ($facet_values as $facet_name => $this_facet_values) {
      if (count($this_facet_values) <= 1) {
        unset($facet_values[$facet_name]);
      }
    }
  }

  return $facet_values;
}

/**
 * Get selected features from a product.
 */
function get_selected_features($p) {
  $selected_features = array();

  $selectable_features_1 = $p->selectable_features_1;
  $selectable_features_2 = $p->selectable_features_2;
  $selectable_features_3 = $p->selectable_features_3;
  $selectable_features_4 = $p->selectable_features_4;
  $selectable_features_5 = $p->selectable_features_5;

  $descriptive_features_1 = $p->descriptive_features_1;
  $descriptive_features_2 = $p->descriptive_features_2;
  $descriptive_features_3 = $p->descriptive_features_3;
  $descriptive_features_4 = $p->descriptive_features_4;
  $descriptive_features_5 = $p->descriptive_features_5;
  $descriptive_features_6 = @$p->descriptive_features_6;
  $descriptive_features_7 = @$p->descriptive_features_7;
  $descriptive_features_8 = @$p->descriptive_features_8;
  $descriptive_features_9 = @$p->descriptive_features_9;
  $descriptive_features_10 = @$p->descriptive_features_10;

  $all_selectable_features = array($selectable_features_1, $selectable_features_2, $selectable_features_3, $selectable_features_4, $selectable_features_5, $descriptive_features_1, $descriptive_features_2, $descriptive_features_3, $descriptive_features_4, $descriptive_features_5, $descriptive_features_6, $descriptive_features_7, $descriptive_features_8, $descriptive_features_9, $descriptive_features_10);

  foreach ($all_selectable_features as $selectable_feature) {
    $selectable_feature = trim($selectable_feature);
    if (!empty($selectable_feature) AND !in_array(strtoupper($selectable_feature), array('NA'))) {
      list($field_name, $field_value) = explode(':', $selectable_feature);
      if (empty($field_value)) {
        drupal_set_message($selectable_feature, 'error');
      }
      $selected_features[$field_name] = $field_value;
    }
  }
  return $selected_features;
}

/**
 * Setup Krumo for debugging.
 */
function setup_krumo() {
  if (function_exists('has_krumo')) {
    has_krumo();
  }
}

/**
 * Returns the absolute image URL.
 */
function wweave_image($path) {
  global $wweave_domain;
  $wweave_ofbiz_url = variable_get('wweave_ofbiz_url', '');
  if (!empty($wweave_domain['dev'])) {
    // Development env.
    $catalog = ''; // No need to add catalog for dev env.
    $wweave_ofbiz_url = str_replace(':8090', ':8080', $wweave_ofbiz_url);
  }
  else {
    // Non-development env.
    $catalog = $wweave_domain['catalog'] . '/';
  }
  return $wweave_ofbiz_url . 'osafe_theme<?php echo current_theme_path() ?>/images/catalog/' . $catalog . $path;
}

/**
 * Format money to have 2 decimal places, max.
 */
function format_money($amount) {
  return sprintf("%.2f", $amount);
}

/**
 * Implements hook_user_logout()
 *
 * Log out the User from Ofbiz as well.
 */
function wweave_user_logout($account) {
  // /userLogout?partyId=10010
  $client = wweave_api_client();
  $response = $client->get('userLogout?' . http_build_query(array(
    'partyId' => get_user_party_id(),
  )));
  $raw_json = $response->getBody();
  $data = json_decode($raw_json, TRUE);
  // $party_id = get_user_party_id(); watchdog(__FUNCTION__, '<pre>' . print_r(compact('party_id', 'data'), 1) . '</pre>');
  return $data;
}

/**
 * Get Party ID of currently logged in user.
 */
function get_user_party_id() {
  global $user;
  if (!empty($user->uid)) {
    $account = user_load($user->uid);
    return $account->field_party_id[LANGUAGE_NONE][0]['value'];
  }
  return @$_SESSION['wweave']['party_id'];
}

/**
 * Update address of shopping cart.
 */
function update_cart_address($contact_mech_id) {
  $endpoint = 'multiPageUpdateCustomerAddressNew';
  $params = array(
    'js_PostalAddressContactMechIdForRadio' => $contact_mech_id,
    'paymentOption' => 'PAYOPT_COD',
  );
  $party_id = get_user_party_id();
  if (empty($GLOBALS['user']->uid)) {
    // Anonymous user
    // /multiPageUpdateCustomerAddressNew;jsessionid=6A49742000F7DED3548C1E359A1D0F81.jvm1?partyId=10120&js_PostalAddressContactMechIdForRadio=10262&paymentOption=PAYOPT_COD
    $jsessionid = get_user_jsessionid();
    if (!empty($jsessionid)) {
      $endpoint .= (';jsessionid=' . urlencode($jsessionid));
    }
    if (!empty($party_id)) {
      $params['partyId'] = $party_id;
    }
  }
  else {
    // Logged in user
    // /multiPageUpdateCustomerAddressNew?partyId=10120&js_PostalAddressContactMechIdForRadio=10262&paymentOption=PAYOPT_COD
    $params['partyId'] = $party_id;
  }
  $client = wweave_api_client();
  $response = $client->get($endpoint . '?' . http_build_query($params));
  $raw_json = $response->getBody();
  $data = json_decode($raw_json, TRUE);
  if(!(empty($data['CODAvailable']))){
    $_SESSION['wweave']['CODAvailable'] = $data['CODAvailable'];
  }
  watchdog(__FUNCTION__, '<pre>' . print_r(compact('endpoint', 'params', 'data'), 1) . '</pre>');
  return $data;
}
/**
* Shipping Methods
*/
function get_shipping_methods(){
  $endpoint = 'shipmentType';
  $params = array();
  $client = wweave_api_client();
  $response = $client->get($endpoint . '?' . http_build_query($params));
  $raw_json = $response->getBody();
  $data = json_decode($raw_json, TRUE);
  watchdog(__FUNCTION__, '<pre>' . print_r(compact('endpoint', 'params', 'data'), 1) . '</pre>');
  return $data;
}
/**
 * Get Shopping Cart of currently logged in user.
 */
function get_user_cart($shipping_method = FALSE) {
  $endpoint = 'eCommerceShowcartNew';
  $params = array();
  $party_id = get_user_party_id();
  if (empty($GLOBALS['user']->uid)) {
    // Anonymous user
    // /eCommerceShowcartNew;jsessionid=807E961CDA1FE828F6DA4E92C032DD79.jvm1
    $jsessionid = get_user_jsessionid();
    if (!empty($jsessionid)) {
      $endpoint .= (';jsessionid=' . urlencode($jsessionid));
    }
    if (!empty($party_id)) {
      $params['partyId'] = $party_id;
    }
  }
  else {
    // Logged in user
    // /eCommerceShowcartNew?partyId=10010
    $params['partyId'] = $party_id;
  }
  if($shipping_method){
    $params['shipmentMethodId']=$shipping_method;
  }
  
  $client = wweave_api_client();
  try{
  $response = $client->get($endpoint . '?' . http_build_query($params));
  $raw_json = $response->getBody();
  $data = json_decode($raw_json, TRUE);
  }
 catch(Exception $e){

  }
  if($shipping_method){
    watchdog(__FUNCTION__, '<pre>' . print_r(compact('endpoint', 'params', 'data'), 1) . '</pre>');
  }
  watchdog(__FUNCTION__, '<pre>' . print_r(compact('endpoint', 'params', 'data'), 1) . '</pre>');
  return $data;
}

/**
 * Add item to currently logged in user's cart.
 */
function add_item_to_cart($product_id, $quantity) {
  $endpoint = 'addItemToCartNew';
  $params = array(
    'add_product_id'  => $product_id,
    'quantity'        => $quantity,
  );
  $jsessionid = NULL;
  if (empty($GLOBALS['user']->uid)) {
    // Anonymous user
    // /addItemToCartNew;jsessionid=2520572C9D11330989E0C1998400BE39.jvm1?add_product_id=2643900&quantity=1
    $jsessionid = get_user_jsessionid();
    if (!empty($jsessionid)) {
      $endpoint .= (';jsessionid=' . urlencode($jsessionid));
    }
  }
  else {
    // Logged in user
    // /addItemToCartNew?add_product_id=2443919&quantity=2&partyId=10010
    $params['partyId'] = get_user_party_id();
  }

  $client = wweave_api_client();
  $response = $client->get($endpoint . '?' . http_build_query($params));
  $raw_json = $response->getBody();

  if (empty($GLOBALS['user']->uid)) {
    $raw_headers = $response->getHeaders();
    if (!empty($raw_headers['Set-Cookie'])) {
      $_SESSION['wweave']['headers'] = $raw_headers;
    }
  }

  $data = json_decode($raw_json, TRUE);
  // watchdog(__FUNCTION__, '<pre>' . print_r(compact('endpoint', 'params', 'data', 'raw_headers'), 1) . '</pre>');
  return $data;
}

/**
 * Delete item currently in logged in user's cart.
 */
function delete_item_from_cart($product_id) {
  $endpoint = 'deleteFromCartnew';
  $params = array(
    'productId' => $product_id,
  );
  if (empty($GLOBALS['user']->uid)) {
    // Anonymous user
    // /deleteFromCartnew;jsessionid=2520572C9D11330989E0C1998400BE39.jvm1?&productId=2643900
    $jsessionid = get_user_jsessionid();
    if (!empty($jsessionid)) {
      $endpoint .= (';jsessionid=' . urlencode($jsessionid));
    }
  }
  else {
    // Logged in user
    // /deleteFromCartnew?partyId=10010&productId=2647520
    $params['partyId'] = get_user_party_id();
  }
  $client = wweave_api_client();
  $response = $client->get($endpoint . '?' . http_build_query($params));
  $raw_json = $response->getBody();
  $data = json_decode($raw_json, TRUE);
  return $data;
}

/**
 * Edit item currently in logged in user's cart.
 */
function modify_item_in_cart($product_id, $quantity) {
  $endpoint = 'modifycartnew';
  $params = array(
    'productId' => $product_id,
    'itemquan'  => $quantity,
  );
  if (empty($GLOBALS['user']->uid)) {
    // Anonymous user
    // /modifycartnew;jsessionid=2520572C9D11330989E0C1998400BE39.jvm1?productId=2643900&itemquan=3
    $jsessionid = get_user_jsessionid();
    if (!empty($jsessionid)) {
      $endpoint .= (';jsessionid=' . urlencode($jsessionid));
    }
  }
  else {
    // Logged in user
    // /modifycartnew?partyId=10010&productId=2646890&itemquan=4
    $params['partyId'] = get_user_party_id();
  }
  $client = wweave_api_client();
  $response = $client->get($endpoint . '?' . http_build_query($params));
  $raw_json = $response->getBody();
  $data = json_decode($raw_json, TRUE);
  return $data;
}

/**
 * Get current users orders.
 */
function get_user_orders() {
  // /eCommerceOrderHistoryNew
  $client = wweave_api_client();
  $response = $client->get('eCommerceOrderHistoryNew');
  $raw_json = $response->getBody();
  $data = json_decode($raw_json, TRUE);
  return $data;
}

/**
 * Get current users profile.
 */
function get_user_profile() {
  // /eCommerceEditCustomerInfoNew?partyId=10010
  $client = wweave_api_client();
  $response = $client->get('eCommerceEditCustomerInfoNew?' . http_build_query(array(
    'partyId' => get_user_party_id(),
  )));
  $raw_json = $response->getBody();
  $data = json_decode($raw_json, TRUE);
  return $data;
}

/**
 * Login User.
 */
function ofbiz_login($username, $password) {
  // /eCommerceLoginNew?USERNAME=test2@example.com&PASSWORD=sonata123
  $client = wweave_api_client();
  $response = $client->get('eCommerceLoginNew?' . http_build_query(array(
    'USERNAME' => $username,
    'PASSWORD' => $password,
  )));
  $raw_json = $response->getBody();
  $data = json_decode($raw_json, TRUE);
  watchdog(__FUNCTION__, 'test login ' . 'eCommerceLoginNew?' . http_build_query(array(
    'USERNAME' => $username,
    'PASSWORD' => $password,
  )) . ' $data = ' . print_r($data, 1));
  return array($data, $response);
}

/**
 * Get current users addresses.
 */
function get_user_addresses() {
  // /multiPageCustomerAddressNew?partyId=10010
  $client = wweave_api_client();
  $response = $client->get('multiPageCustomerAddressNew?' . http_build_query(array(
    'partyId' => get_user_party_id(),
  )));
  $raw_json = $response->getBody();
  $data = json_decode($raw_json, TRUE);
  return $data;
}

/**
 * List of US States
 */
function us_states() {
  return array(
    'AL' => t('Alabama'),
    'AK' => t('Alaska'),
    'AZ' => t('Arizona'),
    'AR' => t('Arkansas'),
    'CA' => t('California'),
    'CO' => t('Colorado'),
    'CT' => t('Connecticut'),
    'DE' => t('Delaware'),
    'DC' => t('District of Columbia'),
    'FL' => t('Florida'),
    'GA' => t('Georgia'),
    'HI' => t('Hawaii'),
    'ID' => t('Idaho'),
    'IL' => t('Illinois'),
    'IN' => t('Indiana'),
    'IA' => t('Iowa'),
    'KS' => t('Kansas'),
    'KY' => t('Kentucky'),
    'LA' => t('Louisiana'),
    'ME' => t('Maine'),
    'MD' => t('Maryland'),
    'MA' => t('Massachusetts'),
    'MI' => t('Michigan'),
    'MN' => t('Minnesota'),
    'MS' => t('Mississippi'),
    'MO' => t('Missouri'),
    'MT' => t('Montana'),
    'NE' => t('Nebraska'),
    'NV' => t('Nevada'),
    'NH' => t('New Hampshire'),
    'NJ' => t('New Jersey'),
    'NM' => t('New Mexico'),
    'NY' => t('New York'),
    'NC' => t('North Carolina'),
    'ND' => t('North Dakota'),
    'OH' => t('Ohio'),
    'OK' => t('Oklahoma'),
    'OR' => t('Oregon'),
    'PA' => t('Pennsylvania'),
    'RI' => t('Rhode Island'),
    'SC' => t('South Carolina'),
    'SD' => t('South Dakota'),
    'TN' => t('Tennessee'),
    'TX' => t('Texas'),
    'UT' => t('Utah'),
    'VT' => t('Vermont'),
    'VA' => t('Virginia'),
    'WA' => t('Washington'),
    'WV' => t('West Virginia'),
    'WI' => t('Wisconsin'),
    'WY' => t('Wyoming'),
    'AA' => t('Armed Forces (Americas)'),
    'AE' => t('Armed Forces (Europe, Canada, Middle East, Africa)'),
    'AP' => t('Armed Forces (Pacific)'),
    'AS' => t('American Samoa'),
    'FM' => t('Federated States of Micronesia'),
    'GU' => t('Guam'),
    'MH' => t('Marshall Islands'),
    'MP' => t('Northern Mariana Islands'),
    'PW' => t('Palau'),
    'PR' => t('Puerto Rico'),
    'VI' => t('Virgin Islands'),
  );
}

/**
 * Clean up extraneous HTML entities in breadcrumb.
 */
function clean_breadcrumb($breadcrumb) {
  $search_and_replace = array(
    '&amp;amp;' => '&amp;',
    ' » '       => '',
    '</a>'      => '</a><img src="'. current_theme_path() .'<?php echo current_theme_path() ?>/images/boxarrow_bg.gif">',
  );
  return str_replace(array_keys($search_and_replace), array_values($search_and_replace), $breadcrumb);
}

function getTotalPromoAmount($cartItems, $orderLevel = FALSE){
 $promoTotalAmt = 0;
  foreach ($cartItems as $promo => $promoAmt) {
    if ($orderLevel) {
      $promoTotalAmt += round(abs($promoAmt['promoAmount']) * $promoAmt['quantity'], 2);
    }
    else {
      $promoTotalAmt += $promoAmt['promoAmount'];
    }
  }

  return (float)$promoTotalAmt;
}

function pdp_out_of_stock_info($masterProductId){
 $client = wweave_api_client();
    $response = $client->get('inventoryCheckNew?' . http_build_query(array(
      'productId' => $masterProductId,//'500900',
    )));
    $raw_json = $response->getBody();
    $data = json_decode($raw_json);
    return $data;
}

function wweave_get_demo_administrator_role() {
  return db_query("SELECT rid FROM role WHERE name = :role", array(':role' => 'demo administrator'))->fetchField();
}

function wweave_user_is_demo_administrator($uid = NULL) {
  if (is_null($uid)) {
    $uid = $GLOBALS['user']->uid;
  }
  $account = user_load($uid);
  return in_array('demo administrator', $account->roles);
}

function wweave_demo_password($email) {
  return sha1("wweave_demo_{$email}");
}



