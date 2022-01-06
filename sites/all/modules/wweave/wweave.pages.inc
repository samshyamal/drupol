<?php

/**
 * Page callback for /homepage
 */
function wweave_homepage() {
  global $wweave_domain;
  #$homepage_nid = $wweave_domain['homepage'];
//  $homepage_nid = 4244;
 // $homepage_node = node_load($homepage_nid);
 // return node_page_view($homepage_node);
 return theme('wweave_homepage');

}

/**
 * Page callback for /cart
 */
function wweave_cart() {
  if(isset($_POST['flag'])){
    $cart_response=get_user_cart();
    echo json_encode($cart_response);
  }
  if(isset($_POST['shipmentMethodId'])){
    $shipping_method = @strip_tags($_POST['shipmentMethodId']);
    $cart_response=get_user_cart($shipping_method);
    echo json_encode($cart_response);
  }
  else{
  return theme('wweave_cart', array('shipping_method' => get_shipping_methods(), 'cart' => get_user_cart() , 'partyId' => get_user_party_id(), 'viewPromo' => wweave_view_promocode(),));
 }
}

/**
 * Page callback for /checkout
 */
function wweave_checkout() {
  return theme('wweave_checkout', array(
    'cart' => get_user_cart(),
    'addresses' => get_user_addresses(),
  ));
}

/**
 * Page callback for /checkout/update-cart-address
 */
function wweave_update_cart_address() {
  $update_address = update_cart_address($_POST['contactMechId']);
  if (empty($update_address['_ERROR_MESSAGE_'])) {
    // Address updated successfully; set session!
    $addresses = get_user_addresses();
    foreach ($addresses['postalAddressList'] as $address) {
      if ($address['contactMechId'] == $_POST['contactMechId']) {
        $toName = explode(' ', $address['toName']);
        $first_name = $toName[0];
        array_shift($toName);
        $last_name = implode(' ', $toName);
        $_SESSION['wweave']['checkout_address'] = array(
          'SHIPPING_POSTAL_CODE'  => $address['postalCode'],
          'SHIPPING_ADDRESS1'     => $address['address1'],
          'SHIPPING_FIRST_NAME'   => $first_name,
          'SHIPPING_LAST_NAME'    => $last_name,
          'SHIPPING_ATTN_NAME'    => $address['attnName'],
          'SHIPPING_CITY'         => $address['city'],
          'PHONE_MOBILE_CONTACT'  => $address['contactNumber'],
          'SHIPPING_STATE'        => $address['stateProvinceGeoId'],
        );
        break;
      }
    }
  }
  echo json_encode($update_address);
}

/**
 * Page callback for /view-order/%
 */
function wweave_view_order($order_id) {
  unset($_SESSION['wweave']['CODAvailable']);
  $endpoint = 'eCommerceOrderDetailNew';
  $params = array(
    'orderId' => $order_id,
    'partyId' => get_user_party_id(),
  );
  $jsessionid = NULL;
  if (empty($GLOBALS['user']->uid)) {
    // Anonymous user
    // /eCommerceOrderDetailNew;jsessionid=2520572C9D11330989E0C1998400BE39.jvm1?orderId=RNYCO10190&partyId=10010
    $jsessionid = get_user_jsessionid();
    if (!empty($jsessionid)) {
      $endpoint .= (';jsessionid=' . urlencode($jsessionid));
    }
  }
  else {
    // Logged in user
    // /eCommerceOrderDetailNew?orderId=RNYCO10190&partyId=10010
    // Party ID is already added above.
  }

  $client = wweave_api_client();
  $response = $client->get($endpoint . '?' . http_build_query($params));

  $raw_json = $response->getBody();
  $data = json_decode($raw_json, TRUE);

  watchdog(__FUNCTION__, print_r(compact('endpoint', 'params', 'data'),1));

  if (empty($GLOBALS['user']->uid)) {
    unset($_SESSION['wweave']);
  }

  return theme('wweave_view_order', array('order' => $data));
}

/**
 * Page callback for /checkout-final
 */
function wweave_checkout_final() {
  $paymentMethodTypeId ='EXT_CCA';
  $params = array(
    'productStoreId' => 'RNY_STORE',
    'paymentMethodTypeId' => $paymentMethodTypeId, // TODO: This is hard coded for now.
  );
  if (empty($GLOBALS['user']->uid)) {
    // Anonymous user
    // /anonMultiPageGenerateOrderNew;jsessionid=807ee961cda1fe828f6da4e92c032dd79.jvm1?paymentMethodTypeId=EXT_COD
    $endpoint = 'anonMultiPageGenerateOrderNew';
    $jsessionid = get_user_jsessionid();
    if (!empty($jsessionid)) {
      $endpoint .= (';jsessionid=' . urlencode($jsessionid));
    }
  }
  else {
    // Logged in user
    // /multiPageGenerateOrderNew?partyId=10010
    $endpoint = 'multiPageGenerateOrderNew';
    $params['partyId'] = get_user_party_id();
  }

  $client = wweave_api_client();
  $response = $client->get($endpoint . '?' . http_build_query($params));
  $raw_json = $response->getBody();
  $data = json_decode($raw_json, TRUE);

  watchdog(__FUNCTION__, '<pre>' . print_r(compact('endpoint', 'params', 'data'), 1) . '</pre>');

  echo json_encode($data);
}

/**
 * Page callback for /wweave/add-address
 */
