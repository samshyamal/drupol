<?php

/**
 * @file
 * Provides configuration for multivariate testing utility.
 */

/**
 * Override settings form.
 */
function multivariate_override_settings_form() {
  $form = array();

  $form['help'] = array(
    '#markup' => t('Manually override current running tests. This can be useful while you are building your tests and you want to take a look in a web browser at one specific variants combination. Override is done over cookie so it is effective only for a user that did override, also results will not be stored for that user while override is active.'),
  );

  $form['multivariate'] = array('#tree' => TRUE);

  $tests = multivariate_load_multiple(FALSE);
  if (empty($tests)) {
    $form['multivariate']['notice'] = array(
      '#markup' => t('There are currently no tests set up for testing. Go to !uri to set one up.',
        array('!uri' => l(t('multivariate/add'), 'multivariate/add'))),
    );
  }
  else {
    foreach ($tests as $test) {
      $test_results = multivariate_get_results($test);

      $options = array('disable' => t('Disable override'));
      foreach ($test_results as $mutation_id => $test_result) {
        $options[$mutation_id] = strip_tags($test_result['labels']);
      }

      $form['multivariate'][$test->mtid] = array(
        '#type' => 'select',
        '#title' => check_plain($test->title),
        '#default_value' => isset($_COOKIE['multivariate_' . $test->mtid . '_override']) ? $_COOKIE['multivariate_' . $test->mtid . '_override'] : 'disable',
        '#options' => $options,
      );
    }

    $form['submit'] = array(
      '#type' => 'submit',
      '#value' => t('Save'),
    );
  }
  return $form;
}

/**
 * Submit handler.
 */
function multivariate_override_settings_form_submit($form, &$form_state) {
  global $cookie_domain;

  drupal_set_message(t('Saved manual tests overrides.'));

  foreach ($form_state['values']['multivariate'] as $mtid => $mutation_id) {
    if ($mutation_id == 'disable') {
      setcookie('multivariate_' . $mtid . '_override', '', REQUEST_TIME - 90000, '/', $cookie_domain);
    }
    else {
      setcookie('multivariate_' . $mtid . '_override', $mutation_id, MULTIVARIATE_COOKIE_DURATION, '/', $cookie_domain);
    }
  }
}

/**
 * Returns html table of all multivariate tests.
 *
 * @return string
 *   Rendered table.
 */
function multivariate_list() {
  $tests = multivariate_load_multiple(FALSE);

  $header = array(
    t('Title'),
    t('Status'),
    t('Actions'),
  );

  $rows = array();
  foreach ($tests as $mtid => $test) {
    $uri = entity_uri('multivariate_test', $test);
    $operations = array(
      'view' => array(
        'title' => t('View'),
        'href' => $uri['path'] . '/view',
      ),
      'edit' => array(
        'title' => t('Edit'),
        'href' => $uri['path'] . '/edit',
      ),
      'delete' => array(
        'title' => t('Delete'),
        'href' => $uri['path'] . '/delete',
      ),
    );
    $rows[] = array(
      check_plain($test->title),
      $test->enabled ? t('Enabled') : t('Disabled'),
      theme('links', array('links' => $operations, 'attributes' => array('class' => array('links', 'inline')))),
    );
  }

  // @todo - add pager?

  return theme('table', array(
    'header' => $header,
    'rows' => $rows,
    'attributes' => array('id' => 'multivariate-admin-list'),
    'empty' => t('There is no multivariate tests, create one first.'),
  ));
}

/**
 * Add new multivariate test page callback.
 */
function multivariate_add() {
  $test = entity_create('multivariate_test', array('type' => 'multivariate_test'));
  drupal_set_title(t('Create @name', array('@name' => entity_label('multivariate_test', $test))));
  $output = drupal_get_form('multivariate_form', $test);
  return $output;
}

/**
 * Multivariate test form.
 */
