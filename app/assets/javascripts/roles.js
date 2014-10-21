$(document).ready(function () {
  $(".status input[type=hidden]").val('1');
    $(".status_active").click(function(){
      var parent = $(this).parents('.switch');
      $('.status',parent).removeClass('selected');
      $(this).addClass('selected');
      $(".checkbox").attr('checked', true)
      $('#ibeacon_is_active',parent).attr('checked', true);
      $('#ibeacon_is_active',parent).attr('value', '1');
      $(".status input[type=hidden]").val('1');
    });
    $(".status").click(function(){
      var parent = $(this).parents('.switch');
      $('.status_active',parent).removeClass('selected');
      $(this).addClass('selected');
      $('.checkbox').removeAttr('checked')
      $('#ibeacon_is_active',parent).attr('checked', false);
      $('#ibeacon_is_active',parent).attr('value', '0');
      $(".status input[type=hidden]").val('0');
    });
});
function validate_role_form(){
    var chkbox1 = $('#role_access_module_ids_1').parent().attr('class');
    var chkbox2 = $('#role_access_module_ids_2').parent().attr('class');
    var chkbox3 = $('#role_access_module_ids_3').parent().attr('class');
    var name = $('#role_name').val();
    if(name=='' && chkbox1 !='checked' && chkbox2 !='checked' && chkbox3 !='checked' ){
        $("#name_error").css("display","inline").fadeOut(6000);
        $("#error").css("display","inline").fadeOut(6000);
        return false;
    }
     if(name==''){
         $("#name_error").css("display","inline").fadeOut(6000);
         return false;
     }
     if(chkbox1 !='checked' && chkbox2 !='checked' && chkbox3 !='checked'){
         $("#error").css("display","inline").fadeOut(6000);
         return false;
     }

    return true;
}