function wweave_add_address() {
  $params = array(
    'SHIPPING_POSTAL_CODE'  => $_POST['SHIPPING_POSTAL_CODE'],
    'SHIPPING_ADDRESS1'     => $_POST['SHIPPING_ADDRESS1'],
    'SHIPPING_FIRST_NAME'   => $_POST['SHIPPING_FIRST_NAME'],
    'SHIPPING_LAST_NAME'    => $_POST['SHIPPING_LAST_NAME'],
    'SHIPPING_ATN_NAME'     => $_POST['SHIPPING_ATTN_NAME'],
    'SHIPPING_CITY'         => $_POST['SHIPPING_CITY'],
    'PHONE_MOBILE_CONTACT'  => $_POST['PHONE_MOBILE_CONTACT'],
    'SHIPPING_STATE'        => $_POST['SHIPPING_STATE'],
    'paymentOption'         => 'PAYOPT_COD', //EXT_COD', // TODO: Hardcoded for now.
    'SHIPPING_USE_SCREEN'   => 'SHIPPING', // TODO: Hardcoded for now.
    //'shipping_method'       => 'STANDARD@DELHIVERY', // TODO: Hardcoded for now. Other options: NO_SHIPPING@_NA_
    'productStoreId'        => 'RNY_STORE',
  );
  if (empty($GLOBALS['user']->uid)) {
    // Anonymous user
    // /anonMultiPageCreateCustomerNew;jsessionid=807E961CDA1FE828F6DA4E92C032DD79.jvm1?SHIPPING_POSTAL_CODE=11001&SHIPPING_ADDRESS1=sonatatowers&SHIPPING_LAST_NAME=guest&SHIPPING_ATTN_NAME=offic9&SHIPPING_CITY=Hyderabad&PHONE_MOBILE_CONTACT=8956235689&SHIPPING_FIRST_NAME=test&SHIPPING_STATE=NY&SHIPPING_USE_SCREEN=SHIPPING&SHIPPING_COUNTRY=USA&paymentOption=PAYOPT_COD
    $endpoint = 'anonMultiPageCreateCustomerNew';
    $jsessionid = get_user_jsessionid();
    if (!empty($jsessionid)) {
      $endpoint .= (';jsessionid=' . urlencode($jsessionid));
    }
    $params['SHIPPING_ATTN_NAME'] = $params['SHIPPING_ATN_NAME'];
    unset($params['SHIPPING_ATN_NAME']);
  }
  else {
    // Logged in user
    // /multiPageAddOrUpdateCustomerAddressNew?partyId=100010&SHIPPING_POSTAL_CODE=11001&SHIPPING_ADDRESS1=sonatatowers&SHIPPING_LAST_NAME=testi&SHIPPING_ATN_NAME=ossther&SHIPPING_CITY=Hyderabad&PHONE_MOBILE_CONTACT=8956235689&SHIPPING_FIRST_NAME=test&SHIPPING_STATE=NY&paymentOption=EXT_COD&SHIPPING_USE_SCREEN=SHIPPING&shipping_method=STANDARD@DELHIVERY

    //multiPageAddOrUpdateCustomerAddressNew;jsessionid=761B8EC520026CEBA8536B0442770846.jvm1?partyId=10145&SHIPPING_POSTAL_CODE=10002&SHIPPING_ADDRESS1=ydyd&SHIPPING_LAST_NAME=yd&SHIPPING_ATN_NAME=other&SHIPPING_CITY=hxh&PHONE_MOBILE_CONTACT=6533568686&SHIPPING_FIRST_NAME=yfy&SHIPPING_STATE=NY&paymentOption=PAYOPT_COD&SHIPPING_USE_SCREEN=SHIPPING
    $endpoint = 'multiPageAddOrUpdateCustomerAddressNew';
    $params['partyId'] = get_user_party_id();
  }

  $client = wweave_api_client();
  $response = $client->get($endpoint . '?' . http_build_query($params));

  $_SESSION['wweave']['checkout_address'] = $_POST;

  $raw_json = $response->getBody();
  $data = json_decode($raw_json, TRUE);
  if(!empty($data['CODAvailable'])){
    $_SESSION['wweave']['CODAvailable'] = $data['CODAvailable'];
  }
  if (empty($GLOBALS['user']->uid)) {
    if (!empty($data['partyId'])) {
      $_SESSION['wweave']['party_id'] = $data['partyId'];
    }
  }

  watchdog(__FUNCTION__, '<pre>' . print_r(compact('endpoint', 'params', 'data'), 1) . '</pre>');

  echo json_encode($data);
}

/**
 * Page callback for /checkout-payment
 */
function wweave_checkout_payment() {
  $client = wweave_api_client();
  $response = $client->get('partyStoreCreditPayment?'. http_build_query(array(

  )));
  $raw_json = $response->getBody();
  $storeCredit = json_decode($raw_json,TRUE);
return theme('wweave_checkout_payment', array('cart' => get_user_cart(),'storeCredit' => $storeCredit));
}

/**
 * Page callback for /wweave/user-change-password
 */
function wweave_user_change_password() {
  $return = array(
    'error' => FALSE,
    'error_messages' => array(),
  );

  global $user;
  require_once DRUPAL_ROOT . '/' . variable_get('password_inc', 'includes/password.inc');
  $current_password     = $_POST['OLD_PASSWORD'];
  $new_password         = $_POST['NEW_PASSWORD'];
  $confirm_new_password = $_POST['CONFIRM_PASSWORD']; 

  $password_validated = user_check_password($current_password, $user);

  if ($password_validated == "") {
    $return['error'] = TRUE;
    $return['error_messages'][] = 'Current Password is incorrect!';
  }
  if($current_password == $new_password) {
    $return['error'] = TRUE;
    $return['error_messages'][] = 'Current and New Password are same!';
  }
  if (strlen($new_password) > 0 || strlen($confirm_new_password) > 0) {
    if ($new_password != $confirm_new_password) {
      $return['error'] = TRUE;
      $return['error_messages'][] = 'The specified passwords do not match!';
    }
  }
  else {
    $return['error'] = TRUE;
    $return['error_messages'][] = 'Password fields are required!';
  }

  if (!$return['error']) {
    $updated_password = user_hash_password($confirm_new_password);
    $user->pass = $updated_password;
    user_save($user);

    // Update password on Ofbiz.
    wweave_change_password($current_password, $new_password);

    drupal_set_message('Password Updated Successfully.');
  }

  echo json_encode($return);
}

/**
 * Page callback for /wweave/user
 */
function wweave_user() {
  $return = array(
    'error' => TRUE,
    'error_messages' => array(),
    'destination' => url()
  );
  $username = @$_POST['USERNAME'];
  $password = @$_POST['PASSWORD'];
  $account = user_load_by_mail($username);
  if (!empty($account->uid)) {
    $user_authenticated_uid = user_authenticate($account->name, $password);
    if (!empty($user_authenticated_uid)) {
      global $user;
       
	  $GLOBALS['wweave_skip_user_integration'] = TRUE;
	   
      // Log the user into Drupal first! We'll log them out later if Ofbiz fails.
      $user = user_load($user_authenticated_uid);
      user_login_finalize();

      // Login to Ofbiz
      list($data, $response) = ofbiz_login($username, $password);

      if (empty($data['_ERROR_MESSAGE_'])) {
        $raw_headers = $response->getHeaders();
        // Merge cookies.
        if (!empty($_SESSION['wweave']['headers']['Set-Cookie'])) {
          $raw_headers['Set-Cookie'] = array_merge($_SESSION['wweave']['headers']['Set-Cookie'], $raw_headers['Set-Cookie']);
        }
        $_SESSION['wweave']['headers'] = $raw_headers;
        $_SESSION['wweave']['session'] = $data;
        $return['error'] = FALSE;
        drupal_set_message('User logged in!');
        // dsm($raw_headers);
        // dsm($_SESSION['wweave']);
        if (!empty($_POST['REDIR'])) {
          drupal_goto();
        }
      }
      else {
        global $user;
        $return['error_messages'][] = $data['_ERROR_MESSAGE_'];
        $user = user_load(0);
        unset($_SESSION['wweave']);
        drupal_session_regenerate();
      }
    }
    else {
      $return['error_messages'][] = 'Invalid username / password.';
    }
  }
  else {
    $return['error_messages'][] = 'Invalid username.';
  }

  echo json_encode($return);
}

