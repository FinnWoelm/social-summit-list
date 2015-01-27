$(document).ready(function(){
  
  // INDEX PAGE FILTERS //
  if ($("#index").length > 0 ) {
    
    window.onhashchange = getHashAndUpdate;
    
    /*** SHOWING FILTERS ***/
    $("#showFilters").click( function() {
      $(this).parent().siblings("form").toggle();
      $(this).parent().siblings("p").toggle();
      $(this).children("i").toggle();
    });
    
    /*** ADDING A FILTER ***/
    $("#addFilter").click( function() {
      
      if($("#updateButton").parent().is(":hidden")) {
        $("#showFilters").trigger("click");
      }
      
      $("#original").before($("#original form").clone());
      
      newSelector = $("#original").prev();
      
      // add remove button functionality
      newSelector.find(".remove-button").click( function() {
        $(this).parent().remove();
      });

      // add primary selector update functionality
      newSelector.find(".primary-select .form-control").change( function() {
        //alert($(this).children("option:selected").val());
        
        // remove current secondary fields
        $(this).parent().siblings(".secondary-select").remove();
        
        selection = $(this).children("option:selected");
        
        // append the appropriate fields
        if(selection.hasClass("date")) {
          $(this).parent().after($("#original .dateSelect").clone());
          initializePicker($(this).parent().parent().find(".datetimepicker"), true);
        }
        else if(selection.hasClass("text")) {
          $(this).parent().after($("#original .textSelect").clone());
        }
        else if(selection.hasClass("number")) {
          $(this).parent().after($("#original .numberSelect").clone());
        }
        else if(selection.hasClass("stages")) {
          $(this).parent().after($("#original .stagesSelect").clone());
        }
      });
      
      // trigger change to append things
      newSelector.find(".primary-select .form-control").change();
      
    });
    

    
    /*** EVALUATING ALL FILTERS ***/
    $("#updateButton").click( function() {
      
      // build the hash from the filters
      $hash = ""
      $(this).parent().siblings("form").each( function() {
        
        // add ampersand if the hash isn't empty
        if($hash != "")
          $hash += "&";
        
        // what is our current filter? --> add to hash
        $filter = $(this).children(".primary-select").find("option:selected").val();
        $hash += "f=" + $filter;
        
        // iterate through secondary selectors and add values to hash
        valCount = 1;
        $(this).children(".secondary-select").each( function() {
          if($filter != "stages")
            $hash += "&v"+valCount+"="+$(this).find(".form-control").val();
          else
            $hash += "&v"+valCount+"="+$(this).find("input").prop('checked');
          valCount++;
        });
        
      });
      
      if($(this).parent().siblings("form").length == 0)
        $hash = "all";
      
      // update our hash
      window.location.hash = $hash;
      
          
      // get hash and update listing WITHOUT rebuilding the filters
      //getHashAndUpdate(false);
    });
    
    
    // on load get hash and update
    getHashAndUpdate(true);
    
  }
  
  
  // on hash update DO
  function getHashAndUpdate($buildFilters) {
    
    $(".tbody").children().each(function() {
      $(this).show();
    });
    
    if ($buildFilters) {
      $("#showFilters").parent().siblings("form").remove(); 
    }
    
    $hash = window.location.hash;
    
    if($hash == "#all") {
      params = new Array();
    }
    else if($hash.length == 0) {
      today = new Date();
      day = today.getDate();
      month = today.getMonth()+1;
      year = today.getFullYear();
      params = new Array("f=startdate", "v1=after", "v2="+year+"/"+month+"/"+day);
    }
    else {
      params = $hash.substr(1).split("&");
    }
      
    // traverse pairs and update the listing
    for(var i = 0; i < params.length; i=i) {

      $filter = params[i].split("=")[1];
      $values = new Array();
      
      i++;
      
      while( i < params.length && params[i].split("=")[0] != "f") {
        $values.push(params[i].split("=")[1]);
        i++;
      }
      
      // if $buildFilters, then create filter
      if($buildFilters){
        $("#addFilter").trigger("click");
        $newForm = $("#original").prev();
        $newForm.find(".primary-select .form-control").val($filter).trigger("change");
        $newForm.find(".secondary-select .form-control").each( function(index) {
          $(this).val($values[index]);
        });
        
        $newForm.find(".secondary-select.checkbox").each( function(index) {
          $(this).find("input").prop('checked', $values[index] == "true" ?  true : false);
        });
      }
      
      // apply the filter
      applyFilter($filter, $values);
      
    }
    
    // update odd evens
    //alternateColors();
    
    if($hash.length == 0) {
      $("#showFilters").trigger("click");
    }
  }
  
  function applyFilter($filter, $values) {
    switch($filter) {
      case "startdate":
      case "deadline":  
        // convert date to seconds
        $values[1] = new Date($values[1]).getTime()/1000;
        
        $(".tbody").children().each(function() {
          
          // get the startdate of this summit
          date = get_summit_field($(this), "summit-"+$filter);
          
          // if startdate of summit is out of bounds, then hide it
          if (date != 0 &&
             ($values[0] == "before" && date > $values[1]
             || $values[0] == "after" && date < $values[1])) {
            $(this).hide();
          }
        });
        break;
      
      case "name":
      case "location":
        
        $(".tbody").children().each(function() {
          
          // get the text from summit
          text = get_summit_field($(this), "summit-"+$filter);
          
          // if search is not in text, then hide it
          if (text != "" && text.toLowerCase().indexOf($values[0].toLowerCase()) == -1) {
            $(this).hide();
          }
        });
        break;
        
      case "duration":
      case "cost":
        
        $(".tbody").children().each(function() {
          
          // get the number from this summit
          number = parseInt(get_summit_field($(this), "summit-"+$filter).match(/\d+/));
          
          // if number val of summit is out of bounds, then hide it
          if (number != null &&
             ($values[0] == "below" && number > $values[1]
             || $values[0] == "above" && number < $values[1])) {
            $(this).hide();
          }
        });
        break;
        
      case "stages":
        
        $(".tbody").children().each(function() {
          
          // get the number from this summit
          idea = get_summit_field($(this), "summit-project_stages-idea");
          planning = get_summit_field($(this), "summit-project_stages-planning");
          implementation = get_summit_field($(this), "summit-project_stages-implementation");
          operating = get_summit_field($(this), "summit-project_stages-operating");

          
          // if number val of summit is out of bounds, then hide it
          if (!(
               (idea === "true" && $values[0] === "true")
               || (planning === "true" && $values[1] === "true")
               || (implementation === "true" && $values[2] === "true")
               || (operating === "true" && $values[3] === "true"))) {
            $(this).hide();
          }
        });
        
        break;
    }
  }
  
  function alternateColors() {
    
    index = 0;
    
    $(".tbody").children().each( function() {
      if($(this).css("display") != "none") {
        if( index % 2 == 0)
          $(this).addClass("odd");
        else
          $(this).removeClass("odd");
        
        index++;
      }

    });
  }
  
  /// ON NEW SUMMIT PAGE //
  if ($(".datetimepicker").length > 0) {
        
    //today = new Date();
    //day = $.datepicker.formatDate('dd', today);
    //month = $.datepicker.formatDate('mm', today);
    //year = parseInt($.datepicker.formatDate('yy', today));
    
    $(".datetimepicker").each(function () {
      initializePicker($(this), $(this).hasClass("full-date-range"));
    });
  }
  
  function initializePicker(element, fullDateRange) {
    //  min+max dates
    if(!fullDateRange) {
      element.datetimepicker({
        pickTime: false,
        showToday: true,
        minDate: year+'/'+month+'/'+day,
        maxDate: (year+3)+'/'+month+'/'+day,
        icons: {
          time: "fa fa-clock-o",
          date: "fa fa-calendar",
          up: "fa fa-arrow-up",
          down: "fa fa-arrow-down"
        }
      }); 
    }
    // no min+max date
    else {
      element.datetimepicker({
        pickTime: false,
        showToday: true,
        icons: {
          time: "fa fa-clock-o",
          date: "fa fa-calendar",
          up: "fa fa-arrow-up",
          down: "fa fa-arrow-down"
        }
      });   
    }
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
        
        // update odd evens
        alternateColors();
        
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
    // return special information
    if(field.indexOf("summit-project_stages-") == 0)
      return $(summit).children(".summit-project_stages").first().children("." + field.substring("summit-project_stages-".length)).first().html();
    else
      return $(summit).children("."+field).first().children(".data").first().html(); 
  }

});