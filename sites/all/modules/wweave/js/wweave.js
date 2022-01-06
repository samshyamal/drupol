var mini_cart_timer = setTimeout('', 0);

(function() {
    var matched, browser;

    // Use of jQuery.browser is frowned upon.
    // More details: http://api.jquery.com/jQuery.browser
    // jQuery.uaMatch maintained for back-compat
    jQuery.uaMatch = function( ua ) {
        ua = ua.toLowerCase();

        var match = /(chrome)[ \/]([\w.]+)/.exec( ua ) ||
            /(webkit)[ \/]([\w.]+)/.exec( ua ) ||
            /(opera)(?:.*version|)[ \/]([\w.]+)/.exec( ua ) ||
            /(msie) ([\w.]+)/.exec( ua ) ||
            ua.indexOf("compatible") < 0 && /(mozilla)(?:.*? rv:([\w.]+)|)/.exec( ua ) ||
            [];

        return {
            browser: match[ 1 ] || "",
            version: match[ 2 ] || "0"
        };
    };

    matched = jQuery.uaMatch( navigator.userAgent );
    browser = {};

    if ( matched.browser ) {
        browser[ matched.browser ] = true;
        browser.version = matched.version;
    }

    // Chrome is Webkit, but Webkit is also Safari.
    if ( browser.chrome ) {
        browser.webkit = true;
    } else if ( browser.webkit ) {
        browser.safari = true;
    }

    jQuery.browser = browser;
})();

