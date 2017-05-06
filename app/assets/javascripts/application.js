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
//= require bootstrap-datepicker
//= require moment
//= require daterangepicker
//= require agency.min
//= require contact_me
//= require turbolinks
//= require_tree .

$( document ).on('turbolinks:load', function() {

  // -----Dropzone------
  Dropzone.autoDiscover = false;

  // grap our upload form by its id
  $("#new_image_room").dropzone({
    init: function() {
      // this.on("sending", function(file, xhr, formData) {
      //   formData.append("image_room[room_id]", $('.room_id').val()); // Append all the additional input data of your form here!
      // });
    },
    renameFilename: function (filename) {
      return new Date().getTime() + '_' + filename;
    },
    // restrict image size to a maximum 1MB
    maxFilesize: 1,
    // changed the passed param to one accepted by
    // our rails app
    paramName: "image_room[image]",
    // show remove links on each image upload
    addRemoveLinks: true,
    // if the upload was successful
    success: function(file, response){
      // find the remove button link of the uploaded file and give it an id
      // based of the fileID response from the server
      $(file.previewTemplate).find('.dz-remove').attr('id', response.fileID);
      // add the dz-success class (the green tick sign)
      $(file.previewElement).addClass("dz-success");
    },
    //when the remove button is clicked
    removedfile: function(file){
      // grap the id of the uploaded file we set earlier
      var id = $(file.previewTemplate).find('.dz-remove').attr('id');

      // make a DELETE ajax request to delete the file
      $.ajax({
        type: 'DELETE',
        url: '/image_rooms/' + id,
        success: function(data){
          alert(data.message);
        }
      });
    }
  });

  $("#edit_image_room").dropzone({
    init: function() {
      this.on("sending", function(file, xhr, formData) {
        formData.append("image_room[room_id]", $('.room_id').val()); // Append all the additional input data of your form here!
      });
      // var mockFile = { name: "banner2.jpg", size: 12345 };
      // this.emit("addedfile", mockFile);
      // this.emit("thumbnail", mockFile, 'http://localhost:3001/system/uploads/images/000/000/058/original/1493720956430_Screenshot_from_2017-05-01_23-43-17.png');
      // this.files.push(mockFile);
      // $(".dz-remove").attr("id", 58);
      thisDropZone = this
      $.getJSON("/rooms/images/" + $('.room_id').val(), function(data) {
       $.each(data, function(index, val) {
           var mockFile = { name: val.image_file_name, size: val.image_file_size };
           thisDropZone.emit("addedfile", mockFile);
           thisDropZone.emit("thumbnail", mockFile, val.url_medium);
           thisDropZone.emit("complete", mockFile);

           $(".dz-remove").eq(index).attr("id", val.id);
        });
    });

    },
    renameFilename: function (filename) {
      return new Date().getTime() + '_' + filename;
    },
    // restrict image size to a maximum 1MB
    maxFilesize: 1,
    // changed the passed param to one accepted by
    // our rails app
    paramName: "image_room[image]",
    // show remove links on each image upload
    addRemoveLinks: true,
    // if the upload was successful
    success: function(file, response){
      // find the remove button link of the uploaded file and give it an id
      // based of the fileID response from the server
      $(file.previewTemplate).find('.dz-remove').attr('id', response.fileID);
      // add the dz-success class (the green tick sign)
      $(file.previewElement).addClass("dz-success");
    },
    //when the remove button is clicked
    removedfile: function(file){
      // grap the id of the uploaded file we set earlier
      var id = $(file.previewTemplate).find('.dz-remove').attr('id');

      // make a DELETE ajax request to delete the file
      $.ajax({
        type: 'DELETE',
        url: '/image_rooms/' + id,
        success: function(data){
          alert(data.message);
          location.reload();
        }
      });
    }
  });

  // --------date picker-----
  $('.datepicker').datepicker({
    format: 'mm-dd-yyyy'
  });

  today = moment().format('DD/MM/YYYY')
  // Define the disabled date array
  var disabledArr = gon.booked_date
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
