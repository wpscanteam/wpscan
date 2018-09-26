

function getUrlVars()
{
  var vars = [], hash, i;
    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for(i = 0; i < hashes.length; i++)
    {
        hash = hashes[i].split('=');
        vars.push(hash[0]);
        vars[hash[0]] = hash[1];
    }
    return vars;
}

function wpgmappity_build_sample_map(target_div, data) {
  var latlng = new google.maps.LatLng(data.center_lat, data.center_long);

  var myOptions = {
    zoom: data.map_zoom,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    disableDoubleClickZoom : true,
    scrollwheel : false,
    disableDefaultUI : true
  };
  var map = new google.maps.Map(document.getElementById(target_div), myOptions);
  google.maps.event.trigger(map, 'resize');
  return map;
}

function wpgmappity_build_data_container() {
  var empty_controls_object = {
    zoom : {
      active : false,
      style : '',
      position : ''
    },
    type : {
      active : false,
      style : '',
      position : ''
    },
    scale : {
      active : false,
      position : ''
    },
    street : {
      active : false,
      position : ''
    }
  };

  var routeContainer = {
    'active' : '0',
    'points' : [],
    'color' : '',
    'service' : new google.maps.DirectionsService(),
    'display' : new google.maps.DirectionsRenderer()
  };

  var data = {
    'version' : '0.6',
    'map_length': 450,
    'map_height': 300,
    'map_zoom' : 3,
    'center_lat' : '39.185575',
    'center_long' : '-96.575206',
    'markers' : [],
    'map_type' : 'normal',
    'alignment' : 'none',
    'scroll' : 'scroll',
    'controls' : empty_controls_object,
    'map_address' : '',
    'slider_object' : '',
    'promote' : '0',
    'route' : routeContainer,
    'listeners' : {
      'zoom' : {},
      'center' : {}
      }

    };
  return data;
}

function wpgmappity_post_resize(map, data) {
  google.maps.event.trigger(map, 'resize');
  map.setCenter(new google.maps.LatLng(data.center_lat, data.center_long));
}


function wpgmappity_update_map_size(map, data) {
  jQuery("#wpgmappity_sample_map").animate(
    {
      "width" : data.map_length,
      "height" : data.map_height
    },
    function() {
      wpgmappity_post_resize(map, data);
	       }
  );
}

function wpgmappity_set_size_event(map, data) {
  jQuery("input[name='wpgmappity_selector_size']").click(function(){
    var selection = jQuery(this).attr("value");
      switch(selection)
	{
	case 'small':
	data.map_length = 300;
	data.map_height = 170;
	wpgmappity_update_map_size(map, data);
	break;
	case 'medium':
	data.map_length = 450;
	data.map_height = 300;
	wpgmappity_update_map_size(map, data);
	break;
	case 'large':
	data.map_length = 700;
	data.map_height = 400;
	wpgmappity_update_map_size(map, data);
	break;
	case 'custom':
	break;
	}
  });
  jQuery("#wpgmapity_custom_size_submit").live("click",
    function(){
      var height = parseInt(jQuery("#wpgmappity_custom_size_height").val(),10);
      var length = parseInt(jQuery("#wpgmappity_custom_size_length").val(),10);
      var error_type = false;
      var error_direction = false;

    if ( (height < 300) || (isNaN(height)) )
    {
      error_type = 'Height';
      error_direction = 'small.';
    }
    else if (height > 1000)
    {
      error_type = 'Height';
      error_direction = 'large.';
    }
    else if ( (length < 150) || (isNaN(length)) )
    {
      error_type = 'Length';
      error_direction = 'small.';
    }
    else if (length > 1000)
    {
      error_type = 'Length';
      error_direction = 'large.';
    }

    if ( error_type !== false )
    {
      jQuery("#wpgmappity_custom_size_warning").remove();
      var error_message = error_type + " is too " + error_direction;
      jQuery(this).parent().after("<p id='wpgmappity_custom_size_warning'>" + error_message + "</p>");
      return false;
    }
    data.map_length = length;
    data.map_height = height;
    wpgmappity_update_map_size(map, data);
    jQuery("#wpgmappity_custom_size_indicator").html("("+length+"x"+height+")");
    jQuery("input[name='wpgmappity_selector_size']").attr("checked", false);
    jQuery("#wpgmappity_selector_size_custom").attr("checked", true);
    tb_remove();
    return true;

					       });
}

