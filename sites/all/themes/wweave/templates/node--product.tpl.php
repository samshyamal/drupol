<?php
  /**
   * @file
   * Default theme implementation to display a node.
   *
   * Available variables:
   * - $title: the (sanitized) title of the node.
   * - $content: An array of node items. Use render($content) to print them all,
   *   or print a subset such as render($content['field_example']). Use
   *   hide($content['field_example']) to temporarily suppress the printing of a
   *   given element.
   * - $user_picture: The node author's picture from user-picture.tpl.php.
   * - $date: Formatted creation date. Preprocess functions can reformat it by
   *   calling format_date() with the desired parameters on the $created variable.
   * - $name: Themed username of node author output from theme_username().
   * - $node_url: Direct URL of the current node.
   * - $display_submitted: Whether submission information should be displayed.
   * - $submitted: Submission information created from $name and $date during
   *   template_preprocess_node().
   * - $classes: String of classes that can be used to style contextually through
   *   CSS. It can be manipulated through the variable $classes_array from
   *   preprocess functions. The default values can be one or more of the
   *   following:
   *   - node: The current template type; for example, "theming hook".
   *   - node-[type]: The current node type. For example, if the node is a
   *     "Blog entry" it would result in "node-blog". Note that the machine
   *     name will often be in a short form of the human readable label.
   *   - node-teaser: Nodes in teaser form.
   *   - node-preview: Nodes in preview mode.
   *   The following are controlled through the node publishing options.
   *   - node-promoted: Nodes promoted to the front page.
   *   - node-sticky: Nodes ordered above other non-sticky nodes in teaser
   *     listings.
   *   - node-unpublished: Unpublished nodes visible only to administrators.
   * - $title_prefix (array): An array containing additional output populated by
   *   modules, intended to be displayed in front of the main title tag that
   *   appears in the template.
   * - $title_suffix (array): An array containing additional output populated by
   *   modules, intended to be displayed after the main title tag that appears in
   *   the template.
   *
   * Other variables:
   * - $node: Full node object. Contains data that may not be safe.
   * - $type: Node type; for example, story, page, blog, etc.
   * - $comment_count: Number of comments attached to the node.
   * - $uid: User ID of the node author.
   * - $created: Time the node was published formatted in Unix timestamp.
   * - $classes_array: Array of html class attribute values. It is flattened
   *   into a string within the variable $classes.
   * - $zebra: Outputs either "even" or "odd". Useful for zebra striping in
   *   teaser listings.
   * - $id: Position of the node. Increments each time it's output.
   *
   * Node status variables:
   * - $view_mode: View mode; for example, "full", "teaser".
   * - $teaser: Flag for the teaser state (shortcut for $view_mode == 'teaser').
   * - $page: Flag for the full page state.
   * - $promote: Flag for front page promotion state.
   * - $sticky: Flags for sticky post setting.
   * - $status: Flag for published status.
   * - $comment: State of comment settings for the node.
   * - $readmore: Flags true if the teaser content of the node cannot hold the
   *   main body content.
   * - $is_front: Flags true when presented in the front page.
   * - $logged_in: Flags true when the current user is a logged-in member.
   * - $is_admin: Flags true when the current user is an administrator.
   *
   * Field variables: for each field instance attached to the node a corresponding
   * variable is defined; for example, $node->body becomes $body. When needing to
   * access a field's raw values, developers/themers are strongly encouraged to
   * use these variables. Otherwise they will have to explicitly specify the
   * desired field language; for example, $node->body['en'], thus overriding any
   * language negotiation rule that was previously applied.
   *
   * @see template_preprocess()
   * @see template_preprocess_node()
   * @see template_process()
   *
   * @ingroup themeable
   */

  global $drubiz_domain;
    $system_data = json_decode($node->field_system_data[LANGUAGE_NONE][0]['value']);
    $product = $system_data->product_raw;
    $product_related = array('500021','500022','500023');
    $related_product_system_data = array();
    foreach ($product_related as $pkey => $pvalue) {
      $related_node = node_load(get_nid_from_product_id($pvalue));
      $related_system_data = json_decode($related_node->field_system_data[LANGUAGE_NONE][0]['value']);
      $related_product_system_data[$pvalue] = $related_system_data->product_raw; 
    }
    $drubiz_category_names = json_decode(variable_get('drubiz_category_names', '[]'), TRUE);
    $category_names_from_catalog = $drubiz_category_names['globus'];
    $get_category_names = explode(',', $product->product_category_id);
    //$category_names = $category_names_from_catalog[$get_category_names[2]];
	$category_names = isset($category_names_from_catalog[$get_category_names[2]]) ? $category_names_from_catalog[$get_category_names[2]] : '';
    $category = strtolower($category_names);
    $category_name = str_replace(" ", '' , $category);
    $selected_features = get_selected_features($product);
    $facet_values = get_facet_values($system_data);
    $share_url = url('node/' . $node->nid, array('absolute' => TRUE));
    $out_of_stock_info = pdp_out_of_stock_info($node->field_product_id[LANGUAGE_NONE][0]['value']);
    $out_of_stock = $out_of_stock_info->inventoryProductLevel;
   // krumo($out_of_stock_info->inventoryProductLevel , $facet_values);
    //krumo($sku);
  ?>

  <?php 
  $catalogName = $drubiz_domain['catalog'];
  $cntCategory = count($get_category_names);
  $cname = "";
  $collon = rawurlencode(":");
  $smCatalog = "?f[0]=sm_field_catalog".$collon.$catalogName;
  $smCategory= "";
  $smCategoryName = "";
  $smSubCategoryName = "";
  $breadcrumbList = '';
  for($i=0;$i<$cntCategory;$i++) {
    if($i==0) {
      $smCategory = "&f[1]=sm_field_category".$collon;
      $smCategoryName = str_replace('&', '&amp;', $drubiz_category_names[$catalogName][trim($get_category_names[$i])]);
      $url = url('search/site').$smCatalog.$smCategory.$smCategoryName.$smSubCategoryName;
      $breadcrumbList .= "<a href=$url>".$drubiz_category_names[$catalogName][trim($get_category_names[$i])]."</a>/";
    }
    if($i == 1) {
      $smFieldName = str_replace('&', '&amp;', $drubiz_category_names[$catalogName][trim($get_category_names[$i])]);
      $smSubCategoryName = "&f[2]=sm_field_subcategory".$collon.rawurlencode($smFieldName);
      $url = url('search/site').$smCatalog.$smCategory.$smCategoryName.$smSubCategoryName;
      if($drubiz_category_names[$catalogName][trim($get_category_names[$i])])
      $breadcrumbList .= "<a href=$url>".$drubiz_category_names[$catalogName][trim($get_category_names[$i])]."</a>/";
    }
    if($i == 2) {
      $smFieldName = str_replace('&', '&amp;', $drubiz_category_names[$catalogName][trim($get_category_names[$i])]);
      $smSubCategoryName = "&f[2]=sm_field_subcategory".$collon.rawurlencode($smFieldName);
      $smFieldName1 = trim($get_category_names[$i]);
      $smSubCategoryName1 = "&f[3]=sm_field_sub_subcategory".$collon.rawurlencode($smFieldName1);
      $url = url('search/site').$smCatalog.$smCategory.$smCategoryName.$smSubCategoryName.$smSubCategoryName1;
      if($drubiz_category_names[$catalogName][trim($get_category_names[$i])])
      $breadcrumbList .= "<a href=$url>".$drubiz_category_names[$catalogName][trim($get_category_names[$i])]."</a>/";
    }
  }
  $homeurl = url();
  $home = "<a href=$homeurl>Home</a>&nbsp;/&nbsp;";