/**
 * Page callback for /wweave/demo-user-register
 */
function wweave_demo_user_register() {
  $return = array(
    'error' => TRUE,
    'error_messages' => array(),
    'status_messages' => array(),
  );

  $request_body = file_get_contents('php://input');
  $request = json_decode($request_body, TRUE);

  $name = @$request['name'];
  $email = @$request['email'];
  $disable_date = !empty($request['disable_date']) ? $request['disable_date'] : strtotime('+9 days'); // 7 + 2 days.

  $name_pieces = explode(' ', $name);
  $first_name = array_shift($name_pieces);
  $last_name = implode(' ', $name_pieces);
  $password = wweave_demo_password($email);
  $demo_administrator_role = wweave_get_demo_administrator_role();

  $user_exists = user_load_by_mail($email);
  if (empty($name)) {
    $return['error_messages'][] = 'Please enter a name.';
  }
  else if (!valid_email_address($email)) {
    $return['error_messages'][] = 'Please enter a valid email. ' . check_plain($email) . ' is not valid.';
  }
  else if (empty($demo_administrator_role)) {
    $return['error_messages'][] = 'Demo Administator Role does not exist.';
  }
  else if (!empty($user_exists->uid)) {
    // User exists, already registered! Good to go!
    $return['error'] = FALSE;
    $return['status_messages'][] = 'User already registered!';
  }
  else {
    // /createCustAppSrc?USER_FIRST_NAME=new1&CONFIRM_PASSWORD=123456&PHONE_MOBILE_CONTACT_OTHER=9656031022&PASSWORD=123456&CUSTOMER_EMAIL_CONFIRM=this604@sonata-software.com&USER_LAST_NAME=abhinav&CUSTOMER_EMAIL=this604@sonata-software.com&USERNAME=new&DISABLE_DATE=2017-02-06 17:05:16&ISADMIN=false
    $client = wweave_api_client();
    $request = 'createCustAppSrc?' . http_build_query(array(
      'USER_FIRST_NAME'            => $first_name,
      'USER_LAST_NAME'             => $last_name,
      'PASSWORD'                   => $password,
      'CONFIRM_PASSWORD'           => $password,
      'PHONE_MOBILE_CONTACT_OTHER' => '5555555555', // TODO: We don't have their phone!
      'CUSTOMER_EMAIL_CONFIRM'     => $email,
      'CUSTOMER_EMAIL'             => $email,
      'USERNAME'                   => $email,
      'DISABLE_DATE'               => date('Y-m-d H:i:s', $disable_date),
      'ISADMIN'                    => 'true',
    ));
    $response = $client->get($request);
    $raw_json = $response->getBody();
    $data = json_decode($raw_json, TRUE);

    // Log the response for debugging.
    watchdog(__FUNCTION__, print_r(compact('request', 'data'), 1));

    if (!empty($data['partyId'])) {
      require_once DRUPAL_ROOT . '/' . variable_get('password_inc', 'includes/password.inc');
      $user_password = user_hash_password($password);
      $account = new stdClass;
      $account->is_new = 1;
      $account->name = $email;
      $account->pass = $user_password;
      $account->mail = $email;
      $account->init = $email;
      $account->status = TRUE;
      $account->roles = array(DRUPAL_AUTHENTICATED_RID => TRUE);
      // Add 'demo administrator' role
      $account->roles[$demo_administrator_role] = TRUE;
      $account->timezone = variable_get('date_default_timezone', '');
      $account->field_party_id[LANGUAGE_NONE][0]['value'] = $data['partyId'];
	  
	  $GLOBALS['wweave_skip_user_integration'] = TRUE;
      user_save($account);

      if (!empty($account->uid)) {
        $return['error'] = FALSE;
        $return['status_messages'][] = 'User successfully registered!';
      }
      else {
        $return['error_messages'][] = 'Error registering user; please try with a different email address.';
      }
    }
    else {
      foreach ((array)@$data['_ERROR_MESSAGE_LIST_'] as $error) {
        $return['error_messages'][] = $error['message'];
      }
    }
  }

  header('Content-Type: application/json');
  echo json_encode($return);
}

/**
 * Page callback for /wweave/user-register
 */