function wpgmappity_set_zoom_event(map, data) {
  jQuery('#wpgmappity_zoom_slider').slider({
    min: 0,
    max: 400,
    value: 60,
    slide: function(e,ui){
      var position = jQuery('#wpgmappity_zoom_slider').slider("value");
      position = parseInt( (position / 20),10 ) + 1;
      jQuery("#wpgmappity_zoom_slider_status").html(position);
      if (map.getZoom() !== position) {
	map.setZoom(position);
        wpgmappity_post_resize(map, data);
	data.map_zoom = position;
	}
      }
  });

}

function wpgmappity_set_center(map,data) {
  map.setCenter(new google.maps.LatLng(data.center_lat, data.center_long));
  var message = "<p><span class='wpgamapptiy_success'>Center point set.</span></p>";
  jQuery("#wpgmappity_center_point_flash").html(message);
}


function wpgmappity_geocode_response(map, data, type) {
  return function(response, status) {
    if (status === 'OK') {
      // multiple options
      if (response.length > 1) {
	var text = '';
	for (x in response) {
	  text += '<p><a class="wpgmappity_more_';
	  if (type === 'point') {
	    text += 'center_link" href="#new_point">';
	    }
	  else if (type === 'marker') {
	    text += 'marker_link" href="#new_marker">';
	    }
	  text += response[x].formatted_address + "</a></p>";
	  }
	if (type === 'point') {
	  jQuery("#wpgmappity_more_center_results_contents").html(text);
	  tb_show('Did you mean?',"#TB_inline?height=300&width=400&inlineId=wpgmappity_more_center_results", null);
	  }
	else if (type === 'marker') {
	  jQuery("#wpgmappity_more_marker_results_contents").html(text);
	  jQuery("#wpgmappity_more_marker_results").show();
	  }
	}
      // direct hit
      else {
	if (type === 'point') {
	  data.center_lat = response[0].geometry.location.lat();
	  data.center_long = response[0].geometry.location.lng();
	  wpgmappity_set_center(map,data);
	  data.map_address = response[0].formatted_address;
	  }
	else if (type === 'marker') {
	  tb_remove();
	  wpgmapity_add_marker_to_map(data, map, response);
	  }
	}
      }
    else {
      var div;
      var message = "<p><span class='wpgamapptiy_warning'>Geocoding failed. Please try again.</span></p>";
      if (type === 'center') {
	div = 'center_point';
	}
      else {
	div = 'marker';
	}
      jQuery("#wpgmappity_" + div + "_flash").html(message);
      }
  };
}


function wpgmappity_set_center_point_event(map, data) {
  jQuery("#wpgmapity_center_point_submit").click(function() {
    var message = '<div id="wgmappity_small_ajax"></div>';
    jQuery("#wpgmappity_center_point_flash").html(message);
    var geoCodeRequest = {
        address : jQuery("#wpgmappity_center_point").val()
    };

    var geocoder = new google.maps.Geocoder();
    geocoder.geocode(geoCodeRequest, wpgmappity_geocode_response(map, data, 'point'));

    return false;
  });
  jQuery("#wpgmappity_more_center_results_not_here").live('click', function() {
    var message = "<p><span class='wpgamapptiy_warning'>Location not found.  Please try again.</span></p>";
    jQuery("#wpgmappity_center_point_flash").html(message);
    tb_remove();
    return false;
  });
  jQuery(".wpgmappity_more_center_link").live('click', function() {
    jQuery("#wpgmappity_center_point").val(jQuery(this).parent().text());
    jQuery("#wpgmapity_center_point_submit").trigger("click");
    tb_remove();
    return false;
  });
}

function wpgmappity_set_add_marker_event(map, data) {
  jQuery("#wpgamppity_add_marker_go").click(function() {
    tb_show('Add a Marker',
	    "#TB_inline?height=450&width=475&inlineId=wpgmappity_add_marker_dialog",
	    null);
    return false;
  });
  jQuery("#wpgmappity_marker_point_submit").live('click',
    function() {
      if ( jQuery("#wpgmappity_marker_point").val() == '' ) {
	alert("Enter a point to mark");
	return false;
      }
      var geocoder;
      // lat/long or address?
      if ( jQuery("#wpgmappity_marker_find_address").is(':checked') ) {
	var message = '<div id="wgmappity_small_ajax"></div>';
	jQuery("#wpgmappity_marker_flash").html(message);
	var geoCodeRequest = {
	  address : jQuery("#wpgmappity_marker_point").val()
	};

	geocoder = new google.maps.Geocoder();
	geocoder.geocode(geoCodeRequest, wpgmappity_geocode_response(map, data, 'marker'));
      }
       if ( jQuery("#wpgmappity_marker_find_latlng").is(':checked') ) {
	var latlng = jQuery("#wpgmappity_marker_point").val().split(',');
	var point = new google.maps.LatLng(latlng[0],latlng[1]);
	var geoCodeRequest = {
	  latLng : point
	};

	geocoder = new google.maps.Geocoder();
	geocoder.geocode(geoCodeRequest, wpgmappity_geocode_from_latlng(map, data));

      }
      return false;
  });
  jQuery("#wpgmappity_more_marker_results_not_here").live('click', function() {
    jQuery("#wpgmappity_more_marker_results").hide();
    tb_remove();
    return false;
  });
  jQuery(".wpgmappity_more_marker_link").live('click', function() {
    jQuery("#wpgmappity_marker_point").val(jQuery(this).parent().text());
    jQuery("#wpgmappity_more_marker_results").hide();
    jQuery("#wpgmappity_marker_point_submit").trigger("click");
    return false;
  });
}

