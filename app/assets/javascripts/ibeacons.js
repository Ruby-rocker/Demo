function frm_validate_ibeacon() {
    $("#frm_save_ibeacon").validate({
        rules: {
            "ibeacon[name]":{
                required: true
            },
            "location1":{
                required: true
            },
            "ibeacon[store_id]":{
                required: true
            },
            "ibeacon[broadcast_id]":{
                required: true
            },
            "ibeacon[uuid]":{
                required: true
            },
            "ibeacon[major_id]":{
                required: true
            },
            "ibeacon[minor_id]":{
                required: true
            }
        },
        messages: {
            "ibeacon[name]":{
                required: "Please enter Name"
            },
            "location1":{
                required: "Please select location"
            },
            "ibeacon[store_id]":{
                required: "Please enter Store"
            },
            "ibeacon[broadcast_id]":{
                required: "Please enter Broadcast Id"
            },
            "ibeacon[uuid]":{
                required: "Please enter UUID"
            },
            "ibeacon[major_id]":{
                required: "Please enter Major"
            },
            "ibeacon[minor_id]":{
                required: "Please enter Minor"
            }
        }
    });
}