function wweave_user_register() {
  $return = array(
    'error' => TRUE,
    'error_messages' => array(),
    'destination' => url()
  );

  $firstName                  = @$_POST['firstName'];
  $lastName                   = @$_POST['lastName'];
  $PHONE_MOBILE_CONTACT_OTHER = @$_POST['PHONE_MOBILE_CONTACT_OTHER'];
  $dobLongDayUs               = @$_POST['dobLongDayUs'];
  $dobLongMonthUs             = @$_POST['dobLongMonthUs'];
  $dobLongYearUs              = @$_POST['dobLongYearUs'];
  $USER_GENDER                = @$_POST['USER_GENDER'];
  $userLoginId                = @$_POST['userLoginId'];
  $currentPassword            = @$_POST['currentPassword'];
  $currentPasswordVerify      = @$_POST['currentPasswordVerify'];

  $user_exists = user_load_by_mail($userLoginId);
  if (!valid_email_address($userLoginId)) {
    $return['error_messages'][] = 'Please enter a valid email.';
  }
  else if (!empty($user_exists->uid)) {
    $return['error_messages'][] = 'You are already registered. Please login or use the forgot password feature.';
  }
  else {
    // /eCommerceCreateNewCustomerNew?PHONE_MOBILE_CONTACT_OTHER=9856235689&userLoginId=test2@example.com&PASSWORD=sonata123&CONFIRM_PASSWORD=sonata123&USERNAME=Test&CUSTOMER_EMAIL=test2@example.com&CUSTOMER_EMAIL_CONFIRM=test2@example.com&USER_FIRST_NAME=Test&USER_LAST_NAME=User&productStoreId=RNY_STORE
    $client = wweave_api_client();
    $request = 'eCommerceCreateNewCustomerNew?' . http_build_query(array(
      'PHONE_MOBILE_CONTACT_OTHER'  => $PHONE_MOBILE_CONTACT_OTHER,
      'userLoginId'                 => $userLoginId,
      'PASSWORD'                    => $currentPassword,
      'CONFIRM_PASSWORD'            => $currentPasswordVerify,
      'USERNAME'                    => $userLoginId,
      'CUSTOMER_EMAIL'              => $userLoginId,
      'CUSTOMER_EMAIL_CONFIRM'      => $userLoginId,
      'USER_FIRST_NAME'             => $firstName,
      'USER_LAST_NAME'              => $lastName,
    ));
    $response = $client->get($request);
    $raw_json = $response->getBody();
    $data = json_decode($raw_json, TRUE);

    // Log the response for debugging.
    watchdog(__FUNCTION__, print_r(compact('request', 'data'), 1));

    if (!empty($data['partyId'])) {
      require_once DRUPAL_ROOT . '/' . variable_get('password_inc', 'includes/password.inc');
      $user_password = user_hash_password($currentPassword);
      $account = new stdClass;
      $account->is_new = 1;
      $account->name = $userLoginId;
      $account->pass = $user_password;
      $account->mail = $userLoginId;
      $account->init = $userLoginId;
      $account->status = TRUE;
      $account->roles = array(DRUPAL_AUTHENTICATED_RID => TRUE);
      $account->timezone = variable_get('date_default_timezone', '');
      $account->field_party_id[LANGUAGE_NONE][0]['value'] = $data['partyId'];
	  
	  $GLOBALS['wweave_skip_user_integration'] = TRUE;
      user_save($account);

      if (!empty($account->uid)) {
        drupal_set_message('User registered!');
        global $user;
        $user = user_load($account->uid);
        user_login_finalize();

        // Login to Ofbiz
        list($data, $response) = ofbiz_login($userLoginId, $currentPassword);

        if (empty($data['_ERROR_MESSAGE_'])) {
          $raw_headers = $response->getHeaders();
          $_SESSION['wweave']['headers'] = $raw_headers;
          $_SESSION['wweave']['session'] = $data;
          $return['error'] = FALSE;
          drupal_set_message('User logged in!');
          // dsm($raw_headers);
          // dsm($_SESSION['wweave']);
        }
        else {
          global $user;
          $return['error_messages'][] = $data['_ERROR_MESSAGE_'];
          $user = user_load(0);
          unset($_SESSION['wweave']);
          drupal_session_regenerate();
        }
      }
      else {
        $return['error_messages'][] = 'Error registering user; please try with a different email address.';
      }
    }
    else {
      foreach ((array)@$data['_ERROR_MESSAGE_LIST_'] as $error) {
        $return['error_messages'][] = $error['message'];
      }
    }
  }
  echo json_encode($return);
}

/**
 * Page callback for /wweave/mini-cart
 */
function wweave_mini_cart() {
  echo theme('wweave_mini_cart', array('cart' => get_user_cart()));
}

/**
 * Page callback for /wweave/add-to-cart
 */
function wweave_add_to_cart() {
  echo json_encode(add_item_to_cart($_POST['product_id'], $_POST['quantity']));
}


function wweave_sign_in(){
  return theme('wweave_sign_in');
}

function wweave_sign_up(){
  return theme('wweave_sign_up');
}


/**
 * Page callback for /wweave/modify-item
 */
function wweave_modify_item() {
  $mod_response = modify_item_in_cart($_POST['product_id'], $_POST['quantity']);
  if ($mod_response['isError'] == 'false') {
    drupal_set_message('Item modified!');
  }
  else {
    drupal_set_message('Error modifying item!', 'warning');
  }
  echo json_encode($mod_response);
}

/**
 * Page callback for /wweave/delete-item
 */
function wweave_delete_item() {
  $del_response = delete_item_from_cart($_POST['product_id']);
  if ($del_response['isError'] == 'false') {
    drupal_set_message('Item deleted!');
  }
  else {
    drupal_set_message('Error deleting item!', 'warning');
  }
  echo json_encode($del_response);
}

function product_reviews (){
  return theme('myaccount_product_reviews', array());
}

function myaccount_update_password(){
  return theme('myaccount_update_password', array());
}

function myaccount_edit_address($id){
    $one_address = array();
    //   http://localhost:8080/osafecoreaddon/getAddressUpdate?partyId=10010&contactMechId=10380
    $client = wweave_api_client();
    $response = $client->get('getAddressUpdate?' . http_build_query(array(
      'partyId'                => get_user_party_id(),
      'contactMechId'          => $id,
    )));
    $raw_json = $response->getBody();
    $one_address = json_decode($raw_json, TRUE);
    $list_address = array();
    $response = get_user_addresses();
 
    if(!empty($response['postalAddressList'])) {
        $list_address = $response['postalAddressList'];
    }
   
    return theme('myaccount_edit_address', array('addr'=>$one_address,'address_list'=>$list_address));
}

function checkout_edit_address($id){
    $one_address = array();
    //   http://localhost:8080/osafecoreaddon/getAddressUpdate?partyId=10010&contactMechId=10380
    $client = wweave_api_client();
    $response = $client->get('getAddressUpdate?' . http_build_query(array(
      'partyId'                => get_user_party_id(),
      'contactMechId'          => $id,
    )));
    $raw_json = $response->getBody();
    $one_address = json_decode($raw_json, TRUE);
    $list_address = array();
    $response = get_user_addresses();
 
    if(!empty($response['postalAddressList'])) {
        $list_address = $response['postalAddressList'];
    }
   
    return theme('checkout_edit_address', array('addr'=>$one_address,'address_list'=>$list_address));
}

function myaccount_wclothing_submit_edit_address_checkout(){
  $client = wweave_api_client();
    $response = $client->get('customerupdateaddressnew?' . http_build_query(array(
      'CUSTOMER_FIRST_NAME'    => $_POST['CUSTOMER_FIRST_NAME'],
      'CUSTOMER_LAST_NAME'     => $_POST['CUSTOMER_LAST_NAME'],
      'CUSTOMER_ATTN_NAME'     => '',
      'CUSTOMER_ADDRESS1'      => $_POST['CUSTOMER_ADDRESS1'],
      'CUSTOMER_CITY'          => $_POST['CUSTOMER_CITY'],
      'CUSTOMER_POSTAL_CODE'   => $_POST['CUSTOMER_POSTAL_CODE'],
      'CUSTOMER_COUNTRY'       => 'IND',
      'partyId'                => get_user_party_id(),
      'productStoreId'         => 'RNY_STORE', // TODO: Is this hard coded?
      'contactmechid'          => $_POST['getContactMechId'],
    )));

    $raw_json = $response->getBody();
    $response = json_decode($raw_json, TRUE);
   
    if($response['status'] == 'pass') {
        drupal_set_message(t('Address Updated!'));
         drupal_goto('wclothing-checkout');
    }else {
        drupal_set_message(t('Service Error, Please try again.'), 'warning');
         drupal_goto('wclothing-checkout');
    }
}

