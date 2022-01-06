<?php

/**
 * @file
 * Default theme implementation for displaying search results.
 *
 * This template collects each invocation of theme_search_result(). This and
 * the child template are dependent to one another sharing the markup for
 * definition lists.
 *
 * Note that modules may implement their own search type and theme function
 * completely bypassing this template.
 *
 * Available variables:
 * - $search_results: All results as it is rendered through
 *   search-result.tpl.php
 * - $module: The machine-readable name of the module (tab) being searched, such
 *   as "node" or "user".
 *
 *
 * @see template_preprocess_search_results()
 *
 * @ingroup themeable
 */
?>
<?php if ($search_results): ?>
  <div id="eCommerceProductListContainer" class="search-results <?php print $module; ?>-results">
    <div id="resultsNavigationTop">
      <div id="sortToglId">
        <div class="resultsNavigation">
          <div class="sortingOptions">
            <form method="get" id="frmSortResults" name="frmSortResults" action="/eCommerceProductList;jsessionid=4B6C672E3176B5E22A7369ABA6F1724B.jvm1">
              <div id="selectResultId">
                <label>Sort By:</label>
                <?php echo theme('drubiz_search_sort') ?>
              </div>
              <div id="filtersChangeId">
                <a href="javascript:void(0)" id="bstSelling" class="bstSelling">Best Selling</a>
                <a href="javascript:void(0)" id="pricefl" class="pricefl-asc">Price:<span id="priceUp" class="priceUp"></span></a>
                <a href="javascript:void(0)" id="disfl" class="dis-asc">Discount<span id="disUp" class="priceUp"></span></a>
                <a href="javascript:void(0)" id="newArrivals" class="newArrivals">New Arrivals</a>
              </div>
              <div id="responsiveslectResults" style="display:none;">
                <ul class="sorting-order">
                  <li><a href="javascript:void(0);" onclick="sortOrder('totalQuantityOrdered-desc'); return false;">Best Selling </a></li>
                  <li><a class="pricedescarrow" href="javascript:void(0);" onclick="sortOrder('price-desc'); return false;">Price High to Low <span class="downarrow"></span></a> </li>
                  <li> <a class="priceascarrow" href="javascript:void(0);" onclick="sortOrder('price-asc'); return false;">Price Low to High  <span class="uparrow"></span></a></li>
                  <li><a class="priceascarrow" href="javascript:void(0);" onclick="sortOrder('introductionDate-desc'); return false;">New Arrivals  </a></li>
                  <li><a href="javascript:void(0);" onclick="sortOrder('highestDiscount-desc'); return false;">Discount High to Low </a></li>
                  <li><a href="javascript:void(0);" onclick="sortOrder('leastDiscount-asc'); return false;">Discount Low to High </a></li>
                </ul>
              </div>
              <input type="hidden" name="productCategoryId" value="520">
            </form>
          </div>
          <div class="pagingLinks">
            <ul class="pageingControls">
            </ul>
          </div>
        </div>
      </div>
    </div>
    </div>
    <div id="eCommerceProductList">
      <div class="boxList productList">
        <?php print $search_results; ?>
      </div>
    </div>
    <div id="tooltip" class="js_tooltip">
      <div id="tooltipTop" class="js_tooltipTop"></div>
      <div class="tooltipMiddle" id=""><span id="tooltipText" class="js_tooltipText"></span></div>
      <div id="tooltipBottom" class="js_tooltipBottom"></div>
    </div>
  </div>
  <?php print $pager; ?>
<?php else : ?>
  <h2><?php print t('Your search yielded no results');?></h2>
  <?php print search_help('search#noresults', drupal_help_arg()); ?>
<?php endif; ?>