function multivariate_form($form, &$form_state, $test) {
  $form_state['multivariate_test'] = $test;

  $form['title'] = array(
    '#type' => 'textfield',
    '#required' => TRUE,
    '#title' => t('Title'),
    '#default_value' => $test->title,
  );
  $form['description'] = array(
    '#type' => 'textarea',
    '#title' => t('Description'),
    '#default_value' => $test->description,
  );
  $form['enabled'] = array(
    '#type' => 'checkbox',
    '#title' => t('Enabled'),
    '#default_value' => $test->enabled,
  );

  $form['uid'] = array(
    '#type' => 'value',
    '#value' => $test->uid,
  );

  form_load_include($form_state, 'inc', 'multivariate', 'multivariate.admin');

  $form['settings'] = array(
    '#type' => 'vertical_tabs',
  );

  multivariate_conditions_fieldset($test, $form, $form_state);
  multivariate_variants_sets_fieldset($test, $form, $form_state);
  multivariate_success_conditions_fieldset($test, $form, $form_state);

  // @todo - figure do we need fields support in the future.
  //field_attach_form('example_task', $study, $form, $form_state);

  $submit = array();
  if (!empty($form['#submit'])) {
    $submit += $form['#submit'];
  }

  $form['actions'] = array(
    '#weight' => 100,
  );

  $form['actions']['submit'] = array(
    '#type' => 'submit',
    '#value' => t('Save test'),
    '#submit' => $submit + array('multivariate_form_submit'),
  );

  // Show Delete button if we are editing test.
  $test_id = entity_id('multivariate_test', $test);
  if (!empty($test_id) && multivariate_access('edit', $test)) {
    $form['actions']['delete'] = array(
      '#type' => 'submit',
      '#value' => t('Delete'),
      '#submit' => array('multivariate_form_submit_delete'),
    );
  }

  $form['#validate'][] = 'multivariate_form_validate';

  $form['#attached']['js'] = array(
    drupal_get_path('module', 'multivariate') . '/multivariate.js',
  );
  $form['#attached']['css'] = array(
    drupal_get_path('module', 'multivariate') . '/multivariate.css',
  );

  return $form;
}

/**
 * Multivariate test form validate handler.
 */
function multivariate_form_validate($form, &$form_state) {
  $test = $form_state['multivariate_test'];
  $run_condition = multivariate_ctools_access_get('run_condition');
  if (empty($run_condition[0]['plugins'])) {
    // @todo - minor problem here is that if there were run conditions and then
    // user deleted them and tried to submit form he will get this validation
    // error but he will also see old run conditions (that he deleted) - they
    // are deleted from cache but because form is not valid it will not be
    // submited and user will see old conditions.
    // That is why we will just show warning message for now and not trigger
    // validation error.
    // form_set_error('run_condition_fieldset', t('You didn\'t define run conditions.'));
    drupal_set_message(t("Note that you didn't define run conditions."), 'warning');
  }
  if (empty($test->variants_set)) {
    form_set_error('sets_fieldset', t("You didn't add mutations in variants."));
  }
  if (empty($test->success_condition)) {
    form_set_error('success_condition_fieldset', t("You didn't define success conditions."));
  }
}

/**
 * Multivariate test form submit handler.
 */
function multivariate_form_submit($form, &$form_state) {
  $test = $form_state['multivariate_test'];

  entity_form_submit_build_entity('multivariate_test', $test, $form, $form_state);

  // Clean our entity from form values that we do not need.
  unset($test->run_condition['add-button']);
  foreach ($test->variants_set as &$set) {
    unset($set['variants_number_control_wrapper']);
    unset($set['add_mutation_control']);
    foreach ($set['variants'] as &$variant) {
      foreach ($variant['mutations'] as $mkey => &$mutation) {
        unset($mutation['remove']);
        if (empty($mutation)) {
          // This means that mutation plugin do not exist any more, so lets
          // remove it.
          unset($variant['mutations'][$mkey]);
        }
      }
    }
  }
  foreach ($test->success_condition as $sckey => &$sc) {
    unset($sc['remove']);
    if (empty($sc)) {
      // This means that sc plugin do not exist any more, so lets remove it.
      unset($test->success_condition[$sckey]);
    }
  }

  // Get run conditions from ctools cache.
  if ($run_condition = multivariate_ctools_access_get('run_condition')) {
    $test->run_condition += $run_condition[0];
  }

  multivariate_save($test);

  $task_uri = entity_uri('multivariate_test', $test);
  $form_state['redirect'] = $task_uri['path'];
  drupal_set_message(t('Multivariate test %title saved.', array('%title' => entity_label('multivariate', $test))));
}

