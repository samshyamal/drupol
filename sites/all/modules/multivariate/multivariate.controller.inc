<?php

/**
 * @file
 * Multivariate entity and controller classes.
 */

class MultivariateTestController extends EntityAPIControllerExportable {

  public function create(array $values = array()) {
    global $user;
    $values += array(
      'title' => '',
      'description' => '',
      'created' => REQUEST_TIME,
      'changed' => REQUEST_TIME,
      'uid' => $user->uid,
      'enabled' => TRUE,
      'run_condition' => array(),
      'variants_set' => array(MultivariateTest::createVariantsSet()),
      'success_condition' => array(),
    );
    return parent::create($values);
  }

  public function buildContent($entity, $view_mode = 'full', $langcode = NULL, $content = array()) {
    $wrapper = entity_metadata_wrapper('multivariate_test', $entity);
    $content['basic_info']['title'] = array(
      '#markup' => '<h3>' . t('Basic info') . '</h3>',
    );
    $content['basic_info']['author'] = array(
      '#markup' => '<div>' . t('Created by !author on !date.',
        array(
          '!author' => theme('username', array('account' => $wrapper->user->value())),
          '!date' => format_date($wrapper->created->value()),
        )) . '</div>',
    );
    $content['basic_info']['enabled'] = array('#markup' => '<div>' . t('Test is !enabled.', array('!enabled' => $wrapper->enabled->value() ? t('enabled') : t('disabled'))) . '</div>');

    // Make Description and Status themed like default fields.
    $content['basic_info']['description'] = array(
      '#theme' => 'field',
      '#title' => t('Description'),
      '#access' => TRUE,
      '#label_display' => 'above',
      '#view_mode' => 'full',
      '#language' => LANGUAGE_NONE,
      '#field_name' => 'field_fake_description',
      '#field_type' => 'text',
      '#entity_type' => 'multivariate_test',
      '#bundle' => 'multivariate_test',
      '#items' => array(array('value' => $entity->description)),
      '#formatter' => 'text_default',
      0 => array('#markup' => check_plain($entity->description)),
    );

    // Render results table.
    $entity->multivariate_results = multivariate_get_results($entity);
    $header = array(
      t('Variants Combination'),
      t('Hits'),
      t('Success'),
      t('Ratio [%]'),
    );
    $rows = array();
    foreach ($entity->multivariate_results as $data) {
      $rows[] = array(
        $data['labels'],
        $data['count'],
        $data['success'],
        sprintf('%.2f', $data['ratio'] * 100),
      );
    }
    $content['table_result'] = array(
      'title' => array('#markup' => '<h3>' . t('Table results') . '</h3>'),
      'table' => array(
        '#markup' => theme('table', array(
          'header' => $header,
          'rows' => $rows,
          'attributes' => array('id' => 'multivariate-test-results-table'),
          'empty' => t('There is no multivariate tests, create one first.'),
        )),
      ),
    );

    return parent::buildContent($entity, $view_mode, $langcode, $content);
  }

  public function save($entity, DatabaseTransaction $transaction = NULL) {
    $entity->run_condition = serialize($entity->run_condition);
    $entity->variants_set = serialize($entity->variants_set);
    $entity->success_condition = serialize($entity->success_condition);
    parent::save($entity, $transaction);
    // Restore back so we can use them - @todo UGLY, there has to be better
    // way for this!!!
    $entity->run_condition = unserialize($entity->run_condition);
    $entity->variants_set = unserialize($entity->variants_set);
    $entity->success_condition = unserialize($entity->success_condition);
  }

}

/**
 * UI controller for Multivariate study.
 */
class MultivariateUIController extends EntityDefaultUIController {

  public function hook_menu() {
    $items = parent::hook_menu();
    $items[$this->path]['description'] = 'Manage multivariate tests.';
    return $items;
  }

}

/**
 * Multivariate test class.
 */
class MultivariateTest extends Entity {

  public static function createVariantsSet() {
    return array(
      'title' => '',
      'variants' => array(
        // @todo - Why is this doubled?
        array('mutations' => array()),
        array('mutations' => array()),
      ),
    );
  }

  protected function defaultLabel() {
    return $this->title;
  }

  protected function setUp() {
    // @todo - is there a better way to unserilize arrays only when we need
    // to do it - on load.
    // MultivariateTestController:load is not fully OK because we are
    // loosing cache.
    if (!isset($this->is_new)) {
      if (isset($this->run_condition) && is_string($this->run_condition)) {
        $this->run_condition = unserialize($this->run_condition);
      }
      if (isset($this->variants_set) && is_string($this->variants_set)) {
        $this->variants_set = unserialize($this->variants_set);
      }
      if (isset($this->success_condition) && is_string($this->success_condition)) {
        $this->success_condition = unserialize($this->success_condition);
      }
    }
    parent::setUp();
  }

  protected function defaultUri() {
    return array('path' => 'multivariate/' . $this->identifier());
  }

}
