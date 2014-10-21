function frm_validate_store() {
  $("#frm_save_store").validate({
    rules: {
      "store[name]":{
        required: true
      },
      "store[location_id]":{
        required: true
      }
    },
    messages: {
      "store[name]":{
        required: "Please enter name"
      },
      "store[location_id]":{
        required: "Please select location"
      }
    }
  });
}