function myaccount_wclothing_submit_edit_address_myaccount(){
  $client = wweave_api_client();
    $response = $client->get('customerupdateaddressnew?' . http_build_query(array(
      'CUSTOMER_FIRST_NAME'    => $_POST['CUSTOMER_FIRST_NAME'],
      'CUSTOMER_LAST_NAME'     => $_POST['CUSTOMER_LAST_NAME'],
      'CUSTOMER_ATTN_NAME'     => '',
      'CUSTOMER_ADDRESS1'      => $_POST['CUSTOMER_ADDRESS1'],
      'CUSTOMER_CITY'          => $_POST['CUSTOMER_CITY'],
      'CUSTOMER_POSTAL_CODE'   => $_POST['CUSTOMER_POSTAL_CODE'],
      'CUSTOMER_COUNTRY'       => 'IND',
      'partyId'                => get_user_party_id(),
      'productStoreId'         => 'RNY_STORE', // TODO: Is this hard coded?
      'contactmechid'          => $_POST['getContactMechId'],
    )));

    $raw_json = $response->getBody();
    $response = json_decode($raw_json, TRUE);
   
    if($response['status'] == 'pass') {
        drupal_set_message(t('Address Updated!'));
         drupal_goto('account/wclothing-address-book');
    }else {
        drupal_set_message(t('Service Error, Please try again.'), 'warning');
         drupal_goto('account/wclothing-address-book');
    }
} 

function myaccount_submit_edit_address(){
    /*http://localhost:8080/customerupdateaddressnew?CUSTOMER_FIRST_NAME=SSS&CUSTOMER_LAST_NAME=SSSKumar&CUSTOMER_ATTN_NAME=home&CUSTOMER_ADDRESS1=9-244&CUSTOMER_CITY=warangal&CUSTOMER_POSTAL_CODE=506002&CUSTOMER_COUNTRY=IND&partyId=10010&productStoreId=RNY_STORE&contactmechid=10050
*/
    $client = wweave_api_client();
    $response = $client->get('customerupdateaddressnew?' . http_build_query(array(
      'CUSTOMER_FIRST_NAME'    => $_POST['CUSTOMER_FIRST_NAME'],
      'CUSTOMER_LAST_NAME'     => $_POST['CUSTOMER_LAST_NAME'],
      'CUSTOMER_ATTN_NAME'     => '',
      'CUSTOMER_ADDRESS1'      => $_POST['CUSTOMER_ADDRESS1'],
      'CUSTOMER_CITY'          => $_POST['CUSTOMER_CITY'],
      'CUSTOMER_POSTAL_CODE'   => $_POST['CUSTOMER_POSTAL_CODE'],
      'CUSTOMER_COUNTRY'       => 'US',
      'CUSTOMER_STATE'         => $_POST['CUSTOMER_STATE'],
      'partyId'                => get_user_party_id(),
      'productStoreId'         => 'RNY_STORE', // TODO: Is this hard coded?
      'contactmechid'          => $_POST['contactmechid'],
    )));
    $raw_json = $response->getBody();
    $response = json_decode($raw_json, TRUE);
   
    if($response['status'] == 'pass') {
        drupal_set_message(t('Address Updated!'));
         drupal_goto('account/address-book');
    }else {
        drupal_set_message(t('Service Error, Please try again.'), 'warning');
         drupal_goto('account/address-book');
    }
}

function checkoutws_submit_edit_address(){
    /*http://localhost:8080/customerupdateaddressnew?CUSTOMER_FIRST_NAME=SSS&CUSTOMER_LAST_NAME=SSSKumar&CUSTOMER_ATTN_NAME=home&CUSTOMER_ADDRESS1=9-244&CUSTOMER_CITY=warangal&CUSTOMER_POSTAL_CODE=506002&CUSTOMER_COUNTRY=IND&partyId=10010&productStoreId=RNY_STORE&contactmechid=10050
*/
    $client = wweave_api_client();
    $response = $client->get('customerupdateaddressnew?' . http_build_query(array(
      'CUSTOMER_FIRST_NAME'    => $_POST['CUSTOMER_FIRST_NAME'],
      'CUSTOMER_LAST_NAME'     => $_POST['CUSTOMER_LAST_NAME'],
      'CUSTOMER_ATTN_NAME'     => '',
      'CUSTOMER_ADDRESS1'      => $_POST['CUSTOMER_ADDRESS1'],
      'CUSTOMER_CITY'          => $_POST['CUSTOMER_CITY'],
      'CUSTOMER_POSTAL_CODE'   => $_POST['CUSTOMER_POSTAL_CODE'],
      'CUSTOMER_COUNTRY'       => 'IND',
      'partyId'                => get_user_party_id(),
      'productStoreId'         => 'RNY_STORE', // TODO: Is this hard coded?
      'contactmechid'          => $_POST['contactmechid'],
    )));
    $raw_json = $response->getBody();
    $response = json_decode($raw_json, TRUE);
   
    if($response['status'] == 'pass') {
        drupal_set_message(t('Address Updated!'));
         drupal_goto('checkout');
    }else {
        drupal_set_message(t('Service Error, Please try again.'), 'warning');
         drupal_goto('checkout');
    }
}

/*
 *  create new address
 */
function myaccount_add_address(){
  $list_address = array();
  $response = get_user_addresses();
 
  if(!empty($response['postalAddressList'])) {
      $list_address = $response['postalAddressList'];
  }
  return theme('myaccount_add_address', array('address_list'=>$list_address));
}

function add_address_checkout(){
  
  return theme('add_address_checkout', array());
}

function myaccount_submit_add_address(){

    /*http://localhost:8080/customercreateaddressnew?CUSTOMER_FIRST_NAME=Ranjith&CUSTOMER_LAST_NAME=Kumar&CUSTOMER_ATTN_NAME=home&CUSTOMER_ADDRESS1=9-244&CUSTOMER_CITY=warangal&CUSTOMER_POSTAL_CODE=506002&CUSTOMER_COUNTRY=IND&partyId=10010&productStoreId=RNY_STORE*/
    $client = wweave_api_client();
    $response = $client->get('customercreateaddressnew?' . http_build_query(array(
      'CUSTOMER_FIRST_NAME'    => $_POST['CUSTOMER_FIRST_NAME'],
      'CUSTOMER_LAST_NAME'     => $_POST['CUSTOMER_LAST_NAME'],
      'CUSTOMER_ATTN_NAME'     => '',
      'CUSTOMER_ADDRESS1'      => $_POST['CUSTOMER_ADDRESS1'],
      'CUSTOMER_CITY'          => $_POST['CUSTOMER_CITY'],
      'CUSTOMER_POSTAL_CODE'   => $_POST['CUSTOMER_POSTAL_CODE'],
      'CUSTOMER_STATE'         => $_POST['CUSTOMER_STATE'],
      'CUSTOMER_COUNTRY'       => 'US',
      'partyId'                => get_user_party_id(),
    )));
    $raw_json = $response->getBody();
    $response = json_decode($raw_json, TRUE);
   
    if($response['status'] == 'pass') {
        drupal_set_message(t('Address Added!'));
        drupal_goto('account/address-book');
    }else {
        drupal_set_message(t('Service Error, Please try again.'), 'warning');
          drupal_goto('account/address-book');
    }
}

