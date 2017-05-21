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
//= require jquery.easing
//= require jquery.raty
//= require conversations
//= require underscore
//= require cable
//= require ckeditor/init
//= require dropzone.min
//= require gmaps/google
//= require bootstrap.min
//= require bootstrap-datepicker/core
//= require moment
//= require daterangepicker
//= require agency.min
//= require contact_me
//= require turbolinks
//= require_tree .

$( document ).on('turbolinks:load', function() {

  // -----Dropzone------
  Dropzone.autoDiscover = false;


  // --------date picker-----
  $('.datepicker').datepicker({
    format: 'mm-dd-yyyy'
  });

  today = moment().format('DD/MM/YYYY')
  // Define the disabled date array
  // if (window.location.pathname.match(/\/rooms\//)) {
  var disabledArr = gon.booked_date
  // }
  // else {
  //   var disabledArr = []
  // }
  for (i in disabledArr) {
    a = today == disabledArr[i]
    if (a) {
      today = (moment(today, 'DD/MM/YYYY').add(1,'days')).format('DD/MM/YYYY')
    }
  }

  // Function to draw the calendar accounting the disabled dates.
  $('input[class="daterange"]').daterangepicker({
    locale: {
      format: 'DD/MM/YYYY',
      cancelLabel: 'Clear'
    },
    minDate: today,
    endDate: today,
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

      if($.inArray(thisCompare,disabledArr)!=-1){
        return true; //arg._pf = {userInvalidated: true};
      }
    }

  })

  // Function to disallow a range selection that includes disabled dates.
  $('input[class="daterange"]').on("apply.daterangepicker",function(e,picker){

    // Get the selected bound dates.
    var startDate = new Date(picker.startDate.format('DD/MM/YYYY').replace(/(\d{2})\/(\d{2})\/(\d{4})/, "$2/$1/$3"))
    var endDate = new Date(picker.endDate.format('DD/MM/YYYY').replace( /(\d{2})\/(\d{2})\/(\d{4})/, "$2/$1/$3"))

    // Compare the dates again.
    var clearInput = false;
    for(i=0;i<disabledArr.length;i++){
      disabledDate = new Date(disabledArr[i].replace( /(\d{2})\/(\d{2})\/(\d{4})/, "$2/$1/$3"))
      if(startDate<disabledDate && endDate>disabledDate){
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

      // Alert user!
      alert("Your range selection includes disabled dates!");
    }
  });
  $('input[class="daterange"]').on('cancel.daterangepicker', function(ev, picker) {
      $(this).val('');
  });

  // link to anchor
  $('a').click(function(){
      $('html, body').animate({
          scrollTop: $( $(this).attr('href') ).offset().top
      }, 500);
      return false;
  });

  // -----Carousel-----
  $('.carousel').carousel({
    interval: 6000
  })
  $('.carousel-control.left').click(function() {
    $('#myCarousel').carousel('prev');
  });

  $('.carousel-control.right').click(function() {
    $('#myCarousel').carousel('next');
  });

});