function wpgmappity_change_map_type(map, data, selection) {
  switch(selection) {
  case 'normal':
  data.map_type = 'normal';
  map.setMapTypeId(google.maps.MapTypeId.ROADMAP);
  break;
  case 'satellite':
  data.map_type = 'satellite';
  map.setMapTypeId(google.maps.MapTypeId.SATELLITE);
  break;
  case 'hybrid':
  data.map_type = 'hybrid';
  map.setMapTypeId(google.maps.MapTypeId.HYBRID);
  break;
  case 'terrain':
  data.map_type = 'terrain';
  map.setMapTypeId(google.maps.MapTypeId.TERRAIN);
  break;
  }
}

function wpgmappity_set_type_event(map, data) {
  jQuery("input[name='wpgmappity_selector_map_type']").click(function(){
    var selection = jQuery(this).attr("value");
    wpgmappity_change_map_type(map, data, selection);
  });
}

function wpgmappity_set_alignment_event(map, data) {
  jQuery("input[name='wpgmappity_float']").change(function(){
    data.alignment = jQuery(this).attr("value");
  });
  jQuery("input[name='wpgmappity_scroll']").change(function(){
    data.scroll = jQuery(this).attr("value");
  });
}


function wpgmappity_set_modal_events(map, data) {
  // marker submit
  jQuery("#wgmappity_marker_configure_submit").click(wpgmappity_configure_marker_submit_callback(data, map));
}


function wgmappity_set_sample_map_events(map, wpgmappity_gmap_data) {
  wpgmappity_set_marker_display_events();
  wpgmappity_set_size_event(map, wpgmappity_gmap_data);
  wpgmappity_set_zoom_event(map, wpgmappity_gmap_data);
  wpgmappity_set_center_point_event(map, wpgmappity_gmap_data);
  wpgmappity_set_add_marker_event(map, wpgmappity_gmap_data);
  wpgmappity_set_type_event(map, wpgmappity_gmap_data);
  wpgmappity_set_alignment_event(map, wpgmappity_gmap_data);
  wpgmappity_set_controls_event(map, wpgmappity_gmap_data);
  wpgmappity_set_modal_events(map, wpgmappity_gmap_data);
  wpgmappity_set_promotion_event(map, wpgmappity_gmap_data);
  wpgmappity_set_route_event(map, wpgmappity_gmap_data);
}

function wgmappity_set_map_submission_event(map, data) {

  jQuery("#wpgmappity-create").submit(
    function() {
      // get rid of marker and point data specific to this map
      if (data.markers.length > 0) {
	for (x in data.markers) {
	  data.markers[x].point = '';
	  data.markers[x].marker_object = '';
	}
      }
      data.controls_object = '';
      data.route.display = null;
      data.route.service = null;
      data.listeners = null;
      var complete_data = JSON.stringify(data);
    jQuery("#wpgmappity-submit-info").val(complete_data);

    //return false;
  });
}

function wpgmappity_iframe_js() {
  var wpgmappity_gmap_data = wpgmappity_build_data_container();
  var map = wpgmappity_build_sample_map("wpgmappity_sample_map", wpgmappity_gmap_data);
  wgmappity_set_sample_map_events(map, wpgmappity_gmap_data);
  wgmappity_set_map_submission_event(map, wpgmappity_gmap_data);
  var gets = getUrlVars();
  if (gets["modify"] == 'edit') {
     wpgmappity_set_up_map(gets["map_id"], map, wpgmappity_gmap_data);
  }
}

// google.setOnLoadCallback(wpgmappity_iframe_js);
window.onload = function() { wpgmappity_iframe_js(); };