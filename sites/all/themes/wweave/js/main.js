$( document ).ready(function() {
    
    setTimeout(function(){ 
        $('#StickyNav').hide();
  }, 3000);
$('#adds').click(function add() {
    var $rooms = $("#quantity-cont");
    var a = $rooms.val();
    
    a++;
    $("#subs").prop("disabled", !a);
    $rooms.val(a);
});
$("#subs").prop("disabled", !$("#quantity-cont").val());

$('#subs').click(function subst() {
    var $rooms = $("#quantity-cont");
    var b = $rooms.val();
    if (b >= 1) {
        b--;
        $rooms.val(b);
    }
    else {
        $("#subs").prop("disabled", true);
    }
});
// sticky header

$(window).scroll(function() {
    $('#StickyNav').show();
    var scroll = $(window).scrollTop();
    if (scroll > $("header").height()) {
        $('#StickyNav').show().addClass("sticky-header");
        $(".brand").hide();
        $(".navbar-brand").show()
    } else {
        $('#StickyNav').hide();
        $('#StickyNav').show().removeClass("sticky-header");
    }
});
$(document).on("click",'#StickyNav .mini-cart-link',function(e){
    e.preventDefault();
    location.href = $(this).attr("href");
});

    // payment options on check show/hide

    //  $('#crdtcard').click(function(){
    //      this.checked?$('#crdtcardshow').show(1000):$('#crdtcardshow').hide(1000);
    //  });

        $(function () {
        $("#crdtcard").click(function () {
            if ($(this).is(":checked")) {
                $("#crdtcardshow").toggle(1000);
            
            } 
            // else {
            //     ($(this).is(":unchecked")); {
            //     $("#crdtcardshow").hide(1000);
            //     }
                
            // }
        });
    });

});
