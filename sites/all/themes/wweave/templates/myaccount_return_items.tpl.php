<?php //krumo($returnOrders);?>
<?php //krumo($items_details);?>
<div class="col-sm-9 SalesReturnParent">
   <div class="row SalesReturnTitleRow mr0">
      <div class="text-left">
         <h2 class="paratitle title">Sales Return</h2>
         <!--<hr class="spacer-5 headerborder">-->
      </div>
   </div>
   <!-- end row -->
   <div class="row SalesReturnDetailsRow mr0">
      <!--<hr class="spacer-5 no-border">-->
      <div class="col-xs-12 col-sm-3 col-md-3 nopad">
         <div>
            <label class=""><b>OrderId:</b></label>
			<?php //echo "<pre>";print_r($returnOrders);?>
            <div id="returnId" value="<?php echo($items_details[0]['OrderItem']['orderId']);?>">
               <?php echo($returnOrders['orderHeader']['orderId']);?>
            </div>
         </div>
      </div>
      <!-- end col -->
      <div class="col-xs-12 col-sm-3 col-md-3 nopad">
         <div>
            <label class="">
               <b>Order Date:</b></h6>
               <div><?php echo date('Y/m/d H:i:s', strtotime($items_details['orderDetailsForReturn']['orderHeader']['orderDate']));?>
               </div>
         </div>
      </div>
      <!-- end col -->
      <div class="col-xs-12 co-sm-3 col-md-3 nopad">
      <div>
      <label class=""><b>Shipping Address:</b></label>
      <div><?php echo($returnOrders['orderPlacedAddress']['toName']);?>,
      <?php echo($returnOrders['orderPlacedAddress']['address1']);?>,
      <?php echo($returnOrders['orderPlacedAddress']['city']);?>,
      <?php echo($returnOrders['orderPlacedAddress']['postalCode']);?>
      </div>
      </div>
      </div>
      <!-- end col -->
      <!--<div class="col-xs-12 col-sm-3 col-md-3 nopad">
         <div>
            <span class="mr-5">Select All</span><input type="checkbox" id="selectAllProd"/>
         </div>
      </div>-->
      <!-- end col -->
   </div>
   <!-- end row -->
   <?php if(count($returnOrders['returnableOrderItems']) == 0) {?>
   <div>
      <div class="row SalesReturnTableRow mr0">
         <div class="table-responsive mt20">
            <table class="table table-striped">
               <thead class="b2btablehead">
                  <tr>
                     <th>Product</th>
                     <th>Description</th>
                     <th>Quantity</th>
                     <th>Price</th>
                     <th>Item Status</th>
                     <th>&nbsp;</th>
                  </tr>
               </thead>
			   <?php foreach($returnOrders['returnedOrders'] as $returnedOrderItems): ?>
               <tbody>

  <?php
    $nid = get_nid_from_variant_product_id($returnedOrderItems['productId']);
    $node = node_load($nid);
    $system_data = json_decode($node->field_system_data[LANGUAGE_NONE][0]['value']);
    $product_variant = $system_data->product_variants->{$returnedOrderItems['productId']};
  ?>
                  <tr>
                     <td><a href="<?php echo url('node/'.$nid);?>">
                <img class="order-img" src="<?php echo drubiz_image($product_variant->plp_image) ?>" height="140" width="105" onerror="onImgError(this, 'PLP-Thumb');">
             </a></td>
                     <td>
                        <span><?php echo($returnedOrderItems['productId']);?>&nbsp;<?php echo($returnedOrderItems['itemDescription']);?></span>
                     </td>
                     <td>
                        <span><?php echo($returnedOrderItems['quantity']);?></span>
                     </td>
                     <td>
                        <span>$<?php echo($returnedOrderItems['unitPrice']);?></span>
                     </td>
                     <td> 
                        <span><?php echo($returnedOrderItems['statusId']);?></span>
                     </td>
                     <td>
                        <span><?php echo("This product has been returned"); ?></span>
                     </td>
                  </tr>
               </tbody>
			   <?php endforeach; ?>
            </table>
         </div>
      </div>
   </div>
   <?php } ?>
   <div>
      <?php if(count($returnOrders['returnableOrderItems']) != null) {?>
      <div class="row SalesReturnTableRow mr0">
         <div class="table-responsive mt20">
            <table class="table table-striped">
               <thead class="b2btablehead">
                  <tr>
					 <th>Select</th>
                     <th>Product</th>
                     <th>Description</th>
                     <th>Quantity</th>
                     <th>Price</th>
                     <th>Item Status</th>
					 <th>Reason</th>
                     <th><span class="mr-5">Return type</span><!--<input type="checkbox" id="selectAllProd"/>--></th>
                  </tr>
               </thead>
			   <?php 
            // echo "<pre>";print_r($returnOrders['returnableOrderItems']);
            foreach($returnOrders['returnableOrderItems'] as $returnOrderItem): 
            // echo "<pre>";print_r($returnOrderItem);
            ?>
               <tbody>
                  <?php 
    $nid = get_nid_from_variant_product_id($returnOrderItem['orderItem']['productId']);
    $node = node_load($nid);
    $system_data = json_decode($node->field_system_data[LANGUAGE_NONE][0]['value']);
    // echo "<pre>";print_r($system_data);
    $product_variant = $system_data->product_variants->{$returnOrderItem['orderItem']['productId']};
  ?>
                  <tr>
					<td>
					<span id="returnLabel_<?php echo($returnOrderItem['orderItem']['productId']);?>"></span>
                        <input type="checkbox" class="returnProd" id="checkboxSeqId_<?php echo($returnOrderItem['orderItem']['productId']);?>" data_productId="<?php echo($returnOrderItem['orderItem']['productId']);?>" value="<?php echo($returnOrderItem['orderItem']['orderItemSeqId']);?>" data_qty="<?php echo($returnOrderItem['orderItem']['quantity']);?>" onclick="returnOrderItems(<?php echo "'".$returnOrderItem['orderItem']['productId']."'"; ?> )" />
					</td>
                     <td><a href="<?php echo url('node/'.$nid);?>">
                <img class="order-img" src="<?php echo drubiz_image($product_variant->plp_image) ?>" height="140" width="105" onerror="onImgError(this, 'PLP-Thumb');">
             </a></td>
                     <td>
                        <span><?php echo($returnOrderItem['z']['productId']);?> &nbsp;
                        <?php echo($returnOrderItem['orderItem']['itemDescription']);?></span>
                     </td>
                     <td>
                        <div id="quantity_<?php echo($returnOrderItem['orderItem']['productId']);?>" class="returnOrdrdata" data_id="<?php echo($returnOrderItem['orderItem']['productId']);?>"
                           value="<?php echo($returnOrderItem['orderItem']['quantity']);?>" ><?php echo($returnOrderItem['orderItem']['quantity']);?>
                        </div>
                     </td>
                     <td>
                        <span>$<?php echo($returnOrderItem['orderItem']['unitPrice']);?></span>
                     </td>
                     <td>
                        <span><?php echo($returnOrderItem['orderItem']['statusId']);?></span>
                     </td>
					 <td>
						<select id="reasonId_<?php echo($returnOrderItem['orderItem']['productId']);?>" class="mr-5" class="returnOrderdata">
						 <option value="RTN_NOT_WANT">Did Not Want Item</option>
						 <option value="RTN_DEFECTIVE_ITEM">Defective Item</option>
						 <option value="RTN_MISSHIP_ITEM">Mis-Shipped Item</option>
						 <option value="RTN_DIG_FILL_FAIL">Digital Fulfillment Failed</option>
						 <option value="RTN_COD_REJECT">COD Payment Rejected</option>
						 <option value="RTN_SIZE_EXCHANGE">Size Exchange</option>
						 <option value="RTN_NORMAL_RETURN">Normal Return</option>
					    </select>
					 </td>
                     <td>
                        <!--<div><input type="checkbox" class="btn btn-default" value="include" onclick="returnOrderItems(<?php echo "'".$returnOrderItem['OrderItem']['productId']."'"; ?> )"/>
                        </div>-->
						
						<div class="col-xs-12 col-sm-4 col-md-4">
						  <select id="selectReturnTypeId_<?php echo($returnOrderItem['orderItem']['productId']);?>" class="mr-5" class="returnOrderdata">
							 <option value="RTN_CREDIT">Store Credit</option>
							 <option value="RTN_REFUND">Refund</option>
						  </select>
					   </div>
                     </td>
                  </tr>
               </tbody>
			   <?php endforeach; ?> 
               <tfoot>
                  <tr>
                     <td colspan="7">
                        <div>
                           <!--<div class="col-xs-12 co-sm-4 col-md-3 nopad">
                              <label id="returnReasonId_<?php echo($returnOrderItem['OrderItem']['productId']);?>" class="b2btext mr-5" style="display:none;"><b>Reason</b></label>
                              <select id="reasonId_<?php echo($returnOrderItem['OrderItem']['productId']);?>" class="mr-5" style="display:none;" class="returnOrderdata">
                                 <option value="RTN_NOT_WANT">Did Not Want Item</option>
                                 <option value="RTN_DEFECTIVE_ITEM">Defective Item</option>
                                 <option value="RTN_MISSHIP_ITEM">Mis-Shipped Item</option>
                                 <option value="RTN_DIG_FILL_FAIL">Digital Fulfillment Failed</option>
                                 <option value="RTN_COD_REJECT">COD Payment Rejected</option>
                                 <option value="RTN_SIZE_EXCHANGE">Size Exchange</option>
                                 <option value="RTN_NORMAL_RETURN">Normal Return</option>
                              </select>
                           </div>-->
                           <!-- end col -->
                           <!--<div class="col-xs-12 col-sm-4 col-md-4">
                              <label id="returnTypeId_<?php echo($returnOrderItem['OrderItem']['productId']);?>" class="b2btext mr-5" style="display:none;"><b>Account Type</b></label>
                              <select id="selectReturnTypeId_<?php echo($returnOrderItem['OrderItem']['productId']);?>" class="mr-5" style="display:none;" class="returnOrderdata">
                                 <option value="RTN_CREDIT">Store Credit</option>
                                 <option value="RTN_REFUND">Refund</option>
                              </select>
                           </div>-->
                           <!-- end col -->
                           <!--<div class="col-xs-12 col-sm-4 col-md-4">
                              <span id="returnLabel_<?php echo($returnOrderItem['OrderItem']['productId']);?>" style="display:none;"><b>Return This Item?</b></span>
                              <input type="checkbox" class="returnProd" id="checkboxSeqId_<?php echo($returnOrderItem['OrderItem']['productId']);?>" data_productId="<?php echo($returnOrderItem['OrderItem']['productId']);?>" value="<?php echo($returnOrderItem['OrderItem']['orderItemSeqId']);?>" data_qty="<?php echo($returnOrderItem['OrderItem']['quantity']);?>" style="display:none;" />
                           </div>-->
                           <!-- end col -->
                     </td>
                  </tr>
                  <tr>
                     <td colspan="5">
                        <div id='orderAdjustmentId_<?php echo($returnOrderItem['orderItem']['productId']);?>' class= "returnOrderdata" value="<?php echo($returnOrderItem['OrderAdjustment']['orderAdjustmentId']);?>">
                        </div>
                     </td>
                  </tr>
               </tfoot>
            </table>
         </div>
         <!-- end table-responsive -->
      </div>
      <!-- end row -->
      
   </div>
   <?php } ?>
   <div class="row ReturnSelectedItemsRow mr0">
      <!-- <hr class="spacer-10 no-border"> -->
      <?php if($returnOrders['returnableOrderItems']){ ?>
         <div class="pull-right">
             <input type="button" class="btn btn-default" id="returnSelectedItems" value="Return Selected Items"/>
      </div>
      <?php } ?>
   </div>
   <!-- end row -->
   <!--<hr class="spacer-10 no-border">-->
</div>