/**
 * Multivariate form delete submit handler.
 */
function multivariate_form_submit_delete($form, &$form_state) {
  $test_uri = entity_uri('multivariate_test', $form_state['multivariate_test']);
  $form_state['redirect'] = $test_uri['path'] . '/delete';
}

/**
 * Delete confirmation form.
 */
function multivariate_delete_form($form, &$form_state, $test) {
  $form_state['multivariate_test'] = $test;
  // Always provide entity id in the same form key as in the entity edit form.
  $form['multivariate_id'] = array('#type' => 'value', '#value' => entity_id('multivariate_test', $test));
  $task_uri = entity_uri('multivariate_test', $test);
  return confirm_form($form,
    t('Are you sure you want to delete multivariate test %title?', array('%title' => entity_label('multivariate_test', $test))),
    $task_uri['path'],
    t('This action cannot be undone.'),
    t('Delete'),
    t('Cancel')
  );
}

/**
 * Delete confirmation form submit handler.
 */
function multivariate_delete_form_submit($form, &$form_state) {
  $test = $form_state['multivariate_test'];
  multivariate_delete($test);

  drupal_set_message(t('Multivariate test %title deleted.', array('%title' => entity_label('multivariate_test', $test))));

  $form_state['redirect'] = '<front>';
}

/* Ajax Callbacks */

/**
 * Ajax callback.
 */
function multivariate_change_variants_number_ajax($form, $form_state) {
  $set_id = $form_state['clicked_button']['#set_id'];
  return $form['settings']['sets_fieldset']['variants_set'][$set_id]['variants'];
}

/**
 * Ajax callback for add/remove variants set.
 */
function multivariate_change_sets_number_ajax($form, $form_state) {
  return $form['settings']['sets_fieldset']['variants_set'];
}

/**
 * Ajax callback for add/remove mutation.
 */
function multivariate_change_mutations_ajax($form, $form_state) {
  $set_id = $form_state['clicked_button']['#set_id'];
  return $form['settings']['sets_fieldset']['variants_set'][$set_id]['variants'];
}

/**
 * Ajax callback for add/remove success condition.
 */
function multivariate_change_success_condition_ajax($form, &$form_state) {
  return $form['settings']['success_condition_fieldset']['success_condition'];
}

/**
 * Validation handler for variants number change.
 */
function multivariate_change_variants_number_validate($form, &$form_state) {
  $set_id = $form_state['clicked_button']['#set_id'];
  $new_variants_num = $form_state['values']['variants_set'][$set_id]['variants_number_control_wrapper']['variants_number'];
  if ($new_variants_num < 2) {
    form_set_error('sets[' . $set_id . '][variants_number_control_wrapper][variants_number]', t('Variants number can not be less then 2.'));
  }
}

/**
 * Submit handler for variants number change.
 */
function multivariate_change_variants_number_submit($form, &$form_state) {
  $set_id = $form_state['clicked_button']['#set_id'];
  $set =& $form_state['values']['variants_set'][$set_id];
  $vnum = count($set['variants']);
  $new_variants_num = $set['variants_number_control_wrapper']['variants_number'];
  $diff = $new_variants_num - $vnum;
  if ($diff < 0) {
    // Remove variants - start from end of variants array.
    for ($i = 0; $i < -$diff; ++$i) {
      unset($form_state['multivariate_test']->variants_set[$set_id]['variants'][$vnum - $i - 1]);
    }
  }
  elseif ($diff > 0) {
    // Add new cloned variants - we are cloning mutations plugin info only.
    // We will always clone from first variant.
    foreach ($form_state['values']['variants_set'][$set_id]['variants'][0]['mutations'] as $mutation) {
      $variant_clone['mutations'][]['plugin'] = $mutation['plugin'];
    }
    for ($i = 0; $i < $diff; ++$i) {
      $form_state['multivariate_test']->variants_set[$set_id]['variants'][] = $variant_clone;
    }
  }

  $form_state['rebuild'] = TRUE;
}

