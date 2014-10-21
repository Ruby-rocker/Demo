// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//

 //= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery.ui.all
//= require turbolinks
//= require fancybox

//= require jquery.mCustomScrollbar.concat.min
//= require myfunction

//= require popupwindow
//= require powerwidgets
//= require tab
//= require jquery.uniform.min
//= require jquery.uniform

//= require template_masters
//= require locations
//= require stores
//= require roles
//= require highcharts
//= require highcharts/highcharts-more

//= require categories
//= require campaigns
//= require ibeacons

//= require jquery.validate
//= require jquery.datetimepicker



function load_ajax(url_path, html_id){
  $.ajax({
    type: 'GET',
    url: url_path,
    success: function (data) {
      $('#'+html_id).html(data);
    }
  }); // end of inner ajax
}

function getStores(location_id, get_page, ibeacon_id){
  if(typeof(ibeacon_id)==='undefined') ibeacon_id = 0;
  if(location_id){
    load_ajax('/'+get_page+'?location_id='+location_id+'&id='+ibeacon_id, 'stores')
  }
}

function get_states(country_id){
  if(country_id){
    load_ajax('/get_states?country_id='+country_id, 'states')
  }
}

function getBeacons(store_id, div_id, destination_page){
  if(store_id){
    load_ajax('/get_beacons?store_id='+store_id+'&destination_page='+destination_page, div_id) //'div_beacons'
  }
}

function getCampaigns(beacon_id){
  if(beacon_id){
    load_ajax('/get_campaigns?beacon_id='+beacon_id, 'div_campaigns')
  }
}

function showRules(campaign_id){
  if(campaign_id){
    load_ajax('/get_rules?campaign_id='+campaign_id, 'div_show_rules')
  }
}

function chk_frm_campaign_rule(){
  if($('#store').val()==''){alert('Select store'); return false;}
  if($('#beacon_id').val()==''){alert('Select beacon'); return false;}
  if($('#campaign_id').val()==''){alert('Select campaign'); return false;}
  if($('#second_welcome_min').val()=='' && $('#second_welcome_hour').val()=='' && $('#message_delay_second').val()=='' && $('#message_delay_min').val()=='' && $('#message_delay_hour').val()=='' && $('#campaign_limit_message').val()=='' && $('#campaign_limit_second').val()=='' && $('#campaign_limit_min').val()=='' && $('#campaign_limit_hour').val()=='' && $('#campaign_limit_days').val()=='' && $('#deactivate_campaign').val()==''){alert('Select at least one rule'); return false;}
  return true;
}

function returnValue(objectId){
  return($('#'+objectId).val())
}

$(document).ready(function() {
  $("a.fancybox").fancybox({
    parent: "body"
  });

  $('#schedule_from, #schedule_to').datetimepicker({
    formatTime:'H:i',
    formatDate:'d.m.Y',
    defaultDate:'8.12.1986', // it's my birthday
    defaultTime:'10:00'
  });

    // not allowed space in beginning of input
    $(function() {
        var inputs = document.getElementsByTagName('input');
        $('body').on('keydown', inputs, function(e) {
            console.log(this.value);
            if (e.which === 32 &&  e.target.selectionStart === 0) {
                return false;
            }
        });
    });
});