?>

<?php echo $home . $breadcrumbList.'&nbsp;'.$product->product_name;?>
<div id="eCommerceProductDetailContainer" class="<?php print $classes; ?> clearfix"<?php print $attributes; ?>>
  <div class="PDP group group1">
    <ul class="displayList pdpList PDP">
      <li class="image mainImage pdpMainImage">
        <div class="pdpMainImage">
          <div id="js_productDetailsImageContainer" onclick="displayDialogBox('largeImage_')">
            <a href="<?php echo drubiz_image($product->pdp_large_image) ?>" class="innerZoom" rel="undefined" title="" style="outline-style: none; text-decoration: none;">
              <div class="zoomPad">
                <img src="<?php echo drubiz_image($product->pdp_regular_image) ?>" name="mainImage" class="js_productLargeImage" height="630" width="490" onerror="onImgError(this, 'PDP-Large');" id="js_mainImage" title="" style="opacity: 1; display: block;">
                <div class="zoomPup" style="display: none; top: -1px; left: 223px; width: 266px; height: 330px; position: absolute; border-width: 1px;"></div>
                <div class="zoomWindow" style="position: absolute; z-index: 5001; cursor: default; left: 0px; top: 0px; display: none;">
                  <div class="zoomWrapper" style="border-width: 1px; width: 490px; cursor: crosshair;">
                    <div class="zoomWrapperTitle" style="width: 100%; position: absolute; display: block;">undefined</div>
                    <div class="zoomWrapperImage" style="width: 100%; height: 630px;"><img src="<?php echo drubiz_image($product->pdp_alt_1_large_image) ?>" style="position: absolute; border: 0px; display: block; left: -411.429px; top: 0px;"></div>
                  </div>
                </div>
                <div class="zoomPreload" style="visibility: hidden; top: 293.5px; left: 245px; position: absolute;"></div>
              </div>
            </a>
          </div>
          <div class="wishList_social_share pdp">
            <span>
            <span><a title="Share on Facebook" class="fb_share" target="_blank" href="#" rel="me"></a></span>
            <span><a title="Share on Twitter" class="tw_share" target="_blank" href="#" rel="nofollow"></a></span>
            <span><a title="Share on Pinterest" class="pinit_share pin-it-button" target="_blank" href="#" count-layout="horizontal"></a></span>
            <span><a title="Share on Google" class="google_share" target="_blank" href="#"></a></span>
            <span><a title="Share on Mail" class="mailFriend" href="#"></a></span>
            <span><a title="Share on WhatsApp" class="whatsApp" href="#"></a></span>
            </span>
          </div>
        </div>
        <!--Added for making the link available on PDP image -->
        <?php if(!empty($GLOBALS['user']->uid)):?>
        <div class="quicklookwishlist">
          <div id="js_addToWishlist_div">
            <a href="javascript:void(0);" class="addToWishlist inactiveAddToWishlist" id="js_addToWishlist"><span><?php t('Add to Wishlist'); ?></span></a>
          </div>
        </div>
      <?php endif;?>
      </li>
      <li class="image mainImage pdpMainImage thumb" style="display: block;">
        <div class="pdpAlternateImage">
          <div id="js_eCommerceProductAddImage">
            <div id="js_altImageThumbnails" class="bxslider mCustomScrollbar _mCS_1" style="height:630px">
              <div id="mCSB_1" class="mCustomScrollBox mCS-dark-3 mCSB_vertical mCSB_inside" style="max-height: none;" tabindex="0">
                <div id="mCSB_1_container" class="mCSB_container" style="position: relative; top: 0px; left: 0px;" dir="ltr">
                  <div id="addImageLink_li"><a href="javascript:void(0);" style="border:1px solid #eee;" id="mainAddImageLink" onclick="javascript:replaceDetailImage('<?php echo drubiz_image($product->pdp_regular_image) ?>','<?php echo drubiz_image($product->pdp_large_image) ?>');"><img src="<?php echo drubiz_image($product->pdp_thumbnail_image) ?>" id="mainAddImage" name="mainAddImage" vspace="5" hspace="5" alt="" class="productAdditionalImage mCS_img_loaded" height="102" width="88" onerror="onImgError(this, 'PDP-Alt');"></a></div>
                  <?php foreach (range(1, 10) as $img_n): $img_prefix = "pdp_alt_{$img_n}"; if (empty($product->{$img_prefix . '_regular_image'})) continue; ?>
                  <div id="addImage<?php echo $img_n ?>Link_li"><a href="javascript:void(0);" style="border:1px solid #eee;" id="addImage<?php echo $img_n ?>Link" onclick="javascript:replaceDetailImage('<?php echo drubiz_image($product->{$img_prefix . '_regular_image'}) ?>','<?php echo drubiz_image($product->{$img_prefix . '_large_image'}) ?>');"><img src="<?php echo drubiz_image($product->{$img_prefix . '_thumbnail_image'}) ?>" name="addImage1" id="addImage1" vspace="5" hspace="5" alt="" class="productAdditionalImage mCS_img_loaded" height="102" width="88" onerror="onImgError(this, 'PDP-Alt');"></a></div>
                  <?php endforeach; ?>
                </div>
                <div id="mCSB_1_scrollbar_vertical" class="mCSB_scrollTools mCSB_1_scrollbar mCS-dark-3 mCSB_scrollTools_vertical" style="display: block;">
                  <div class="mCSB_draggerContainer">
                    <div id="mCSB_1_dragger_vertical" class="mCSB_dragger" style="position: absolute; min-height: 30px; display: block; height: 580px; max-height: 620px; top: 0px;" oncontextmenu="return false;">
                      <div class="mCSB_dragger_bar" style="line-height: 30px;"></div>
                    </div>
                    <div class="mCSB_draggerRail"></div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </li>
    </ul>
  </div>
  <div class="PDP group group2">
    <ul class="displayList pdpList PDP">
      <li class="string productName pdpProductName" id="<?php echo $product->product_id ?>">
        <div>
          <h3>    
            <?php echo $node->title ?>
          </h3>
        </div>
      </li>
      <li class="priselist">
        <table>
          <tbody>
            <tr>
              <td>
                <?php if ($product->list_price != $product->sales_price): ?>
                  <li class="currency priceList pdpPriceList">
                    <div id="js_pdpPriceList">
                      <p class="oldprice">
                        <span class="price">
                          <span>$ <?php echo format_money($product->list_price) ?></span>
                        </span>
                      </p>
                    </div>
                  </li>
                <?php endif; ?>
              </td>
              <td>
                <li class="currency priceOnline pdpPriceOnline">
                  <div class="pdpPriceOnline" id="js_pdpPriceOnline">
                    <span class="bold">$ <?php echo format_money($product->sales_price) ?></span>
                  </div>
                </li>
               </td>
            </tr>
            <tr>
              <td>
                <?php if (!empty($product->promotion_label)): ?>
                  <div class="promotion-label pdp-promotion-label">
                    <span><?php echo $product->promotion_label ?></span>
                  </div>
                <?php else: ?>
                  <?php if ($product->list_price != $product->sales_price): ?>
                    <div class="promotion-label pdp-promotion-label">
                      <span><?php echo 100 - round($product->sales_price * 100 / $product->list_price) ?>% Off</span>
                    </div>
                  <?php else: ?>
                    <div>
                      &nbsp;
                    </div>
                  <?php endif; ?>
                <?php endif; ?>
              </td>
            </tr>
          </tbody>
        </table>
      </li>
      <?php foreach ($facet_values as $facet_name => $this_facet_values): ?>
      <li class="string selectableFeature pdpSelectableFeature">
        <div class="pdpSelectableFeature">
          <div class="selectableFeatures <?php echo strtoupper($facet_name) ?>">
            <div id="size-wrapper">
              <div class="forgot-area">
                <ul class="js_selectableFeature_1">
                  <?php foreach ($this_facet_values as $this_facet_value => $this_facet_product_id): ?>
                  <li class="<?php echo $this_facet_value ?>">
                    <?php foreach ($out_of_stock as $prodIds => $prodId) :?>
                    <?php if(($prodIds == $this_facet_product_id) && ($prodId->availableQuantity != 0 )){?>
                    <a class="product-choose-facet" href="#" data-product-id="<?php echo $this_facet_product_id ?>"><?php echo $this_facet_value ?></a>
                    <?php } ?>
                    <?php endforeach; ?>
                  </li>
                  <?php endforeach; ?>
                </ul>
              </div>
              <div class="sizehide"><a id="size_guide_fancybox" onclick="sizeGuidePopUp('<?php echo drubiz_image('products/sizeGuide/'. $category_name .'.PNG') ?>')"><img src="<?php echo drubiz_image('products/sizeGuide/size-chart-img.png') ?>" alt="size-chart" style="width:21px;height:15px;border:0"><b><?php echo t('(view size chart)'); ?></b></a></div>
            </div>
          </div>
        </div>
      </li>
      <?php endforeach; ?>
      <li class="entry qty pdpQty">
        <div id="js_quantity_div">
          <label><?php echo t('Quantity:'); ?></label>
          <select id="js_quantity1" name="quantity" style="width: 45px;">
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5">5</option>
            <option value="6">6</option>
            <option value="7">7</option>
            <option value="8">8</option>
            <option value="9">9</option>
            <option value="10">10</option>
          </select>
        </div>
      </li>
      <li class="entry qty pdpQty pdp_buynow">
        <input type="hidden" name="add_category_id" id="add_category_id" value="">
        <div>
          <div class="buynow"><a href="#" id="<?php if($out_of_stock_info->availableQuantity <= 0){ echo 'out_of_stock';}else{ echo 'js_addToCart_buynow';} ?>"><span class="button red auto"><?php echo t('Buy Now');?></span></a></div>
          <div class="addtobag"> <a href="#" id="<?php if($out_of_stock_info->availableQuantity <= 0){ echo 'out_of_stock_pdp';}else{ echo 'js_addToCart';} ?>"><span class="button red auto"><?php echo t('ADD TO BAG');?></span></a></div>
        </div>
      </li>
      <p></p>
      <p></p>
      <li class="content content01 pdpContent01">
        <div id="pdpContent01" class="pdpContent">
        </div>
      </li>
      <div class="pdpLongDescription" id="js_pdpLongDescription">
        <div class="displayBox">
          <h3><?php echo t('Product Description');?></h3>
          <p><?php echo $body[0]['safe_value'] ?></p>
        </div>
      </div>
      <li class="string specialInstructions pdpSpecialInstructions">
        <p id="specialInstructions" style="display:none">Color:Blue-Fabric:Cotton-Fit:Regular Fit</p>
        <h3><?php echo t('Features'); ?></h3>
        <div id="dynamictable">
          <table>
            <tbody>
              <?php foreach ($selected_features as $facet_name => $facet_value): ?>
              <tr>
                <td><?php echo $facet_name ?></td>
                <td><?php echo $facet_value ?></td>
              </tr>
              <?php endforeach; ?>
            </tbody>
          </table>
        </div>
      </li>
      <li class="write-rivew" id=""><span>
        <span id="reviewSpanId" style="display:none;"></span>
          <?php if(!empty($GLOBALS['user']->uid)): ?>
            <a href="#submitPageReview" onclick="return writeAReview(event);"><?php echo t('Write Review');?></a>
          <?php endif;?>
        </span>
      </li>
      <li class="content content05 pdpContent05">
        <div id="pdpContent05" class="pdpContent">
          <div class="wishList_social_share">
            <span>
            <span><a class="fb_share" target="_blank" href="#" rel="me"></a></span>
            <span><a class="tw_share" target="_blank" href="#" rel="nofollow"></a></span>
            <span><a class="pinit_share pin-it-button" target="_blank" href="#" count-layout="horizontal"></a></span>
            <span><a class="google_share" target="_blank" href="#"></a></span>
            <span><a class="mailFriend" href="#"></a></span>
            <span><a class="instagram" href="#" target="_blank"></a></span>
            </span>
          </div>
        </div>
      </li>
    </ul>
  </div>
  <div class="PDP group group4">
  </div>
  <div class="PDP group group5">
    <?php if($product->product_id == "500020"){?>
    <div class="videoPlayed">
      <h2>Fashion video</h2>
      <video width="400" controls>
        <source src="<?php echo current_theme_path() . '/images/ZARA.mp4';?>" type="video/mp4">
        <source src="mov_bbb.ogg" type="video/ogg">
        Your browser does not support HTML5 video.
      </video>
    </div>
    <?php } ?>
    <?php if(!empty($GLOBALS['user']->uid)):?>
    <ul class="displayList pdpList PDP">
      <li class="action reviewWrite pdpReviewWrite  noReviews">
        <div class="pdpReviewWrite" id="pdpReviewWrite">
          <div class="customerRatingLinks">
            <div title="Be the first to write a review" id="submitPageReview"><span><?php echo t('Be the first to write a review');?></span></div>
          </div>
        </div>
      </li>
      <div id="reviewtoggle"><span id="Arrow"></span><?php echo t('Reviews');?></div>
      <div id="writereviewtoggle" style="display: none;">
        <div method="post" class="entryForm" id="productReviewForm" name="productReviewForm">
          <div class="writeReview">
            <div class="container product writeReviewProduct" style="display:none;">
              <div class="displayBox">
                <h1>Write a Review</h1>
              </div>
            </div>
            <div class="container detail writeReviewDetail">
              <div class="displayBox">
                <h3><?php echo t('Share your opinion with others and write a detailed review') ;?></h3>
                <div class="WriteReviewDetail group group3">
                  <?php print render($content['comments']); ?>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <script>
        var status=true;
        var writereviewcontent;
        jQuery("#reviewtoggle").click(function(){
         writeAReview();
         jQuery("#targethk").slideToggle('slow', function(){
           var status= jQuery("#targethk").is(":visible");   
           if(status==true){
             jQuery('#Arrow').addClass('reviewtoggele_on');
             jQuery('#Arrow').removeClass('reviewtoggele_off');
           }
           if(status==false){
             jQuery('#Arrow').addClass('reviewtoggele_off');
             jQuery('#Arrow').removeClass('reviewtoggele_on');
           }
         })
        });
        jQuery(document).ready(function(){
          writereviewcontent=jQuery(".WriteReviewDetail.group.group3").html();
          if( jQuery('#targethk').length )         
          {
            document.getElementById("targethk").style.display="none";
          }
        });     
      </script>
    </ul>
   <?php endif;?>
  </div>
  <div class="PDP group group6">
    <div class="content-messages eCommerceSuccessMessage" id="subitReviewStatusId" style="display:none;">
      <div class="eventImage"></div>
      <p class="eventMessage"> Thank you for submitting your review </p>
    </div>
    <?php if($product->product_id == "500020"){?>
    <div class="PDP group group7">
      <ul class="displayList pdpList PDP">
        <?php if(!empty($related_product_system_data)) {?>
        <div id="jcarouselmainpage" class="mtm120">
          <div class="title-container1">
            <div class="header-title">
              You May Also Like
            </div>
          </div>
          <ul id='mycarousel20' class='jcarousel-skin-tango'>
            <?php foreach ($related_product_system_data as $related_key => $related_value) {?>
            <li>
              <div class="homeGalleryRow" style="width:100%;" id="page-wrap">
                <ul class="displayList productItemList PLP">
                  <li>
                    <a href="void(0); " onclick="#" class="icon-heart">
                    </a>
                    <div class="product-sty">
                      <a id="110100001" class="pdpUrl" href="<?php echo url('node/' . get_nid_from_product_id($related_value->product_id));?>">
                      <img class="productThumbnailImage" width="170" height="140" src="<?php echo drubiz_image($related_value->pdp_regular_image);?>" title="<?php echo $related_value->product_name; ?>" alt="<?php echo $related_value->product_name; ?>">
                      </a>
                    </div>
                    <div>
                      <a id="detailLink_110100001" class="eCommerceProductLink pdpUrl" href="<?php echo url('node/' . get_nid_from_product_id($related_value->product_id));?>">
                      <span class="product-titles">
                      <?php echo $related_value->product_name; ?>
                      </span>
                      </a>
                    </div>
                  </li>
                  <li class="currency priceOnline plpPriceOnline">
                    <div class="SpOnlinePrice">
                      <span class="homeProductTitle1">
                      <strong class="font-styl1">$<?php echo format_money($related_value->sales_price);?>
                      </strong>
                      </span>
                    </div>
                  </li>
                </ul>
              </div>
            </li>
            <?php } ?> 
          </ul>
        </div>
        <?php } ?>
      </ul>
    </div>
    <?php } ?>
    <ul class="displayList pdpList PDP">
      <li class="string additional pdpAdditional">
        <div style="display:none">
          <div class="pdpAdditional">
            ="
            <div class="sizeChart" id="sizechart_Container">
              <h3></h3>
              <img class="sizeguideimg" src="<?php echo drubiz_image('products/sizeGuide/size-chart-polo-t-shirt.PNG') ?>" alt="Mountain VIEW">
              <table>
                <thead></thead>
              </table>
            </div>
            "     
          </div>
        </div>
      </li>
    </ul>
  </div>
  <div id="js_mainImageDiv" style="display:none">
    <a href="">
    <img src="" name="mainImage" class="js_productLargeImage" width="100%" onerror="onImgError(this, 'PDP-Large');">
    </a>
  </div>
