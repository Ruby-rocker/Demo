function frm_validate_template() {
    $("#frm_save_template").validate({
        rules: {
            "template_master[name]":{
                required: true
            }
        },
        messages: {
            "template_master[name]":{
                required: "Please enter name"
            }
        }
    });
}