/*list of address to display call back for address-book
 */
function myaccount_address_book(){
  $list_address = array();
  $response = get_user_addresses();
 
  if(!empty($response['postalAddressList'])) {
      $list_address = $response['postalAddressList'];
  }
  return theme('myaccount_address_book', array('address_list'=>$list_address));
}

/**
 * Page callback for /account/profile
 */
function myaccount_profile(){
  return theme('myaccount_profile', array(
    'profile'   => get_user_profile(),
  ));
}

/**
 * Page callback for /account/update-profile
 */
function myaccount_update_profile() {
  // /updateCustomerPersonalInfoNew?partyId=10010&USER_FIRST_NAME=Ramesh&USER_LAST_NAME=Kumar&USER_TITLE=Mr.&USER_LOGIN_EMAIL=ramesh@gmail.com&USER_GENDER=M&dobLongDayUs=02&dobLongMonthUs=07&dobLongYearUs=1982
  global $user;
  $client = wweave_api_client();
  $request = 'updateCustomerPersonalInfoNew?' . http_build_query(array(
    'partyId'           => get_user_party_id(),
    'USER_FIRST_NAME'   => $_POST['USER_FIRST_NAME'],
    'USER_LAST_NAME'    => $_POST['USER_LAST_NAME'],
    // 'USER_TITLE'        => @$_POST['USER_TITLE'],
    'USER_LOGIN_EMAIL'  => $user->mail, // @$_POST['USER_LOGIN_EMAIL'],
    'USER_GENDER'       => 'M', // @$_POST['USER_GENDER'],
    'dobLongDayUs'      => '01', // @$_POST['dobLongDayUs'],
    'dobLongMonthUs'    => '01', // @$_POST['dobLongMonthUs'],
    'dobLongYearUs'     => '1990', // @$_POST['dobLongYearUs'],
  ));
  $response = $client->get($request);
  $raw_json = $response->getBody();
  $data = json_decode($raw_json, TRUE);
  $party_id = get_user_party_id(); watchdog(__FUNCTION__, '<pre>' . print_r(compact('party_id', 'request', 'data'), 1) . '</pre>');
  if (empty($data['_ERROR_MESSAGE_'])) {
    drupal_set_message('Profile updated!');
  }
  else {
    drupal_set_message('Error updating profile!', 'warning');
  }
  echo json_encode($data);
}

function myaccount_order_detail($order_id){
  return theme('myaccount_order_detail', array('order'=>order_details($order_id)));
}

function myaccount_loyalty(){
  return theme('myaccount_loyalty', array('loyalty'=>wweave_view_loyalty()));
}

function myaccount_storecredit(){
  return theme('myaccount_storecredit', array('storecredit'=>wweave_myaccount_store_credit()));
}

/**
 * Page callback for account/change-password
 */
function myaccount_change_password(){
  return theme('myaccount_change_password', array());
}

/**
 * Page callback for account/orders
 */
function myaccount_orders(){
  $orders = get_user_orders();
  $order_details = array();
  foreach ($orders['OrderHeader'] as $order_key => $order_value) {
    $order_details[$order_value['orderId']] = order_details($order_value['orderId']);
  }
  return theme('myaccount_orders', array(
    'orders' => get_user_orders(),'order_details' => $order_details,
  ));
}
/*
 * adding the form for order display using checkboxes
 */
function order_display_form($form, $form_state){
  $form = array();
  
  $orders = get_user_orders();
  $user_orders = array();

  $order_details = array();
  foreach ($orders['OrderHeader'] as $order_key => $order_value) {
    $order_details[$order_value['orderId']] = order_details($order_value['orderId']);
  }

  if(count($orders) > 0 ) {
    foreach($orders['OrderHeader'] as $i => $order) {
      $user_orders[$order['orderId']][0] =   $order['orderId'];
      $user_orders[$order['orderId']][1] = $order['productName'][0] .'('.ucwords(str_replace(':', ': ', $order['productName'][1])).')';
      $user_orders[$order['orderId']][2] = date('d/m/Y H:i:s', strtotime($order['orderDate']));
      $user_orders[$order['orderId']][3] = $order['statusId'];
      $user_orders[$order['orderId']][4] = format_money($order['orderGrandTotal']);
      
    }
  }
  
  $header = array(t('Order Id'), t('Product Name'),t('Order Date'),t('Status'),t('Price'),);

  $form['checkboxes']   =   array(
    '#type'       =>  'tableselect',
    '#header'     =>  $header,
    '#options'      =>  $user_orders,
    '#attributes'   =>  array('class' => array('backbtn')),
    '#empty'      =>  t('No Orders found.')
  );
  if(count($user_orders) > 0 ) {
    $form['re-order']     = array(
      '#id'       =>  'my-order-form',
      '#type'       =>  'submit',
      '#value'      =>  t('Re-order'),
      '#attributes'   =>  array('class' => array('backbtn')),
    );
     $form['cancel-order']     = array(
      '#id'       =>  'my-order-form',
      '#type'       =>  'submit',
      '#value'      =>  t('Cancel order'),
      '#attributes'   =>  array('class' => array('backbtn')),
    );
      $form['return-order']     = array(
      '#id'       =>  'my-order-form',
      '#type'       =>  'submit',
      '#value'      =>  t('Return Order'),
      '#attributes'   =>  array('class' => array('backbtn')),
    );
  }
  
  
  return $form;
  
}
function order_display_form_submit(&$form, &$form_state){

  $orders = array();
  $values = $form_state['values']['checkboxes'];
  $op = $form_state['values']['op'];

  foreach($values as $k=>$v){
    if(trim($k) == trim($v)) {
      $orders[] = $v;
    }
  }
  
  // encoding the array of orders ids and sending data as params to next url/".$data
  $data = encode_arr($orders);
  if($op == 'Cancel Order') {
    drupal_goto("/wweave/cancel-order/".$data);  
  }
  if($op == 'Re-order') {
    drupal_goto("/wweave/reorder-order/".$data);  
  }
  if($op == 'Return Order') {
    drupal_goto("/wweave/return-order/".$data);  
  }
  
}

