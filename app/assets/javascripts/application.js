// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require conversations
//= require underscore
//= require cable
//= require ckeditor/init
//= require dropzone.min
//= require gmaps/google
//= require bootstrap.min
//= require bootstrap-datepicker
//= require moment
//= require daterangepicker
//= require agency.min
//= require jquery.easing
//= require contact_me
//= require turbolinks
//= require_tree .
$(document).ready(function(){
  $('.datepicker').datepicker({
    format: 'mm-dd-yyyy'
  });

  // Define the disabled date array
  var disabledArr = ["12/04/2017","13/04/2017","12/05/2017"];

  // Function to draw the calendar accounting the disabled dates.
  $('input[class="daterange"]').daterangepicker({
    locale: {
      format: 'DD/MM/YYYY'
    },

    isInvalidDate: function(arg){
      //console.log(arg);

      // Prepare the date comparision
      var thisMonth = arg._d.getMonth()+1;   // Months are 0 based
      if (thisMonth<10){
        thisMonth = "0"+thisMonth; // Leading 0
      }
      var thisDate = arg._d.getDate();
      if (thisDate<10){
        thisDate = "0"+thisDate; // Leading 0
      }
      var thisYear = arg._d.getYear()+1900;   // Years are 1900 based

      var thisCompare = thisDate +"/"+ thisMonth +"/"+ thisYear;
      console.log(thisCompare);

      if($.inArray(thisCompare,disabledArr)!=-1){
        console.log("      ^--------- DATE FOUND HERE");
        return true; //arg._pf = {userInvalidated: true};
      }
    }

  }).focus(); // This focus is to open the calendar on page load.


  // Function to disallow a range selection that includes disabled dates.
  $('input[class="daterange"]').on("apply.daterangepicker",function(e,picker){

    // Get the selected bound dates.
    var startDate = picker.startDate.format('DD/MM/YYYY')
    var endDate = picker.endDate.format('DD/MM/YYYY')
    console.log(startDate+" to "+endDate);

    // Compare the dates again.
    var clearInput = false;
    for(i=0;i<disabledArr.length;i++){
      if(startDate<disabledArr[i] && endDate>disabledArr[i]){
        console.log("Found a disabled Date in selection!");
        clearInput = true;
      }
    }

    // If a disabled date is in between the bounds, clear the range.
    if(clearInput){

      // To clear selected range (on the calendar).
      var today = new Date();
      $(this).data('daterangepicker').setStartDate(today);
      $(this).data('daterangepicker').setEndDate(today);

      // To clear input field and keep calendar opened.
      $(this).val("").focus();
      console.log("Cleared the input field...");

      // Alert user!
      alert("Your range selection includes disabled dates!");
    }
  });
});
