$(document).ready(function(){
  
  
  /// ON NEW SUMMIT PAGE //
  if ($(".datetimepicker").length > 0) {
    
    today = new Date();
    day = $.datepicker.formatDate('dd', today);
    month = $.datepicker.formatDate('mm', today);
    year = parseInt($.datepicker.formatDate('yy', today));
    
    $(".datetimepicker").each(function () {
      initializePicker($(this));
    });
  }
  
  function initializePicker(element) {
    element.datetimepicker({
      pickTime: false,
      showToday: true,
      minDate: year+'/'+month+'/'+day,
      maxDate: (year+3)+'/'+month+'/'+day,
     // defaultDate: year+'/'+month+'/'+day,
      icons: {
        time: "fa fa-clock-o",
        date: "fa fa-calendar",
        up: "fa fa-arrow-up",
        down: "fa fa-arrow-down"
      }
    }); 
  }

  
  if ($("#addDeadline").length > 0) {
    
    if($("#addDeadline").siblings(".application-deadline").length == 1) {
      $("#addDeadline").siblings(".application-deadline").first().children(".form-control").first().hide();
    }
    
    // DISABLE MYSELF
    $("#addDeadline").remove();
      
    $("#addDeadline").click(function () {
      if($(this).siblings(".application-deadline").length < 5) {
        
        // make sure first label field is shown
        $(this).siblings(".application-deadline").first().children(".form-control").first().show();
        
        // then clone
        new_element = $(this).prev().clone();
        initializePicker(new_element.children(".datetimepicker").first());
        $(this).before("<hr/>");
        $(this).before(new_element);

        
        // limit to five application deadlines
        if($(this).siblings(".application-deadline").length == 5) {
          $(this).remove(); 
        }
      }
    });
  }
  
  
  /// ON INDEX PAGE ///
  if ($(".sortable").length > 0) {
    $(".sortable").each(function () {

        
      $(this).click(function () {
        /*** ADD NEW ARGUMENT ***/
       // alert($(this).data("sort_by"));
        
        // determine the direction of sort; if not sorted so far, then do ascending
        var sort_asc = true;
        var already_sorted = false;
        
        // is this array already sorted by this category?
        if($(this).hasClass("sorted-asc") || $(this).hasClass("sorted-desc"))
          already_sorted = true;
        
        // if is already sorted asc, then let's do desc sort instead
        if($(this).hasClass("sorted-asc"))
          sort_asc = false;
        
        // remove the sorting image && sorting classes
        $(".sorted-asc").children().remove();
        $(".sorted-desc").children().remove();
        $(".sorted-asc").removeClass("sorted-asc");
        $(".sorted-desc").removeClass("sorted-desc").find("fa").remove();
        
        // do the actual sorting
        sort_by($(this).data("sort_by"), sort_asc, $(this).data("sort_type"), already_sorted);
        
        // sort complete, so let's add the right class
        $(this).addClass(sort_asc ? "sorted-asc" : "sorted-desc");
        
        // add sort image
        if(sort_asc){
          $(this).append(' <i class="fa fa-chevron-circle-up"></i>'); 
        }
        else{
          $(this).append(' <i class="fa fa-chevron-circle-down"></i>'); 
        }
          
      });

    });
  }
  
  function sort_by(sort_category, sort_asc, sort_type, already_sorted) {
    
    // get current state of affairs
    // learned from here:
    // * http://stackoverflow.com/questions/14208651/javascript-sort-key-value-pair-object-based-on-value
    // * http://blog.rodneyrehm.de/archives/14-Sorting-Were-Doing-It-Wrong.html
    var summitList = [];
 
    $(".tbody").children().each(function() {
      summitList.push({id: $(this).attr("id"), val: get_summit_field($(this), sort_category)});
    });
    
    // unless it was already sorted, sort the array now
    if(!already_sorted) {
      summitList = summitList.sort(function (a, b) {
        //alert(a.val + " vs " + b.val);
        if(sort_type == "number")
          return a.val - b.val;
        else if(sort_type == "abc")
          return a.val.localeCompare( b.val ); //sorting array
      });
      
      // if we were supposed to not be sorting ascending, then reverse the list now
      if(!sort_asc)
      summitList.reverse();
    }
    else {
      summitList.reverse(); // else we will just reverse
    }
      

    
    // now put it back together         
    for(var i = 0; i < summitList.length; i++) {
      $(".tbody").append($("#"+summitList[i].id));
    }
      
    /* SORT COMPLETE :) */
  }
  
  function get_summit_field(summit, field) {
    return $(summit).children("."+field).first().children(".data").first().html(); 
  }

});