function order_details($order_id) {
  // /eCommerceOrderDetailNew?orderId=RNYCO10190&partyId=10010
  $client = wweave_api_client();
  $response = $client->get('eCommerceOrderDetailNew?' . http_build_query(array(
    'partyId'         => get_user_party_id(),
    'orderId'         => $order_id,
    'productStoreId'  => 'RNY_STORE', // TODO: Is this hard coded?
  )));

  $raw_json = $response->getBody();
  $data = json_decode($raw_json, TRUE);
  return $data;
}

/**
 * Page callback for account/dashboard
 */
function myaccount_dashboard(){
  return theme('myaccount_dashboard', array(
    'orders'    => get_user_orders(),
    'profile'   => get_user_profile(),
    'addresses' => get_user_addresses(),
  ));
}

function wweave_wclothing_signup(){
  return theme('wweave_wclothing_sign_up');
}
 function wweave_wclothing_signin(){
  return theme('wweave_wclothing_sign_in');
 }

function wweave_cart_wclothing(){
  return theme('wweave_cart_wclothing' , array('shipping_method' => get_shipping_methods(),'cart' => get_user_cart()));
}

function wweave_wclothing_checkout(){
  return theme('wweave_wclothing_checkout' , array('cart' => get_user_cart()));
}

function wweave_wclothing_add_address(){
  return theme('wweave_wclothing_add_address');
}

function wweave_wclothing_view_order($order_id) {
  // /eCommerceOrderDetailNew?orderId=RNYCO10190&partyId=10010

  $client = wweave_api_client();
  $response = $client->get('eCommerceOrderDetailNew?' . http_build_query(array(
    'partyId'         => get_user_party_id(),
    'orderId'         => $order_id,
    'productStoreId'  => 'RNY_STORE', // TODO: Is this hard coded?
  )));

  $raw_json = $response->getBody();
  $data = json_decode($raw_json, TRUE);
  return theme('wweave_wclothing_view_order', array('order' => $data));
}
function myaccount_wclothing_address_book(){
  return theme('myaccount_address_book', array(
    'address_list'=>get_user_addresses(),
    ));
}
function myaccount_wclothing_account_address_book(){
  return theme('myaccount_wclothing_account_address_book');
}
function myaccount_change_userinfo(){
  return theme('myaccount_change_userinfo');
}

function myaccount_love_list(){
  $client = wweave_api_client();
  $response = $client->get('eCommerceShowWishListResponse?' . http_build_query(array(
    'partyId'         => get_user_party_id(),
  )));
  $raw_json = $response->getBody();
  $wishlist = json_decode($raw_json, TRUE);
  return theme('myaccount_love_list',array('wishlist' => $wishlist));
}

function wweave_add_to_love_list(){
  $product_id = $_POST['product_id']; 
  $quantity = $_POST['quantity'];
  $client = wweave_api_client();
  $response = $client->get('addItemToWishListNew?' . http_build_query(array(
    'add_product_id'  => $product_id,
    'quantity'        => $quantity,
    'partyId'         => get_user_party_id(),
  )));
  $raw_json = $response->getBody();
  $data = json_decode($raw_json, TRUE);
  echo json_encode($data);
}

function wweave_set_gift_message(){
  return theme('wweave_set_gift_message');
}

function wweave_save_gift_message(){
  $giftFrom = $_POST['giftFrom'];
  $giftTo = $_POST['giftTo'];
  $cartLine = $_POST['cartLine'];
  $msgText = $_POST['msgText'];
  $client = wweave_api_client();
  $response = $client->get('setGiftMessageNew?' . http_build_query(array(
    'cartLineIndex'  => $cartLine,
    'from'           => $giftFrom,
    'to'             => $giftTo,
    'giftMessageText' => $msgText,
  )));
  $raw_json = $response->getBody();
  $data = json_decode($raw_json, TRUE);
  echo json_encode($data);
}

function myaccount_wishlist_remove_item(){
  $sequenceId = $_POST['sequenceId'];
  $sequenceId = explode("_",$sequenceId);
  $client = wweave_api_client();  
  $response = $client->get('deleteFromWishListResponse?' . http_build_query(array(
    'delete_'.$sequenceId[1]  => $sequenceId[1],
    'partyId'              => get_user_party_id(),
  )));
  $raw_json = $response->getBody();
  $data = json_decode($raw_json, TRUE);
  echo json_encode($data);
}


function wweave_store_credit(){
  $client = wweave_api_client();
  //http://localhost:8080/globus/multiPageAddStoreCreditNew;?productStoreId=Globus_STORE&partyId=10030&storeCreditAmount=99
  $credit = @$_POST['creditAmount'];
  $response = $client->get('multiPageAddStoreCreditNew?' . http_build_query(array(
    'productStoreId' => 'Globus_STORE',
    'partyId'              => get_user_party_id(),
    'storeCreditAmount'    => $credit,
    )));
  $raw_json = $response->getBody();
  $data = json_decode($raw_json);
  watchdog(__FUNCTION__, '<pre>' . print_r(compact('response', 'raw_json', 'data'), 1) . '</pre>');
  echo json_encode($data);
}

function wweave_myaccount_store_credit() {
  $client = wweave_api_client();
  $response = $client->get('partyStoreCreditPayment?'. http_build_query(array(

  )));
  $raw_json = $response->getBody();
  $data = json_decode($raw_json,TRUE);
    return $data;
}

function wweave_remove_store_credit(){
  //http://localhost:8080/globus/multiPageRemoveStoreCreditNew
  $client = wweave_api_client();
  $response = $client->get('multiPageRemoveStoreCreditNew?' . http_build_query(array(

  )));
  $raw_json = $response->getBody();
  $data = json_decode($raw_json);
  echo json_encode($data);
}

  function wweave_look_book(){
    $client = wweave_api_client();
    $subscriberEmail = @$_POST['subscriberEmail'];
    //https://localhost:8443/industree/subscriberNew?emailID=prashnat@gmial.com
    $response = $client->get('subscriberNew?' . http_build_query(array(
      'emailID' => $subscriberEmail
    )));
    $raw_json = $response->getBody();
    $data = json_decode($raw_json);
    echo json_encode($data);
  }

  function wweave_plp_check_inventory(){
    $client = wweave_api_client();
    $productId = @$_POST['productId'];
    $response = $client->get('inventoryCheckNew?' . http_build_query(array(
      'productId' => $productId,//'500900',
    )));
    $raw_json = $response->getBody();
    $data = json_decode($raw_json);
    echo json_encode($data);
  }

