function frm_validate_location() {
  $("#frm_save_location").validate({
    rules: {
      "location[name]":{
        required: true
      },
      "location[zipcode]":{
        required: true
      },
      "location[stores_attributes][0][name]":{
        required: true
      }
    },
    messages: {
      "location[name]":{
        required: "Please enter name"
      },
      "location[zipcode]":{
        required: "Please enter zipcode"
      },
      "location[stores_attributes][0][name]":{
        required: "Please enter store name"
      }
    }
  });
}
