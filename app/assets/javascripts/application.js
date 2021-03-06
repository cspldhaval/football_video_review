// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-migrate-1.3.0
//= require aws-sdk-2.6.10.min
//= require ckeditor/init
//= require ckeditor/config
//= require ckeditor/lang/en
//= require ckeditor/lang/en-gb
//= require jquery_nested_form
//= require bootstrap
//= require jasny-bootstrap
// require moment.min
// require bootstrap-datetimepicker
//= require SpryTabbedPanels
// require turbolinks
// require_tree .

$(document).ready(function(){
  $(".alert-danger").fadeOut(12000);
  $(".alert-success").fadeOut(12000);
});