(function ($) {

$(document).ready(function() {
  $('#size_guide_fancybox').click(function(event) {
      event.preventDefault();
      var id=$(this).attr('href');
      $('div#'+id).modal();
  });

  $("#close_chart").click(function(){
    $("#size_guide_fancy").hide();
  });

  $('.owl-carousel').owlCarousel({
      loop:false,
      margin:10,
      nav:true,
    });

    $('#wweave-language-selector').change(function() {
      Cookies.set(language_param, $(this).val());
      location.reload();
    });
        $('.owl-prev').addClass("fa-angle-left");

    $('#removeStoreCredit').click(function(){
        loading();
        $.ajax({
              type: "POST",
              url: Drupal.settings.basePath + 'wweave/remove-store-credit',
              data: '',
              success: function(data) {
                document.location = Drupal.settings.basePath + 'checkout-payment';
                close_loading();
              },
              error: function(jqXHR, textStatus, errorThrown) {
                alert('We are facing some technical difficulties at the moment. Please try again after some time.');
                console.log(textStatus + ': ' + errorThrown);
                close_loading();
              },
              dataType: 'json'
          });
    });

     $('#useStoreCredit').unbind('click').click(function(){
      $('#store_redeem').show();
    });

     $('#ui-id-1').click(function(){
        $('#js_submitOrderBtn').attr('data-payment-method-id','CC');
     })

    $('#save_credit').click(function(){
      var creditAmount = $('#js_storeCreditAmount').val();
      var data='';
      if(creditAmount == ''){
        alert('Enter amount to be redeemed!')
      }
      else{
        //productStoreId=Globus_STORE&partyId=10030&storeCreditAmount=99
        data += 'creditAmount=' + creditAmount;
        loading();
          $.ajax({
              type: "POST",
              url: Drupal.settings.basePath + 'wweave/store-credit',
              data: data,
              success: function(data) {
                //alert(data['partyAppliedStoreCreditTotal']);
                if(data['status']=='Success'){
                document.location = Drupal.settings.basePath + 'checkout-payment';
                close_loading();
              }
            else if((data['status']=='Fail') && (data['isError']=='true')){
                alert(data['_ERROR_MESSAGE_']);
                $('#creditErrorInfo').empty();
                $('#creditErrorInfo').append('<div>'+ data['_ERROR_MESSAGE_']+'</div>');
                $('#js_storeCreditAmount').val('');
                close_loading();
        }
        else {
          close_loading();
        }
              },
              error: function(jqXHR, textStatus, errorThrown) {
                alert('Store credit could be applied.');
                console.log(textStatus + ': ' + errorThrown);
                close_loading();
              },
              dataType: 'json'
          });
      }
    });
   

 /*   $('#js_useLoyalty').change(function(){
      if (!($('#js_useLoyalty:checked').val())){
        //http://localhost:8080/globus/multiPageRemoveStoreCreditNew
        $('#js_loyaltyAmount').hide();
        $('#loyaltyRedeem').hide();
        $('#js_loyaltyAmountRedeem').hide();
        loading();
        $.ajax({
              type: "POST",
              url: Drupal.settings.basePath + 'wweave/remove-loyalty',
              data: '',
              success: function(data) {
              if(data['_ERROR_MESSAGE_']!=undefined){
                 alert(data['_ERROR_MESSAGE_']);
                 close_loading();
               } 
              else if (data['status']=='pass' && data['isError']=='false') {      
                 document.location = Drupal.settings.basePath + 'checkout-payment';
                 close_loading();
               }
               else {
                  close_loading();
                }
              },
              error: function(jqXHR, textStatus, errorThrown) {
               alert('We are facing some technical difficulties at the moment. Please try again after some time.');
                console.log(textStatus + ': ' + errorThrown);
                close_loading();
              },
              dataType: 'json'
          });
      }else{
        $('#js_loyaltyAmountRedeem').show();
        $('#loyaltyRedeem').show();
        $('#js_loyaltyAmount').show();
      }
    });

    $('#loyaltyRedeem').click(function(){
      var loyaltyAmount = $('#js_loyaltyAmount').val();
      var data='';
      if(loyaltyAmount == ''){
        alert('Enter amount to be redeemed!')
      }
      else{
        //productStoreId=Globus_STORE&partyId=10030&storeCreditAmount=99
        data += 'loyaltyAmount=' + loyaltyAmount;
        loading();
          $.ajax({
              type: "POST",
              url: Drupal.settings.basePath + 'wweave/redeem-loyalty',
              data: data,
              success: function(data) {
                if ((data['status']=='pass') && (data['isError']=='false')) {
                document.location = Drupal.settings.basePath + 'checkout-payment';
                close_loading();
               }
              else if((data['status']=='fail') && (data['isError']=='true')){
                alert(data['errorInfo']);
                $('#loyaltyErrorInfo').empty();
                $('#loyaltyErrorInfo').append('<div>'+ data['errorInfo']+'</div>');
                $('#js_loyaltyAmount').val('');
                close_loading();
               }
              else {
                close_loading();
               }
              },
              error: function(jqXHR, textStatus, errorThrown) {
               alert('We are facing some technical difficulties at the moment. Please try again after some time.');
                console.log(textStatus + ': ' + errorThrown);
                close_loading();
              },
              dataType: 'json'
          });
      }
    });*/

  $('#addCartlist').mouseover(function() {
    if ($('#js_lightCart').length == 0) {
      $(this).after('<div id="js_lightCart" class="ui-dialog ui-widget ui-widget-content ui-corner-all ui-draggable lightCart_displayDialog js_lightBoxCartContainer" tabindex="-1" style="outline: 0px; z-index: 1013; width: auto; top: 50px; left: -123% !important; min-height: 200px; max-height: 300px; min-width: 300px !important; display: block; overflow-y: scroll; margin-top: 0px; margin-bottom: 0px; background-color: #fff;" role="dialog">  <div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix" id="js_lightBoxCartTitleBar" style="width: 0px;"> <span id="ui-id-15" class="ui-dialog-title">&nbsp;</span>    <a href="#" style="right: 0.3em; top: 50%; background-color: #fff;" class="ui-dialog-titlebar-close ui-corner-all" role="button"><span class="ui-icon ui-icon-closethick">close</span></a>  </div><div id="lightCart_inner" style="padding: 1em;"></div></div>');
      $('#lightCart_inner').html($('#cartLightform').html());
      $('#js_lightCart .ui-dialog-titlebar-close').click(function() {
        $('#js_lightCart').fadeOut(function() {
          $('#js_lightCart').remove();
        });
      });

      mini_cart_timer = setTimeout(function() {
        $('#js_lightCart .ui-dialog-titlebar-close').click();
      }, 2000);

      $('#js_lightCart').mouseover(function() {
        // console.log('mini cart mouseover');
        clearTimeout(mini_cart_timer);
      });

      $('#js_lightCart').mouseleave(function() {
        // console.log('mini cart mouseout');
        mini_cart_timer = setTimeout(function() {
          $('#js_lightCart .ui-dialog-titlebar-close').click();
        }, 1000);
      });
    }
  });

  $('#login_btn').click(function(e) {
    e.preventDefault();

    var $form = $(this).closest('form');
    var data_USERNAME = $form.find('[name=USERNAME]:first').val();
    var data_PASSWORD = $form.find('[name=PASSWORD]:first').val();

    loading();
    $.ajax({
      type: "POST",
      url: Drupal.settings.basePath + 'wweave/user',
      data: 'USERNAME=' + encodeURIComponent(data_USERNAME) + '&PASSWORD=' + encodeURIComponent(data_PASSWORD),
      success: function(data) {
        // console.log(data);
        if (!data['error']) {
          document.location = data['destination'];
        }
        else {
          alert(data['error_messages'].join("\n"));
          close_loading();
        }
      },
      error: function(jqXHR, textStatus, errorThrown) {
        alert('We are facing some technical difficulties at the moment. Please try again after some time.');
        console.log(textStatus + ': ' + errorThrown);
        close_loading();
      },
      dataType: 'json'
    });
  });


  $('#js_applyLoyaltyCard').click(function(e) {
    e.preventDefault();
        loading();
    $.ajax({
      type: "POST",
      url: Drupal.settings.basePath + 'wweave/view-loyalty',
      success: function(data) {
        console.log(data);
        if (data['status']=='pass') {
          $('#js_applyLoyaltyCard').hide();
          $('#loyaltyInfo').empty();
          $('#loyaltyInfo').append('<div>Points Available:'+data['totalPoints']+'</div>');
          $('#loyaltyInfo').show();
          $('#js_redeemLoyaltyPoints').val('');
          $('#hidloyalpts').val(data['totalPoints']);
          $('#redmpts').show();
          close_loading();              
        }
        else if((data['status']=='fail') && (data['totalPoints']=='0')){
           $('#js_applyLoyaltyCard').hide();
           $('#loyaltyInfo').append('<div>Loyalty Amount:'+data['totalPoints'] +'<br>Since you have not made any purchase so far, your loyalty account balance is '+data['totalPoints'] +'</div>');
           close_loading();
         }
        else{
          close_loading();
        }
      },
      error: function(jqXHR, textStatus, errorThrown) {
        alert('We are facing some technical difficulties at the moment. Please try again after some time.');
        console.log(textStatus + ': ' + errorThrown);
        close_loading();
      },
      dataType: 'json'
    });
  });

  $('#js_redeemLoyalty').click(function(e) {
    e.preventDefault();
    var loyalpoints = $("#js_redeemLoyaltyPoints").val();
    var avlloyalpts = $('#hidloyalpts').val();
    if(Number(loyalpoints)>Number(avlloyalpts)){
       $('#loyaltyErrorInfo').empty();
       $('#loyaltyErrorInfo').append('<div>Sry,you have only'+ avlloyalpts+' Points to redeem.</div>');
       $('#js_redeemLoyaltyPoints').val('');
     }
     else{
    var data = '';
    data += 'loyalpoints=' + loyalpoints;
    loading();
    $.ajax({
      type: "POST",
      url: Drupal.settings.basePath + 'wweave/redeem-loyalty',
      data: data,
      success: function(data) {
        //console.log(data);
        if ((data['status']=='pass') && (data['isError']=='false')) {
          call_cart();
          $('#loyaltyErrorInfo').empty();
          $('#js_applyLoyaltyCard').hide();
          $('#redmpts').hide();
          $('#loyaltyInfo').empty();
          $('#loyaltyInfo').append('<div>Redeeming Loyalty Points:' + data['redeemedpoints']+ '<br>Adjustment Amount:'+ data['adjustmentAmount']+'<br>Total RewardPoints Available:'+data['totalRewardPoints']+'</div>');
          $('#js_removeLoyalty').show();
          location.reload();
          close_loading();              
        }
        else if((data['status']=='fail') && (data['isError']=='true')){
         // alert(data['errorInfo']);
         $('#loyaltyErrorInfo').empty();
         $('#loyaltyErrorInfo').append('<div>'+ data['errorInfo']+'</div>');
          $('#js_redeemLoyaltyPoints').val('');
          close_loading();
        }
        else {
          close_loading();
        }
      },
      error: function(jqXHR, textStatus, errorThrown) {
        alert('We are facing some technical difficulties at the moment. Please try again after some time.');
        console.log(textStatus + ': ' + errorThrown);
        close_loading();
      },
      dataType: 'json'
    });
  }
  }); 

  $('#js_removeLoyalty').click(function(e) {
    e.preventDefault();
    loading();
    $.ajax({
      type: "POST",
      url: Drupal.settings.basePath + 'wweave/remove-loyalty',
      success: function(data) {
        console.log(data);
        if(data['_ERROR_MESSAGE_']!=undefined){
          alert(data['_ERROR_MESSAGE_']);
          close_loading();
        }
        else if (data['status']=='pass' && data['isError']=='false') {
         // call_cart();
          document.location = Drupal.settings.basePath + 'cart';
          close_loading();              
        }
        else {
          close_loading();
        }
      },
      error: function(jqXHR, textStatus, errorThrown) {
        alert('We are facing some technical difficulties at the moment. Please try again after some time.');
        console.log(textStatus + ': ' + errorThrown);
        close_loading();
      },
      dataType: 'json'
    });
  });

   $('#promoapply').click(function(e) {
    e.preventDefault();
    var promo_code = $("#js_manualOfferCode").val();
    var data = '';
    data += 'promo_code=' + promo_code;
    loading();
    $.ajax({
      type: "POST",
      url: Drupal.settings.basePath + 'wweave/apply-promo',
      data: data,
      success: function(data) {
        console.log(data);
        if ((data['fieldLevelErrors']=='Y') && ((data['_ERROR_MESSAGE_LIST_']) != undefined)) {
           $('#coupon_codes').empty();
          $('#coupon_apply').empty(); 
           $('#coupon_apply').append('<div class="fieldErrorMessage" id="promotionError">'+data['_ERROR_MESSAGE_LIST_'][0]['message']+'</div>');
           $('#coupon_apply').show();
           close_loading();              
        }
        else if((data['fieldLevelErrors'] == undefined) && (data['_WARNING_MESSAGE_']!= undefined)){
          $('#coupon_codes').empty();
          $('#coupon_apply').empty(); 
          $('#coupon_apply').append('<div class="fieldErrorMessage" id="promotionError">'+data['_WARNING_MESSAGE_']+'</div>');
          $('#coupon_apply').show();
          close_loading(); 
        }
         else if((data['status']=='fail') && (data['iserror']=='true')){
          $('#coupon_codes').empty();
          $('#coupon_apply').empty(); 
          $('#coupon_apply').append('<div class="fieldErrorMessage" id="promotionError">'+data['_ERROR_MESSAGE_']+'</div>');
          $('#coupon_apply').show();
          close_loading(); 
        }
        else if(data['status']=='Pass'){
          document.location = Drupal.settings.basePath + 'cart';
          close_loading();              
        }
        else {
          close_loading();
        }
      },
      error: function(jqXHR, textStatus, errorThrown) {
        alert('We are facing some technical difficulties at the moment. Please try again after some time.');
        //console.log(textStatus + ': ' + errorThrown);
        close_loading();
      },
      dataType: 'json'
    });
  });
  
   $("#google_login").click(function(){
    $('#edit-submit-google').closest('form').parent().show();
    $('.ui-dialog-titlebar-close').click()
    $('#edit-submit-google').click();
   });
  


/*  $('#promoview').click(function(e) {
    e.preventDefault();
    loading();
    $.ajax({
      type: "POST",
      url: Drupal.settings.basePath + 'wweave/view-promo',
      success: function(data) {
        console.log(data);
        if (data['status']=='pass') {
		  $('#coupon_codes').empty();
          $('#coupon_codes').append(data['couponcode']);
          close_loading();
        }
        else {
          alert('Sry, there are no promoCodes available');
          //alert(data['error_messages'].join("\n"));
          close_loading();
        }
      },
      error: function(jqXHR, textStatus, errorThrown) {
        alert('We are facing some technical difficulties at the moment. Please try again after some time.');
        console.log(textStatus + ': ' + errorThrown);
        close_loading();
      },
      dataType: 'json'
    });
  });
  */

  $('#apply_coupon').click(function(e){
    $('#js_manualOfferCode').val();
    });
  

  $('#signup_btn').click(function(e) {
    e.preventDefault();

    var $form = $(this).closest('form');
    var data_USERNAME = $form.find('[name=USERNAME]:first').val();
    var data_PASSWORD = $form.find('[name=PASSWORD]:first').val();

    var data_firstName                  = $form.find('[name=firstName]:first').val();
    var data_lastName                   = $form.find('[name=lastName]:first').val();
    var data_PHONE_MOBILE_CONTACT_OTHER = $form.find('[name=PHONE_MOBILE_CONTACT_OTHER]:first').val();
    var data_dobLongDayUs               = $form.find('[name=dobLongDayUs]:first').val();
    var data_dobLongMonthUs             = $form.find('[name=dobLongMonthUs]:first').val();
    var data_dobLongYearUs              = $form.find('[name=dobLongYearUs]:first').val();
    var data_USER_GENDER                = $form.find('[name=USER_GENDER]:first').val();
    var data_userLoginId                = $form.find('[name=userLoginId]:first').val();
    var data_currentPassword            = $form.find('[name=currentPassword]:first').val();
    var data_currentPasswordVerify      = $form.find('[name=currentPasswordVerify]:first').val();

    var data = 'firstName=' + encodeURIComponent(data_firstName) + '&lastName=' + encodeURIComponent(data_lastName) + '&PHONE_MOBILE_CONTACT_OTHER=' + encodeURIComponent(data_PHONE_MOBILE_CONTACT_OTHER) + '&dobLongDayUs=' + encodeURIComponent(data_dobLongDayUs) + '&dobLongMonthUs=' + encodeURIComponent(data_dobLongMonthUs) + '&dobLongYearUs=' + encodeURIComponent(data_dobLongYearUs) + '&USER_GENDER=' + encodeURIComponent(data_USER_GENDER) + '&userLoginId=' + encodeURIComponent(data_userLoginId) + '&currentPassword=' + encodeURIComponent(data_currentPassword) + '&currentPasswordVerify=' + encodeURIComponent(data_currentPasswordVerify);

    loading();
    $.ajax({
      type: "POST",
      url: Drupal.settings.basePath + 'wweave/user-register',
      data: data,
      success: function(data) {
        console.log(data);
        if (!data['error']) {
          document.location = data['destination'];
        }
        else {
          alert(data['error_messages'].join("\n"));
          close_loading();
        }
      },
      error: function(jqXHR, textStatus, errorThrown) {
        alert('We are facing some technical difficulties at the moment. Please try again after some time.');
        console.log(textStatus + ': ' + errorThrown);
        close_loading();
      },
      dataType: 'json'
    });
  });

  $('.product-choose-facet').click(function(e) {
    e.preventDefault();
    var product_id = $(this).data('product-id');
    $(this).closest('ul').find('li.selected').removeClass('selected');
    $(this).closest('li').addClass('selected');
  });
  $('#js_addToCart, #js_addToCart_buynow, .plp-add-to-cart').click(function(e) {
    e.preventDefault();
    if ($(this).hasClass('plp-add-to-cart')) {
      var product_id = $(this).data('product-id');
      var quantity = 1;
    }
    else {
      var product_id = $('.pdpSelectableFeature li.selected:first a').data('product-id');
      var quantity = $('#js_quantity1').val();
    }

    if (typeof product_id == 'undefined' || !product_id) {
      var product_id = $('#eCommerceProductDetailContainer').data('master-product-id');
    }

    var action = $(this).attr('id') == 'js_addToCart_buynow' ? 'buy_now' : 'add';
    // alert(action + ' - ' + product_id + ' | ' + quantity);
    loading();
    $.ajax({
      type: "POST",
      url: Drupal.settings.basePath + 'wweave/add-to-cart',
      data: 'product_id=' + product_id + '&quantity=' + quantity,
      success: function(data) {
        // console.log(data);
        if (data['isError'] == 'false') {
          if (action == 'buy_now') {
            document.location = Drupal.settings.basePath + 'checkout';
          }
          else {
            update_mini_cart();
          }
        }
        else {
          alert(data['_ERROR_MESSAGE_']);
          close_loading();
        }
      },
      error: function(jqXHR, textStatus, errorThrown) {
        alert('We are facing some technical difficulties at the moment. Please try again after some time.');
        console.log(textStatus + ': ' + errorThrown);
        close_loading();
      },
      dataType: 'json'
    });
  });
  
  $('#js_addToWishlist, .plp-add-to-wishlist').click(function(e) {
    e.preventDefault();
    if ($(this).hasClass('plp-add-to-wishlist')) {
      var product_id = $(this).data('product-id');
      var quantity = 1;
    }
    else {
      var product_id = $('.pdpSelectableFeature li.selected:first a').data('product-id');
      var quantity =  $('#js_quantity1').val();
    }

    if (typeof product_id == 'undefined' || !product_id) {
      var product_id = $('#eCommerceProductDetailContainer').data('master-product-id');
    }

    if(product_id == undefined || product_id == null){
      alert('Please select a variant');
      return;
    }

    // alert(action + ' - ' + product_id + ' | ' + quantity);
    loading();
    $.ajax({
      type: "POST",
      url: Drupal.settings.basePath + 'wweave/add-to-love-list',
      data: 'product_id=' + product_id + '&quantity=' + quantity,
      success: function(data) {
             //console.log(data);
        if (data['isError'] == 'false') {
          document.location = Drupal.settings.basePath + 'account/love-list';
          close_loading();
        }
        else {
          alert('Error adding item.');
          close_loading();
        }
      },
      error: function(jqXHR, textStatus, errorThrown) {
        console.log(textStatus + ': ' + errorThrown);
        close_loading();
      },
      dataType: 'json'
    });
  });

  $('.cart-product-delete').click(function(e) {
    e.preventDefault();
    var product_id = $(this).closest('.cartItem').data('product-id');
    loading();
    $.ajax({
      type: "POST",
      url: Drupal.settings.basePath + 'wweave/delete-item',
      data: 'product_id=' + product_id,
      success: function(data) {
        // console.log(data);
        if (data['isError'] == 'false') {
          document.location = Drupal.settings.basePath + 'cart';
        }
        else {
          alert('Error deleting item.');
          close_loading();
        }
      },
      error: function(jqXHR, textStatus, errorThrown) {
        alert('We are facing some technical difficulties at the moment. Please try again after some time.');
        console.log(textStatus + ': ' + errorThrown);
        close_loading();
      },
      dataType: 'json'
    });
  });

  $('.cart-product-edit').click(function(e) {
    e.preventDefault();
    var product_id = $(this).closest('.cartItem').data('product-id');
    $(this).hide();
    $(this).closest('.cartItem').find('.cart-product-update').show();
    $(this).closest('.cartItem').find('.item-qt').show();
    $(this).closest('.cartItem').find('.qty-number').hide();
  });

  $('.cart-product-update').click(function(e) {
    e.preventDefault();
    var product_id = $(this).closest('.cartItem').data('product-id');
    var quantity = $(this).closest('.cartItem').find('.item-qt select').val();
    $(this).hide();
    $(this).closest('.cartItem').find('.cart-product-edit').show();
    $(this).closest('.cartItem').find('.item-qt').hide();
    $(this).closest('.cartItem').find('.qty-number').show();
    loading();
    $.ajax({
      type: "POST",
      url: Drupal.settings.basePath + 'wweave/modify-item',
      data: 'product_id=' + product_id + '&quantity=' + quantity,
      success: function(data) {
        // console.log(data);
        if (data['isError'] == 'false') {
          document.location = Drupal.settings.basePath + 'cart';
        }
        else {
          alert('Error modifying item.');
          close_loading();
        }
      },
      error: function(jqXHR, textStatus, errorThrown) {
        alert('We are facing some technical difficulties at the moment. Please try again after some time.');
        console.log(textStatus + ': ' + errorThrown);
        close_loading();
      },
      dataType: 'json'
    });
  });

  $('#js_submitCartBtn').click(function(e) {
    e.preventDefault();
    loading();
    document.location = Drupal.settings.basePath + 'checkout';
  });

  $('#js_chooseAddressBtn').click(function(e) {
    e.preventDefault();
    var $address = $('input.SHIPPING_SELECT_ADDRESS:checked');
    var post_data = 'contactMechId='+encodeURIComponent($address.val());

    loading();
    $.ajax({
      type: "POST",
      url: Drupal.settings.basePath + 'checkout/update-cart-address',
      data: post_data,
      success: function(data) {
        if (typeof data['_ERROR_MESSAGE_'] != 'undefined' && data['_ERROR_MESSAGE_'].length > 0) {
          alert(data['_ERROR_MESSAGE_']);
          close_loading();
        }
        else {
          document.location = Drupal.settings.basePath + 'checkout-payment';
        }
      },
      error: function(jqXHR, textStatus, errorThrown) {
        alert('We are facing some technical difficulties at the moment. Please try again after some time.');
        console.log(textStatus + ': ' + errorThrown);
        close_loading();
      },
      dataType: 'json'
    });
  });

  $('#js_submitAddressBtn').click(function(e) {
    e.preventDefault();
    if($('#js_SHIPPING_POSTAL_CODE_NEW').val() == ''){
              alert('Enter Postal Code.');
              return false;
          }
          if($('#js_SHIPPING_ATN_NAME').val() == ''){
              alert('Enter Address type.');
              return false;
          }
          if($('#js_SHIPPING_FIRST_NAME_NEW').val() == ''){
              alert('Enter First Name.');
              return false;
          }
          if($('#js_SHIPPING_LAST_NAME_NEW').val() == ''){
              alert('Enter Last Name.');
              return false;
          }
          if($('#js_SHIPPING_ADDRESS1_NEW').val() == ''){
              alert('Enter Address.');
              return false;
          }
          if($('#js_SHIPPING_CITY_NEW').val() == ''){
              alert('Enter City.');
              return false;
          }
          if($('#js_SHIPPING_STATE_NEW').val() == ''){
              alert('Enter State.');
              return false;
          }
          if($('#PHONE_MOBILE_CONTACT_NEW').val() == ''){
              alert('Enter Mobile Number.');
              return false;
          }
    var data_SHIPPING_POSTAL_CODE = $('[name=SHIPPING_POSTAL_CODE]:first').val();
    var data_SHIPPING_ADDRESS1    = $('[name=SHIPPING_ADDRESS1]:first').val();
    var data_SHIPPING_FIRST_NAME  = $('[name=SHIPPING_FIRST_NAME]:first').val();
    var data_SHIPPING_LAST_NAME   = $('[name=SHIPPING_LAST_NAME]:first').val();
    var data_SHIPPING_ATTN_NAME   = $('[name=SHIPPING_ATTN_NAME]:first').val();
    var data_SHIPPING_CITY        = $('[name=SHIPPING_CITY]:first').val();
    var data_PHONE_MOBILE_LOCAL   = $('[name=PHONE_MOBILE_LOCAL]:first').val();
    var data_PHONE_MOBILE_CONTACT = $('[name=PHONE_MOBILE_CONTACT]:first').val();
    var data_SHIPPING_STATE       = $('[name=SHIPPING_STATE]:first').val();

    var post_data = 'SHIPPING_POSTAL_CODE='+encodeURIComponent(data_SHIPPING_POSTAL_CODE)+'&SHIPPING_ADDRESS1='+encodeURIComponent(data_SHIPPING_ADDRESS1)+'&SHIPPING_FIRST_NAME='+encodeURIComponent(data_SHIPPING_FIRST_NAME)+'&SHIPPING_LAST_NAME='+encodeURIComponent(data_SHIPPING_LAST_NAME)+'&SHIPPING_ATTN_NAME='+encodeURIComponent(data_SHIPPING_ATTN_NAME)+'&SHIPPING_CITY='+encodeURIComponent(data_SHIPPING_CITY)+'&PHONE_MOBILE_LOCAL='+encodeURIComponent(data_PHONE_MOBILE_LOCAL)+'&PHONE_MOBILE_CONTACT='+encodeURIComponent(data_PHONE_MOBILE_CONTACT)+'&SHIPPING_STATE='+encodeURIComponent(data_SHIPPING_STATE);

    loading();
    $.ajax({
      type: "POST",
      url: Drupal.settings.basePath + 'wweave/add-address',
      data: post_data,
      success: function(data) {
        if (typeof data['_ERROR_MESSAGE_'] != 'undefined' && data['_ERROR_MESSAGE_'].length > 0) {
          alert(data['_ERROR_MESSAGE_']);
          close_loading();
        }
        else {
          document.location = Drupal.settings.basePath + 'checkout-payment';
        }
      },
      error: function(jqXHR, textStatus, errorThrown) {
        alert('We are facing some technical difficulties at the moment. Please try again after some time.');
        console.log(textStatus + ': ' + errorThrown);
        close_loading();
      },
      dataType: 'json'
    });
  });

  $('#js_submitOrderBtn').click(function(e) {
    e.preventDefault();
    var data = '';
    var paymentMethodId = $(this).data('payment-method-id');
    loading();
    $.ajax({
      type: "POST",
      url: Drupal.settings.basePath + 'checkout-final',
      data: 'paymentMethodId=' + paymentMethodId,
      success: function(data) {
         console.log(data);
        if (typeof data['_ERROR_MESSAGE_'] != 'undefined' && data['_ERROR_MESSAGE_'].length > 0) {
          alert(data['_ERROR_MESSAGE_']);
          close_loading();
        }
        else {
          document.location = Drupal.settings.basePath + 'view-order/' + encodeURIComponent(data['orderId']);
        }
      },
      error: function(jqXHR, textStatus, errorThrown) {
        alert('We are facing some technical difficulties at the moment. Please try again after some time.');
        console.log(textStatus + ': ' + errorThrown);
        close_loading();
      },
      dataType: 'json'
    });
  });

  $('#subscribeMail').click(function(){
    $('#subMsg').empty();
    var subscriberEmail = document.getElementById('newsletter').value;
    var data = '';
    data += '&subscriberEmail=' + subscriberEmail;
    $.ajax({
          type: "POST",
          url: Drupal.settings.basePath + 'wweave/lookbook',
          data: data,
          success: function(data) {
            if (typeof data['_SUCCESS_MESSAGE_'] != 'undefined' && data['_SUCCESS_MESSAGE_'].length > 0) {
                $('#subMsg').append('Thank you for subscribing.');
              }
              if (typeof data['_ERROR_MESSAGE_'] != 'undefined' && data['_ERROR_MESSAGE_'].length > 0) {
                $('#subMsg').append(data['_ERROR_MESSAGE_']);
              }
            console.log(data);
          },
          error: function(jqXHR, textStatus, errorThrown) {
            console.log(textStatus + ': ' + errorThrown);
            close_loading();
          },
          dataType: 'json'
        });
  });

      $(".addToCartFromWishlistGlobular").click(function(){
        var product_id = $(this).data('product-id');
        var quantity = $(this).data('quantity');
        var sequenceId = $(this).data('delete-id');
        if(quantity == undefined || quantity == null){
            quantity = 1;
        }
        loading();
        $.ajax({
          type: "POST",
          url: Drupal.settings.basePath + 'wweave/add-to-cart',
          data: 'product_id=' + product_id + '&quantity=' + quantity,
          success: function(data) {
            console.log(data);
            if (data['isError'] == 'false') {
                if(remove_wishlist(sequenceId) == 'true'){
                  document.location = Drupal.settings.basePath + 'cart';
                }
                close_loading();
            }else {
              alert('Error adding item.');
              close_loading();
            }
          },
          error: function(jqXHR, textStatus, errorThrown) {
            console.log(textStatus + ': ' + errorThrown);
            close_loading();
          },
          dataType: 'json'
        });
    });


  $('.wish-delete').click(function(e){
    e.preventDefault();
    var sequenceId = jQuery(this).data('delete-id');
      jQuery.ajax({
          type: "POST",
          url: Drupal.settings.basePath + 'delete-wishlist',
          data: 'sequenceId=' + sequenceId,
          success: function(data) {
             //console.log(data);
            if (data['isError'] == 'false') {
                document.location = Drupal.settings.basePath + 'account/love-list';
            }
            else {
              alert('Server Down! Please try again Later');
            }
          },
          error: function(jqXHR, textStatus, errorThrown) {
            console.log(textStatus + ': ' + errorThrown);
          },
          dataType: 'json'
        });
  })

  $('#js_submitChangePasswdBtn').click(function(e) {
    e.preventDefault();
    
    var data_OLD_PASSWORD     = $('[name=OLD_PASSWORD]:first').val();
    var data_NEW_PASSWORD     = $('[name=NEW_PASSWORD]:first').val();
    var data_CONFIRM_PASSWORD = $('[name=CONFIRM_PASSWORD]:first').val();


    var post_data = 'OLD_PASSWORD=' + encodeURIComponent(data_OLD_PASSWORD) + '&NEW_PASSWORD=' + encodeURIComponent(data_NEW_PASSWORD) + '&CONFIRM_PASSWORD=' + encodeURIComponent(data_CONFIRM_PASSWORD);
    loading();
    $.ajax({
      type: "POST",
      url: Drupal.settings.basePath + 'wweave/user-change-password',
      data: post_data,
      success: function(data) {
        // console.log(data);
        if (data['error']) {
          alert("Error updating password!\n" + data['error_messages'].join("\n"));
        }
        else {
          document.location = Drupal.settings.basePath + 'account/change-password';
        }
        close_loading();
      },
      error: function(jqXHR, textStatus, errorThrown) {
        alert('We are facing some technical difficulties at the moment. Please try again after some time.');
        console.log(textStatus + ': ' + errorThrown);
        close_loading();
      },
      dataType: 'json'
    });
  });

  $('#js_submitProfileBtn').click(function(e) {
    e.preventDefault();

    var data_USER_FIRST_NAME  = $('[name=USER_FIRST_NAME]:first').val();
    var data_USER_LAST_NAME   = $('[name=USER_LAST_NAME]:first').val();

    var post_data = 'USER_FIRST_NAME='+encodeURIComponent(data_USER_FIRST_NAME)+'&USER_LAST_NAME='+encodeURIComponent(data_USER_LAST_NAME);

    loading();
    $.ajax({
      type: "POST",
      url: Drupal.settings.basePath + 'account/update-profile',
      data: post_data,
      success: function(data) {
        if (typeof data['_ERROR_MESSAGE_'] != 'undefined' && data['_ERROR_MESSAGE_'].length > 0) {
          alert(data['_ERROR_MESSAGE_']);
          close_loading();
        }
        else {
          document.location = Drupal.settings.basePath + 'account/profile';
        }
      },
      error: function(jqXHR, textStatus, errorThrown) {
        alert('We are facing some technical difficulties at the moment. Please try again after some time.');
        console.log(textStatus + ': ' + errorThrown);
        close_loading();
      },
      dataType: 'json'
    });
  });

  $("#giftMessageEnum").change(function(e){
    $('#giftMessageText').val($("#giftMessageEnum :selected").text());
  });

  $('.giftMessageSave').click(function(e){
    var giftFrom = $('#from').val();
    var giftTo = $('#to').val();
    var cartLine = $('#cartLine').val();
    var msgText = $('#giftMessageText').val();
    $.ajax({
      type: "POST",
      url: Drupal.settings.basePath + 'saveGiftMessage',
      data: 'cartLine=' + cartLine + '&giftFrom=' + giftFrom + '&giftTo=' + giftTo + '&msgText=' + msgText,
      success: function(data){
        if(data['error']){
            alert("Error setting the gift message!\n" + data['error_messages'].join("\n"));
        }else{
            document.location = Drupal.settings.basePath + 'cart';
        }
      },
      dataType: 'json'

    });
  });

  $('input.searchSubmit,input.searchGlowingSubmit').click(function(e) {
    e.preventDefault();
    var search_text = $('#searchText').val().replace(/[^a-z0-9\s\.'"]+/ig, '');
    if (search_text.length == 0) {
      alert(Drupal.t('Please enter some search terms'));
      $('#searchText').focus();
    }
    else {
      document.location = Drupal.settings.basePath + 'search/site/' + encodeURIComponent(search_text);
    }
  });


  $('#searchText').keyup(function(e) {
    if (e.which == 13) {
      e.preventDefault();
      // Enter key.
      $('input.searchSubmit:first').click();
    }
  });
  $('.button_font').click(function(){
        if($('#js_CUSTOMER_POSTAL_CODE').val() == ''){
              alert('Enter Postal Code.');
              return false;
          }
          if($('#js_CUSTOMER_FIRST_NAME').val() == ''){
              alert('Enter First Name.');
              return false;
          }
          if($('#js_CUSTOMER_LAST_NAME').val() == ''){
              alert('Enter Last Name.');
              return false;
          }
          if($('#PHONE_MOBILE_CONTACT').val() == ''){
              alert('Enter Mobile Number.');
              return false;
          }
          if($('#js_CUSTOMER_ATTN_NAME').val() == ''){
              alert('Enter Address type.');
              return false;
          }
          if($('#js_CUSTOMER_ADDRESS1').val() == ''){
              alert('Enter Address.');
              return false;
          }
          if($('#js_CUSTOMER_CITY').val() == ''){
              alert('Enter City.');
              return false;
          }
          if($('#js_CUSTOMER_STATE').val() == ''){
              alert('Enter State.');
              return false;
          }
  });

  $('#search_sort').change(function(e) {
    e.preventDefault();
    var search_sort = $(this).val();
    var current_search_without_sort = document.location.search.replace(/\&*solrsort.*?(asc|desc)\&*/, '');
    var final_destination = document.location.pathname + current_search_without_sort;
    if (final_destination.indexOf('?') == -1) {
      final_destination += '?';
    }
    if (search_sort.length > 0) {
      final_destination += ('&solrsort=' + encodeURIComponent(search_sort));
    }
    document.location = final_destination;
  });

  update_mini_cart();

  $('#wweave-demo-admin-change-theme').change(function() {
    document.location = Drupal.settings.basePath + '?wweave_demo_theme=' + $(this).val();
  });

  $(".apply_cpn").click(function(){
   var code = $(this).attr('data-coupon-value');
   document.getElementById('js_manualOfferCode').value = code;
   $('#myModal').hide();
   $('.jquery-modal').hide(); 
  });

  $('.close').click(function(){
    $('#myModal').hide();
   $('.jquery-modal').hide();
  });
  $('#promoview').click(function(event) {
    console.log('this also triggering');
    event.preventDefault();
    var id=$(this).attr('href');
    $('div#'+id).modal(); 
  });

});

function update_mini_cart() {
  $.ajax({
    type: "GET",
    url: Drupal.settings.basePath + 'wweave/mini-cart',
    success: function(data) {
      $('#lightCart_inner, #cartLightform').html(data);
      $('#mini-cart-count').html($('#cartLightform .lightBoxOrderItemsItemName').length);
      close_loading();
    },
    error: function(jqXHR, textStatus, errorThrown) {
      console.log(textStatus + ': ' + errorThrown);
    },
    dataType: 'html'
  });
}

})(jQuery);

function loading() {
  // add the overlay with loading image to the page
  var over = '<div id="overlay">' +
    '<img id="ajax-loading" src="' + Drupal.settings.basePath + 'sites/all/modules/wweave<?php echo current_theme_path() ?>/images/ajax-loader.gif">' +
    '<p id="ajax-loading-message">' + Drupal.t('Please wait...') + '</p>' +
    '</div>';
  jQuery(over).appendTo('body');

  // click on the overlay to remove it
  // jQuery('#overlay').click(function() {
  //   jQuery(this).remove();
  // });

  // hit escape to close the overlay
  // jQuery(document).keyup(function(e) {
  //   if (e.which === 27) {
  //     close_loading();
  //   }
  // });
};

function close_loading() {
  jQuery('#overlay').remove();
}
function submitAddress(form_name){
   jQuery('#'+form_name).submit();
}

function remove_wishlist(sequenceId){
  var flag = 'true';
  jQuery.ajax({
    type: "POST",
    url: Drupal.settings.basePath + 'delete-wishlist',
    data: 'sequenceId=' + sequenceId,
    success: function(data) {
      console.log(data);
      if (data['isError'] == 'false') {
        //document.location = Drupal.settings.basePath + 'account/love-list';
        
      }
      else {
        alert('Server Down! Please try again Later');
        flag = 'false';
      }
    },
    error: function(jqXHR, textStatus, errorThrown) {
      console.log(textStatus + ': ' + errorThrown);
      flag = 'false';
    },
    dataType: 'json'
  });
  return flag;
}

function showPlpSizeGuide(selectFeatureDiv, productId) {
  jQuery(".js_selectableFeature1_1").hide();
  var data = "";
  data += 'productId=' + productId;
  loading();
       jQuery.ajax({
          type: 'POST',
          url: Drupal.settings.basePath + 'wweave/plp-check-inventory',
          data : data,
          success: function(data){
            console.log(data);
            var all_pid = Object.keys(data['inventoryProductLevel']);
            for(var i =0 ; i< all_pid.length ; i++){
              var pid = all_pid[i];
              var ppid = '';
              if(data['inventoryProductLevel'][pid]['availableQuantity'] == '0'){
              ppid = pid;
              jQuery("#js_selectableFeature_li_"+selectFeatureDiv).find('.js_selectableFeature_1').find('li').each(function() {
                  //  $(this).show();
                    if($(this).value == ppid){
                      jQuery(this).find('a').addClass('disableClass').slideToggle();
                    }
                });
              }
            }
            jQuery("#js_selectableFeature_li_"+selectFeatureDiv).slideToggle();
            close_loading();
          },
          error: function(jqXHR, textStatus, errorThrown){
            alert("Server down. Please try again later!")
            close_loading();
          },
          dataType:'json'
       });
       
}

function showPlpSizeGuide1(selectFeatureDiv , productId) {
      //jQuery("#js_selectableFeature_li_"+selectFeatureDiv).slideToggle();
   /*   if(isVisible12){
        sizeplp=false;
        }
        else{
        sizeplp=true;
        }
     */
     jQuery(".js_selectableFeature_1").hide();
     var data = "";
  data += 'productId=' + productId;
  loading();
       jQuery.ajax({
          type: 'POST',
          url: Drupal.settings.basePath + 'wweave/plp-check-inventory',
          data : data,
          success: function(data){
            console.log(data);
            var all_pid = Object.keys(data['inventoryProductLevel']);
            for(var i =0 ; i< all_pid.length ; i++){
              var pid = all_pid[i];
              var ppid = '';
              if(data['inventoryProductLevel'][pid]['availableQuantity'] == '0'){
              ppid = pid;
              jQuery("#js_selectableFeature1_li_"+selectFeatureDiv).find('.js_selectableFeature1_1').find('li').each(function() {
                   // $(this).show();
                    if($(this).value == ppid){
                      jQuery(this).find('.plp-add-to-wishlist').addClass('disableClass').slideToggle();
                    }
                });
              }
            }
            var isVisible12 = jQuery("#js_selectableFeature1_li_"+selectFeatureDiv).is(":visible");
    jQuery("#size-wrapper").html('');
    jQuery("#size-wrapper").html(wishListContent);
      jQuery("#js_selectableFeature1_li_"+selectFeatureDiv).slideToggle();
            close_loading();
          },
          error: function(jqXHR, textStatus, errorThrown){
            alert("Server down. Please try again later!")
            close_loading();
          },
          dataType:'json'
       });
}

 function call_cart(){
  jQuery.ajax({
    type: "POST",
    url: Drupal.settings.basePath + 'cart',
    data: 'flag=' + true,
    success: function(data) {
      console.log(data);
      if (data['isError'] == 'false') {
        //document.location = Drupal.settings.basePath + 'account/love-list';
        if(data['LoyaltyAmount'] >= 0){
          jQuery('.loyaltyPoint').empty();
          jQuery('.oc-summry').after('<li class="number totalNumberItems showCartOrderItemsSummaryTotalNumberItems"><div><label>Loyalty Amount:</label><span>-$'+ data['LoyaltyAmount'].toFixed('2')+'</span></div></li>');
          jQuery('.totalAmount').empty();
          if((data['partyAppliedStoreCreditTotal'])!='0'){
            var grandtotal=data['orderGrandTotal'] - data['partyAppliedStoreCreditTotal'];
           jQuery('.showCartOrderItemsSummaryShippingAmount').after('<li class="currency totalAmount showCartOrderItemsSummaryTotalAmount"><div><label>Total:</label><span>$'+grandtotal+'</span></div></li>'); 
          }else{
          jQuery('.showCartOrderItemsSummaryShippingAmount').after('<li class="currency totalAmount showCartOrderItemsSummaryTotalAmount"><div><label>Total:</label><span>$'+data['orderGrandTotal']+'</span></div></li>');
          }
        }
      }
      else {
        alert('Server Down! Please try again Later');
        flag = 'false';
      }
    },
    error: function(jqXHR, textStatus, errorThrown) {
      console.log(textStatus + ': ' + errorThrown);
      flag = 'false';
    },
    dataType: 'json'
  });
} 
(function ($) {

 
$(document).ready(function() {

 //select all checkboxes
$("#select_all").change(function(){  //"select all" change 
    var status = this.checked; // "select all" checked status
    $('.product_id_checked').each(function(){ //iterate all listed checkbox items
        this.checked = status; //change ".checkbox" checked status
    });
});

$('.product_id_checked').change(function(){ //".checkbox" change 
    //uncheck "select all", if one of the listed checkbox item is unchecked
    if(this.checked == false){ //if this item is unchecked
        $("#select_all")[0].checked = false; //change "select all" checked status to false
    }
    
    //check "select all" if all checkbox items are checked
    if ($('.product_id_checked:checked').length == $('.product_id_checked').length ){ 
        $("#select_all")[0].checked = true; //change "select all" checked status to true
    }
});


if($('#re-order-item').length > 0) {
  $('#re-order-item').click(function(e) {
    e.preventDefault();
    var product_ids = {
      product:{},
    };
    
    $('input[name=product_id_checked]:checked').each(function () {
         var that = this;
        product_ids['product'][$(that).val()] = $('#qty_'+$(that).val()).val();

    });
    var checked = Object.keys(product_ids.product).length;
    if(checked == 0){
        alert('Please select one product');
        return false;
    }

    loading();
    $.ajax({
      type: "POST",
      url: Drupal.settings.basePath + 're-order-product',
      data:product_ids,
      success: function(data) {
        console.log(data);
        if (data['status']=='pass') {
          // redirect to cart page
            close_loading();
        }
        else {
          alert('Error In re-ordering, Please try after some time.');
          close_loading();
        }
      },
      error: function(jqXHR, textStatus, errorThrown) {
        alert('We are facing some technical difficulties at the moment. Please try again after some time.');
        console.log(textStatus + ': ' + errorThrown);
        close_loading();
      },
      dataType: 'json'
    });
  });  
}
if($('#return-order').length > 0) {
  $('#return-order').click(function(e) {
    e.preventDefault();
    loading();
    $.ajax({
      type: "POST",
      url: Drupal.settings.basePath + 'return-order-product',
      success: function(data) {
        console.log(data);
        if (data['status']=='pass') {
          // redirect to cart page
            close_loading();
        }
        else {
          alert('Error In returning order, Please try after some time.');
          //alert(data['error_messages'].join("\n"));
          close_loading();
        }
      },
      error: function(jqXHR, textStatus, errorThrown) {
        alert('We are facing some technical difficulties at the moment. Please try again after some time.');
        console.log(textStatus + ': ' + errorThrown);
        close_loading();
      },
      dataType: 'json'
    });
  });  
}
if($('#cancel-order').length > 0) {
  $('#cancel-order').click(function(e) {
    e.preventDefault();
    loading();
    $.ajax({
      type: "POST",
      url: Drupal.settings.basePath + 'cancel-order-product',
      success: function(data) {
        console.log(data);
        if (data['status']=='pass') {
          // redirect to cart page
            close_loading();
        }
        else {
          alert('Error In canceling the order, Please try after some time.');
          //alert(data['error_messages'].join("\n"));
          close_loading();
        }
      },
      error: function(jqXHR, textStatus, errorThrown) {
        alert('We are facing some technical difficulties at the moment. Please try again after some time.');
        console.log(textStatus + ': ' + errorThrown);
        close_loading();
      },
      dataType: 'json'
    });
  });  
}
});
})(jQuery);

function updateShipping(selectedValue){
    var data = '';
    data += 'shipmentMethodId=' + selectedValue.value;
    //alert(data);
    jQuery.ajax({
            type: "POST",
            url: Drupal.settings.basePath + 'cart',
            data: data,
            success: function(data) {
              //alert(data['partyAppliedStoreCreditTotal']);
              document.location = Drupal.settings.basePath + 'cart';
            },
            error: function(jqXHR, textStatus, errorThrown) {
              //alert('Store credit could be applied.');
              console.log(textStatus + ': ' + errorThrown);
              close_loading();
            },
            dataType: 'json'
        });
}

function updateShippingWomen(selectedValue){
    var data = '';
    data += 'shipmentMethodId=' + selectedValue.value;
    //alert(data);
    jQuery.ajax({
            type: "POST",
            url: Drupal.settings.basePath + 'cart',
            data: data,
            success: function(data) {
              //alert(data['partyAppliedStoreCreditTotal']);
              document.location = Drupal.settings.basePath + 'cart-wclothing';
            },
            error: function(jqXHR, textStatus, errorThrown) {
              //alert('Store credit could be applied.');
              console.log(textStatus + ': ' + errorThrown);
              close_loading();
            },
            dataType: 'json'
        });
}