/**
 * Submit handler for add set.
 */
function multivariate_add_set_submit($form, &$form_state) {
  $form_state['multivariate_test']->variants_set[] = MultivariateTest::createVariantsSet();
  $form_state['rebuild'] = TRUE;
}

/**
 * Submit handler for removing of set.
 */
function multivariate_remove_set_submit($form, &$form_state) {
  $set_id = $form_state['clicked_button']['#set_id'];
  unset($form_state['multivariate_test']->variants_set[$set_id]);
  $form_state['rebuild'] = TRUE;
}

/**
 * Submit handler for mutation adding.
 */
function multivariate_add_mutation_submit($form, &$form_state) {
  $set_id = $form_state['clicked_button']['#set_id'];
  $mutation_plugin = $form_state['values']['variants_set'][$set_id]['add_mutation_control']['select_mutation'];
  // We don't have validation is some plugin really selected in select element
  // so we will check here.
  if ($mutation_plugin) {
    $variants =& $form_state['multivariate_test']->variants_set[$set_id]['variants'];
    foreach ($variants as $key => $variant) {
      $variants[$key]['mutations'][] = array('plugin' => $mutation_plugin);
    }
  }
  $form_state['rebuild'] = TRUE;
}

/**
 * Submit handler for mutation removing.
 */
function multivariate_remove_mutation_submit($form, &$form_state) {
  $set_id = $form_state['clicked_button']['#set_id'];
  $mutation_id = $form_state['clicked_button']['#mutation_id'];
  $variants =& $form_state['multivariate_test']->variants_set[$set_id]['variants'];
  foreach ($variants as $key => $variant) {
    unset($variants[$key]['mutations'][$mutation_id]);
  }
  $form_state['rebuild'] = TRUE;
}

/**
 * Submit handler for success condition adding.
 */
function multivariate_add_success_condition_submit($form, &$form_state) {
  $sc_plugin = $form_state['values']['add_success_condition_control']['success_condition_plugin'];
  // We don't have validation is some plugin really selected in select element
  // so we will check here.
  if ($sc_plugin) {
    $form_state['multivariate_test']->success_condition[] = array('plugin' => $sc_plugin);
  }
  $form_state['rebuild'] = TRUE;
}

/**
 * Submit handler for success condition removing.
 */
function multivariate_remove_success_condition_submit($form, &$form_state) {
  $sc_id = $form_state['clicked_button']['#success_condition_id'];
  unset($form_state['multivariate_test']->success_condition[$sc_id]);
  $form_state['rebuild'] = TRUE;
}

/* Helpers */

/**
 * Generates success conditions field set.
 */
function multivariate_conditions_fieldset($test, &$form, $form_state) {
  $run_condition_fieldset = array(
    '#type' => 'fieldset',
    '#title' => t('Run conditions'),
    '#description' => t('Run conditions for this test.'),
    '#collapsible' => TRUE,
    '#group' => 'settings',
    '#weight' => 0,
  );

  // If we are not in form submit this means we come to do form for the first
  // time so lets clear ctools cache we are using.
  if (!$form_state['submitted']) {
    multivariate_ctools_access_clear('run_condition');
  }

  // Check if we have run conditions in ctools cache.
  if ($cache = multivariate_ctools_access_get('run_condition') && !empty($cache[0])) {
    $access = $cache[0];
  }
  // If cache is empty lets then check if test has run conditions.
  elseif (isset($test->run_condition['plugins'])) {
    $access = $test->run_condition;
    multivariate_ctools_access_set('run_condition', $access);
  }
  else {
    $access = array();
  }

  ctools_include('context-access-admin');
  $form_state += array(
    'access' => $access,
    'module' => 'multivariate',
    'callback argument' => 'run_condition',
    // An array of contexts. Optional if no contexts.
    // 'logged-in-user' will be added if not present as the access system
    // requires this context.
    'contexts' => array(),
    'no buttons' => TRUE,
  );
  $run_condition_form = array();
  $run_condition_fieldset['run_condition'] = ctools_access_admin_form($run_condition_form, $form_state);
  // This is also needed so ctools_access_admin_form() select box will not
  // overwrite node type info in our $form_state.
  $run_condition_fieldset['run_condition']['#tree'] = TRUE;

  $form['settings']['run_condition_fieldset'] = $run_condition_fieldset;
}

