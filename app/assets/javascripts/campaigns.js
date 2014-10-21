function frm_validate_campaign() {
  $("#frm_save_campaign").validate({
    rules: {
      "campaign[title]":{
        required: true
      },
      "campaign[description]":{
        required: true
      },
      "campaign[store_id]":{
        required: true
      },
      "campaign[ibeacon_id]":{
        required: true
      },
      "campaign[category_id]":{
        required: true
      },
      "campaign[beacon_range_ids][]":{
        required: true
      },
      "#location2":{
        required: true
      }
      },
      messages: {
        "campaign[title]":{
          required: "Please enter Title"
        },
        "campaign[description]":{
          required: "Please enter Description"
        },
        "campaign[store_id]":{
          required: "Please enter Store"
        },
        "campaign[ibeacon_id]":{
          required: "Please enter Beacon"
        },
        "campaign[category_id]":{
          required: "Please enter Category"
        },
        "campaign[beacon_range_ids][]":{
          required: "Select Range"
        },
        "#add_btn":{
          required: "Select Location"
        }
      }
  });
  if ($('#datetimepicker').css('display') == 'block'){
      var dt_frm = $('#schedule_from').val()
      var dt_to = $('#schedule_to').val()
      if (dt_frm == '' && dt_to == '' ){
        return true;
      }
      else
      {
        if (dt_frm == '' || dt_to == '' ){
          $("span").css("display","inline").fadeOut(6000);
          if(dt_frm==''){
            $('#schedule_from').focus()
          }
          else{
            $('#schedule_to').focus()
          }
          return false;
        }
        if (dt_frm >= dt_to){
          $("span").css("display","inline").fadeOut(6000);
          $('#schedule_to').focus()
          return false;
        }
      }
      return true;
  }
  return true;
}


function frm_validate_campaign() {
  $("#frm_save_campaign").validate({
    rules: {
      "campaign[title]":{
        required: true
      },
      "campaign[description]":{
        required: true
      },
      "campaign[store_id]":{
        required: true
      },
      "campaign[ibeacon_id]":{
        required: true
      },
      "campaign[category_id]":{
        required: true
      },
      "campaign[beacon_range_ids][]":{
        required: true
      },
      "#location2":{
        required: true
      }
    },
    messages: {
      "campaign[title]":{
        required: "Please enter Title"
      },
      "campaign[description]":{
        required: "Please enter Description"
      },
      "campaign[store_id]":{
        required: "Please enter Store"
      },
      "campaign[ibeacon_id]":{
        required: "Please enter Beacon"
      },
      "campaign[category_id]":{
        required: "Please enter Category"
      },
      "campaign[beacon_range_ids][]":{
        required: "Select Range"
      },
      "#add_btn":{
        required: "Select Location"
      }
    }
  });
  if ($('#datetimepicker').css('display') == 'block'){
    var dt_frm = $('#schedule_from').val()
    var dt_to = $('#schedule_to').val()
    if (dt_frm == '' && dt_to == '' ){
      return true;
    }
    else
    {
      if (dt_frm == '' || dt_to == '' ){
        $("span").css("display","inline").fadeOut(6000);
        if(dt_frm==''){
          $('#schedule_from').focus()
        }
        else{
          $('#schedule_to').focus()
        }
        return false;
      }
      if (dt_frm >= dt_to){
        $("span").css("display","inline").fadeOut(6000);
        $('#schedule_to').focus()
        return false;
      }
    }
    return true;
  }
  return true;
}