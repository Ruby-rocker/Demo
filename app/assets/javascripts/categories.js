function frm_validate_category() {
  $("#frm_save_category").validate({
    rules: {
      "category[name]":{
        required: true
      }
    },
    messages: {
      "category[name]":{
        required: "Please enter name"
      }
    }
  });
}