/**
 * Helper function for adding sets fieldset to multivariate test edit form.
 *
 * @param object $test
 *   Multivariate test entity.
 * @param array $form
 *   Form array.
 * @param array $form_state
 *   Form state array.
 */
function multivariate_variants_sets_fieldset($test, &$form, $form_state) {
  $plugins_info = multivariate_api_info('mutation');

  $sets_fieldset = array(
    '#type' => 'fieldset',
    '#title' => t('Sets and variants'),
    '#description' => t('Please note that any test recorded data that are already saved <strong>will be lost</strong> if you add or remove: mutations, variants, or sets.'),
    '#collapsible' => TRUE,
    '#group' => 'settings',
    '#weight' => 1,
  );

  // If we do not have any mutation plugin enabled tell that to the user and
  // return.
  if (empty($plugins_info)) {
    $sets_fieldset['install_plugins'] = array('#markup' => '<div>' . t('Please enable some plugins first.') . '</div>');
    $form['settings']['sets_fieldset'] = $sets_fieldset;
    return;
  }

  // Create all sets plugin form elements.
  $sets_fieldset['variants_set'] = array(
    '#prefix' => '<div id="multivariate-variants-sets">',
    '#suffix' => '</div>',
    '#tree' => TRUE,
  );

  foreach ($test->variants_set as $set_id => $set) {
    $sets_fieldset['variants_set'][$set_id] = array(
      '#type' => 'fieldset',
      '#collapsible' => TRUE,
      '#title' => t('Set !num: @title', array('!num' => $set_id + 1, '@title' => $set['title'])),
    );
    $set_element =& $sets_fieldset['variants_set'][$set_id];

    $set_element['title'] = array(
      '#type' => 'textfield',
      '#title' => t('Title'),
      '#default_value' => isset($set['title']) ? $set['title'] : '',
    );

    $variants_num = count($set['variants']);

    // Variants number control.
    $set_element['variants_number_control_show'] = array(
      '#prefix' => '<div class="variants-number-control-show">',
      '#suffix' => '</div>',
      '#markup' => t(
        'Number of variants: !num, !change.',
        array(
          '!num' => $variants_num,
          '!change' => '<a href="#" class="variant-change">' . t('change') . '</a>',
        )
      ),
    );
    $set_element['variants_number_control_wrapper'] = array(
      '#prefix' => '<div class="variants-number-control">',
      '#suffix' => '</div>',
    );
    $set_element['variants_number_control_wrapper']['variants_number'] = array(
      '#type' => 'textfield',
      '#default_value' => $variants_num,
      '#size' => 2,
      '#maxlength' => 2,
    );
    $set_element['variants_number_control_wrapper']['change_variants_number'] = array(
      '#type' => 'submit',
      '#name' => 'set-' . $set_id . '-change-variant',
      '#value' => t('Change number of variants'),
      '#set_id' => $set_id,
      '#ajax' => array(
        'callback' => 'multivariate_change_variants_number_ajax',
        'wrapper' => 'set-' . $set_id . '-variants',
      ),
      '#limit_validation_errors' => array(array('variants_set', $set_id)),
      '#validate' => array('multivariate_change_variants_number_validate'),
      '#submit' => array('multivariate_change_variants_number_submit'),
    );

    // Add variants.
    $set_element['variants'] = array(
      '#prefix' => '<div id="set-' . $set_id . '-variants">',
      '#suffix' => '</div>',
    );
    $variant_id = 0;
    foreach ($set['variants'] as $variant) {
      $variant_element = array(
        '#type' => 'fieldset',
        '#title' => t('Variant !num', array('!num' => $variant_id + 1)),
      );
      $variant_element['title'] = array(
        '#type' => 'textfield',
        '#title' => t('Title'),
        '#default_value' => isset($variant['title']) ? $variant['title'] : '',
      );
      if (!empty($variant['mutations'])) {
        $mutations_count = count($variant['mutations']);
        foreach ($variant['mutations'] as $mutation_id => $mutation) {
          $mutation_element = array();
          // Handle missing plugin situation.
          if (!isset($plugins_info[$mutation['plugin']])) {
            $mutation_element['missing_plugin'] = array('#markup' => '<div>' . t('Plugin !plugin is missing.', array('!plugin' => $mutation['plugin'])) . '</div>');
          }
          else {
            $plugin = $plugins_info[$mutation['plugin']];
            $mutation['variant_id'] = $variant_id;
            $mutation_element = multivariate_plugin_mutation_execute($mutation['plugin'], $plugin['mutation form'], array($mutation));
            $mutation_element['plugin'] = array('#type' => 'value', '#value' => $mutation['plugin']);
          }
          $mutation_element['#prefix'] = '<div class="mutation mutation-' . $mutation_id . ($mutation_id + 1 == $mutations_count ? ' mutation-last' : '') . '">';
          $mutation_element['#suffix'] = '</div>';
          if ($variant_id == 0) {
            // Only first variant has buttons for mutation removing.
            $mutation_element['remove'] = array(
              '#type' => 'submit',
              '#name' => 'set-' . $set_id . '-mutation-' . $mutation_id,
              '#set_id' => $set_id,
              '#mutation_id' => $mutation_id,
              '#value' => t('Remove'),
              '#ajax' => array(
                'callback' => 'multivariate_change_mutations_ajax',
                'wrapper' => 'set-' . $set_id . '-variants',
              ),
              '#limit_validation_errors' => array(array('variants_set', $set_id, 'variants', $variant_id, 'mutations', $mutation_id)),
              '#submit' => array('multivariate_remove_mutation_submit'),
            );
          }
          $variant_element['mutations'][$mutation_id] = $mutation_element;
        }
      }
      else {
        $variant_element['#description'] = t('Please add at least one mutation.');
        // Add empty mutations element.
        $variant_element['mutations'] = array(
          '#type' => 'value',
          '#value' => array(),
        );
      }
      $set_element['variants'][$variant_id] = $variant_element;
      ++$variant_id;
    }

    // Add new mutation control.
    $options = array(t('Select mutation plugin'));
    foreach ($plugins_info as $key => $value) {
      $options[$key] = $value['label'];
    }
    $set_element['add_mutation_control'] = array(
      '#prefix' => '<div class="add-mutation-control">',
      '#suffix' => '</div>',
    );
    $set_element['add_mutation_control']['select_mutation'] = array(
      '#type' => 'select',
      '#options' => $options,
    );
    $set_element['add_mutation_control']['add_mutation'] = array(
      '#type' => 'submit',
      '#name' => 'set-' . $set_id . '-add-mutation',
      '#set_id' => $set_id,
      '#value' => t('Add mutation'),
      '#ajax' => array(
        'callback' => 'multivariate_change_mutations_ajax',
        'wrapper' => 'set-' . $set_id . '-variants',
      ),
      '#limit_validation_errors' => array(array('variants_set', $set_id)),
      '#submit' => array('multivariate_add_mutation_submit'),
    );

    // There should be always be at least one set, so don't add remove button
    // for first set.
    if ($set_id > 0) {
      $set_element['remove'] = array(
        '#name' => 'remove-set-' . $set_id,
        '#type' => 'submit',
        '#set_id' => $set_id,
        '#value' => t('Remove this set'),
        '#attributes' => array('class' => array('remove-set-button')),
        '#ajax' => array(
          'callback' => 'multivariate_change_sets_number_ajax',
          'wrapper' => 'multivariate-variants-sets',
        ),
        '#limit_validation_errors' => array(array('variants_set', 'remove')),
        '#submit' => array('multivariate_remove_set_submit'),
      );
    }

    ++$set_id;
  }

  // Adding new set.
  $sets_fieldset['add_set'] = array(
    '#type' => 'submit',
    '#value' => t('Add set'),
    '#ajax' => array(
      'callback' => 'multivariate_change_sets_number_ajax',
      'wrapper' => 'multivariate-variants-sets',
    ),
    '#limit_validation_errors' => array(array('variants_set', 'add_set')),
    '#submit' => array('multivariate_add_set_submit'),
  );

  $form['settings']['sets_fieldset'] = $sets_fieldset;
}