function wweave_view_loyalty(){
  $client = wweave_api_client(); 
  $response = $client->get('showLoyaltyPointsNew?' . http_build_query(array(
    'partyId'  => get_user_party_id(),
  )));
  $raw_json = $response->getBody();
  $data = json_decode($raw_json, TRUE);
  if(isset($_GET['flag'])){
   return $data;
  }else{
    echo json_encode($data);
  }
}

function wweave_redeem_loyalty(){
  //http://182.72.231.54:8090/globus/updateLoyaltyPointsNew?loyaltyamount=10&partyId=10120
  $loyaltypoints = @$_POST['loyalpoints'];
  $client = wweave_api_client();  
  $response = $client->get('updateLoyaltyPointsNew?' . http_build_query(array(
    'loyaltyamount' => $loyaltypoints,
    'partyId'       => get_user_party_id(),
  )));
  $raw_json = $response->getBody();
  $data = json_decode($raw_json, TRUE);
  echo json_encode($data);
}

function wweave_remove_loyalty(){
  //http://182.72.231.54:8090/globus/removeLoyalty
  $client = wweave_api_client();  
  $response = $client->get('removeLoyalty?' . http_build_query(array(
    
  )));
  $raw_json = $response->getBody();
  $data = json_decode($raw_json, TRUE);
  echo json_encode($data);
}

function wweave_apply_promocode(){
  $promocode = @$_POST['promo_code'];
  $client = wweave_api_client();  
  $response = $client->get('validateShowCartPromoCodeNew?' . http_build_query(array(
    'productPromoCodeId'  => $promocode,
    'productStoreId'      => 'Globus_STORE',
    'partyId'             => get_user_party_id(),
  )));
  $raw_json = $response->getBody();
  $data = json_decode($raw_json);
  watchdog(__FUNCTION__, '<pre>' . print_r(compact('response', 'raw_json', 'data'), 1) . '</pre>');
  echo json_encode($data);
}

function wweave_view_promocode(){
  $client = wweave_api_client();  
  $response = $client->get('getcoupon?' . http_build_query(array(
    'storeId'  => 'Globus_STORE',
    'partyId'    => get_user_party_id(),
  )));
  $raw_json = $response->getBody();
  $data = json_decode($raw_json, TRUE);
  return $data;
}
/*
 * Page call back for reorder-order
 */
function wweave_reorder_order($data){
  $selected_orders = decode_arr($data);
  $details = array();
  foreach($selected_orders as $k=>$order_id){
      $details[$order_id] =  order_details($order_id);
  }
 
  return theme('wweave_reorder_order_template',array('orders'=>$details));
    
}
/*
 * Page callback for return-order
 */

function wweave_retun_order($data){
  $selected_orders = decode_arr($data);
  $details = array();
  foreach($selected_orders as $k=>$order_id){
      $details[$order_id] =  order_details($order_id);
  }
  return theme('wweave_return_order_template',array('orders'=>$details));
}
/*
 * Page call back for cancel-order
 */

function wweave_cancel_order($data){
  $selected_orders = decode_arr($data);
  $details = array();
  foreach($selected_orders as $k=>$order_id){
      $details[$order_id] =  order_details($order_id);
  }
   
  return theme('wweave_cancel_order_template',array('orders'=>$details));
}

// re-order of the products already orderes
function reorder_the_order(){
  $product_arr = $_POST['product'];
  /* http://localhost:8080/osafecoreaddon/addMultiItemsToCartNew?add_multi_product_id_0=100017&add_multi_product_quantity_0=1*/

  $request_param = array();
  $i=0;
  foreach($product_arr as $product_id=>$v){
    $request_param['add_multi_product_id_'.$i] = $product_id;
    $request_param['add_multi_product_quantity_'.$i] = $v;
    $i++;
  }
  
  $client = wweave_api_client();  
  $response = $client->get('addMultiItemsToCartNew?' . http_build_query($request_param));
  $raw_json = $response->getBody();
  $data = json_decode($raw_json, TRUE);
  
  echo json_encode($data);exit;
}
// cancel the order 
// cancel the whole line item 
function cancel_order($order_id,$product_qty=NULL){
   /* 
   http://localhost:8080/globus/changeOrderStatusByEmail?orderId=RNY10110&statusId=ORDER_CANCELLED&setItemStatus=Y
   */
   $client = wweave_api_client();  
  $response = $client->get('changeOrderStatusByEmail?' . http_build_query(array(
    'orderId'  => $order_id,
    'statusId'    => 'ORDER_CANCELLED',
    'setItemStatus'    => 'Y'
  )));
  $raw_json = $response->getBody();
  $data = json_decode($raw_json, TRUE);

}

function return_order($order_id,$product_qty=NULL){
  //http://localhost:8080/globus/returnSelectedOrder?orderId=RNY10222
  $client = wweave_api_client();  
  $response = $client->get('returnSelectedOrder?' . http_build_query(array(
    'orderId'  => $order_id,
  )));
  $raw_json = $response->getBody();
  $data = json_decode($raw_json, TRUE);

}

function sonata_contact_us(){
  return theme('sonata_contact_us_template');
}
function sonata_privacy_policy(){
  return theme('sonata_privacy_policy_template');
}

function download_file(){
  header('Content-type: application/pdf');
  readfile('sites/all/themes/globular<?php echo current_theme_path() ?>/images/Ofbiz-Retail-Brochure.pdf');
}

function sonata_logo_1(){
  header('Content-type: image/png');
  readfile('sites/all/themes/globular<?php echo current_theme_path() ?>/images/Slogo48.png');
}

function sonata_logo_2(){
  header('Content-type: image/png');
  readfile('sites/all/themes/globular<?php echo current_theme_path() ?>/images/Slogo216.png');
}

function screenShot1(){
  header('Content-type: image/png');
  readfile('sites/all/themes/globular<?php echo current_theme_path() ?>/images/Screenshot1.PNG');
}

function screenShot2(){
  header('Content-type: image/png');
  readfile('sites/all/themes/globular<?php echo current_theme_path() ?>/images/Screenshot2.PNG');
}

function screenShot3(){
  header('Content-type: image/png');
  readfile('sites/all/themes/globular<?php echo current_theme_path() ?>/images/Screenshot3.PNG');
}
/*
* array encode 
*/

function encode_arr($data) {
  return base64_encode(serialize($data));
}
/*
* array decode values 
*/
function decode_arr($data) {
  return unserialize(base64_decode($data));
}