</div>


<!-- For upsell and cross sell property -->

    <?php 
      $similar_product = get_all_similar_product($node->nid);
      $heading = "";
      if(count($similar_product) > 0){ 
        $heading = "Similar Products";
        foreach ($similar_product as $pkey => $pvalue) {
          $related_node = node_load(get_nid_from_product_id($pvalue));
          $related_system_data = json_decode($related_node->field_system_data[LANGUAGE_NONE][0]['value']);
          $similar_product_system_data[] = $related_system_data->product_raw; 
        }
      }

   ?>
   <div class="footerWraper"><h1><?php echo $heading; ?></h1>
    <div class="secure_shipping responsceFooter">

     <?php 
        if(count($similar_product_system_data)>0){
        for($i=0;$i<4;$i++){ 
          $eid = get_node_id_from_pid($similar_product_system_data[$i]->product_id);
      ?>
      <div class="secure_wrap">
        <div class="ship_title footerSecMainDiv" id="footerSecMainDiv1"><?php echo $similar_product_system_data[$i]->product_name; ?>          <span id="plusIcon1" class="shpcatgryplus_on1" style="display:none;"></span>
        </div>
        <div class="shipDiv" id="footerSecDiv1" style="display: block;">
         <div class="js_swatchProduct">
          <a class="pdpUrl" title="<?php echo $similar_product_system_data[$i]->product_name; ?> " href="<?php echo url()."node/". $eid;?>" id="<?php echo $similar_product_system_data[0]->product_id;?>">
          <img alt="<?php echo $similar_product_system_data[$i]->product_name; ?> " title="<?php echo $similar_product_system_data[$i]->product_name; ?> " src="<?php  echo  drubiz_image( $similar_product_system_data[$i]->plp_image);?>" class="productThumbnailImage" height="187" width="140" onmouseover="src='<?php  echo drubiz_image( $similar_product_system_data[$i]->plp_image_alt);?>'; jQuery(this).error(function(){onImgError(this, 'PLP-Thumb');});" onmouseout="src='<?php  echo  drubiz_image($similar_product_system_data[$i]->plp_image_alt);?>'; jQuery(this).error(function(){onImgError(this, 'PLP-Thumb');});" onerror="onImgError(this, 'PLP-Thumb');">
          </a>
        </div>
        </div>
      </div>
    <?php  } }?>
    </div>
  </div>