/**
 * Helper function for adding success conditions fieldset to multivariate
 * study node edit form.
 *
 * @param object $test
 *   Multivariate test entity.
 * @param array $form
 *   Form array.
 * @param array $form_state
 *   Form state array.
 */
function multivariate_success_conditions_fieldset($test, &$form, $form_state) {
  $plugins_info = multivariate_api_info('success_condition');

  $success_condition_fieldset = array(
    '#type' => 'fieldset',
    '#title' => t('Success conditions'),
    '#description' => t('Please note that if you add/remove success conditions any test recorded data that are already saved <b>will be lost</b>.'),
    '#collapsible' => TRUE,
    '#group' => 'settings',
    '#weight' => 2,
  );

  // If we do not have any success plugin enabled tell that to the user and
  // return.
  if (empty($plugins_info)) {
    $success_condition_fieldset['install_plugins'] = array('#markup' => '<div>' . t('Please enable some plugins first.') . '</div>');
    $form['settings']['success_condition_fieldset'] = $success_condition_fieldset;
    return;
  }

  // Create all sets plugin form elements.
  $success_condition_fieldset['success_condition'] = array(
    '#prefix' => '<div id="success-conditions">',
    '#suffix' => '</div>',
    '#tree' => TRUE,
  );

  $sc_count = count($test->success_condition);
  foreach ($test->success_condition as $sc_id => $success_condition) {
    $element = array();
    if (!isset($plugins_info[$success_condition['plugin']])) {
      // Handle missing plugin situation.
      $element['missing_plugin'] = array('#markup' => '<div>' . t('Plugin !plugin is missing.', array('!plugin' => $success_condition['plugin'])) . '</div>');
    }
    else {
      $plugin = $plugins_info[$success_condition['plugin']];
      $element = multivariate_plugin_success_condition_execute($success_condition['plugin'], $plugin['sc form'], array($success_condition));
      $element['plugin'] = array('#type' => 'value', '#value' => $success_condition['plugin']);
    }
    $element['#prefix'] = '<div class="success-condition success-condition-' . $sc_id . ($sc_id + 1 == $sc_count ? ' success-condition-last' : '') . '">';
    $element['#suffix'] = '</div>';
    $element['remove'] = array(
      '#type' => 'submit',
      '#name' => 'remove-success-condition-' . $sc_id,
      '#success_condition_id' => $sc_id,
      '#value' => t('Remove'),
      '#ajax' => array(
        'callback' => 'multivariate_change_success_condition_ajax',
        'wrapper' => 'success-conditions',
      ),
      '#limit_validation_errors' => array(array('success_condition'), array('add_success_condition_control')),
      '#submit' => array('multivariate_remove_success_condition_submit'),
    );
    $success_condition_fieldset['success_condition'][$sc_id] = $element;
  }

  // Control for adding new success condition.
  $options[] = t('Select new condition');
  foreach ($plugins_info as $key => $value) {
    $options[$key] = $value['label'];
  }
  $success_condition_fieldset['add_success_condition_control'] = array(
    '#prefix' => '<div class="add-mutation-control">',
    '#suffix' => '</div>',
    '#tree' => TRUE,
    'success_condition_plugin' => array(
      '#type' => 'select',
      '#options' => $options,
    ),
    'success_condition_add' => array(
      '#type' => 'submit',
      '#name' => 'add-success-condition',
      '#value' => t('Add condition'),
      '#ajax' => array(
        'callback' => 'multivariate_change_success_condition_ajax',
        'wrapper' => 'success-conditions',
      ),
      '#limit_validation_errors' => array(array('success_condition'), array('add_success_condition_control')),
      '#submit' => array('multivariate_add_success_condition_submit'),
    ),
  );

  $form['settings']['success_condition_fieldset'] = $success_condition_fieldset;
}
