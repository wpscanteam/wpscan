var javascript_version = "2.4.2";
var ignore_key = true;
var start = 1;
var end = 16;
var active_tab = 1;
var active_tab_0 = 0;
var tabs_to_configure   = new Array();
var debug = false;
var debug_title = false;

var current_tab = 0;
var next_tab = 0;

var syntax_highlighting = false;
var settings_page = "";

var dateFormat = "yy-mm-dd";

var list_search_reload = false;

var AI_DISABLED             = 0;
var AI_BEFORE_POST          = 1;
var AI_AFTER_POST           = 2;
var AI_BEFORE_CONTENT       = 3;
var AI_AFTER_CONTENT        = 4;
var AI_BEFORE_PARAGRAPH     = 5;
var AI_AFTER_PARAGRAPH      = 6;
var AI_BEFORE_EXCERPT       = 7;
var AI_AFTER_EXCERPT        = 8;
var AI_BETWEEN_POSTS        = 9;
var AI_BEFORE_COMMENTS      = 10;
var AI_BETWEEN_COMMENTS     = 11;
var AI_AFTER_COMMENTS       = 12;
var AI_FOOTER               = 13;
var AI_ABOVE_HEADER         = 14;
var AI_BEFORE_HTML_ELEMENT  = 15;
var AI_AFTER_HTML_ELEMENT   = 16;
var AI_INSIDE_HTML_ELEMENT  = 17;


var AI_ALIGNMENT_DEFAULT        = 0;
var AI_ALIGNMENT_LEFT           = 1;
var AI_ALIGNMENT_RIGHT          = 2;
var AI_ALIGNMENT_CENTER         = 3;
var AI_ALIGNMENT_FLOAT_LEFT     = 4;
var AI_ALIGNMENT_FLOAT_RIGHT    = 5;
var AI_ALIGNMENT_NO_WRAPPING    = 6;
var AI_ALIGNMENT_CUSTOM_CSS     = 7;
var AI_ALIGNMENT_STICKY_LEFT    = 8;
var AI_ALIGNMENT_STICKY_RIGHT   = 9;
var AI_ALIGNMENT_STICKY_TOP     = 10;
var AI_ALIGNMENT_STICKY_BOTTOM  = 11;
var AI_ALIGNMENT_STICKY         = 12;

var AI_ADB_ACTION_NONE              = 0;
var AI_ADB_ACTION_MESSAGE           = 1;
var AI_ADB_ACTION_REDIRECTION       = 2;

var AI_ADB_BLOCK_ACTION_DO_NOTHING  = 0;
var AI_ADB_BLOCK_ACTION_REPLACE     = 1;
var AI_ADB_BLOCK_ACTION_SHOW        = 2;
var AI_ADB_BLOCK_ACTION_HIDE        = 3;

var AI_CODE_UNKNOWN  = 100;
var AI_CODE_BANNER   = 0;
var AI_CODE_ADSENSE  = 1;

var AI_ADSENSE_STANDARD         = 0;
var AI_ADSENSE_LINK             = 1;
var AI_ADSENSE_IN_ARTICLE       = 2;
var AI_ADSENSE_IN_FEED          = 3;
var AI_ADSENSE_MATCHED_CONTENT  = 4;

var AI_ADSENSE_SIZE_FIXED             = 0;
var AI_ADSENSE_SIZE_RESPONSIVE        = 1;
var AI_ADSENSE_SIZE_FIXED_BY_VIEWPORT = 2;

var AI_HTML_INSERTION_CLIENT_SIDE           = 0;
var AI_HTML_INSERTION_CLIENT_SIDE_DOM_READY = 1;
var AI_HTML_INSERTION_SEREVR_SIDE           = 2;

var AI_STICK_TO_THE_TOP         = 0;
var AI_STICK_VERTICAL_CENTER    = 1;
var AI_SCROLL_WITH_THE_CONTENT  = 2;
var AI_STICK_TO_THE_BOTTOM      = 3;


function b64e (str) {
  // first we use encodeURIComponent to get percent-encoded UTF-8,
  // then we convert the percent encodings into raw bytes which
  // can be fed into btoa.
  return btoa (encodeURIComponent (str).replace (/%([0-9A-F]{2})/g,
    function toSolidBytes (match, p1) {
      return String.fromCharCode ('0x' + p1);
  }));
}

function b64d (str) {
  // Going backwards: from bytestream, to percent-encoding, to original string.
  return decodeURIComponent (atob (str).split ('').map (function(c) {
    return '%' + ('00' + c.charCodeAt (0).toString (16)).slice (-2);
  }).join (''));
}

var shSettings = {
  "tab_size":"4",
  "use_soft_tabs":"1",
  "word_wrap":"1",
  "highlight_curr_line":"0",
  "key_bindings":"default",
  "full_line_selection":"1",
  "show_line_numbers":"0"};

function SyntaxHighlight (id, block, settings) {
  var textarea, editor, form, session, editDiv;

  settings ['tab_size'] = 2;

  this.textarea = textarea = jQuery(id);
  this.settings = settings || {};

  if (textarea.length === 0 ) { // Element does not exist
    this.valid = false;
    return;
  }

  this.valid = true;
  editDiv = jQuery('<div>', {
    position: 'absolute',
    'class': textarea.attr('class'),
    'id':  'editor-' + block
  }).insertBefore (textarea);

  textarea.css('display', 'none');
  this.editor = editor = ace.edit(editDiv[0]);
  this.form = form = textarea.closest('form');
  this.session = session = editor.getSession();

  editor.$blockScrolling = Infinity;

  session.setValue(textarea.val());

  // copy back to textarea on form submit...
  form.submit (function () {
    var block = textarea.attr ("id").replace ("block-","");
    var editor_disabled = true;
    if (typeof ace != 'undefined') {
      editor_disabled = jQuery("#simple-editor-" + block).is(":checked");
    }
    if (!editor_disabled) {
      textarea.val (session.getValue());
    }

//    if (textarea.val () == "") {
//      textarea.removeAttr ("name");
//    }
//    else textarea.val (b64e (textarea.val ()));

    var default_value = textarea.attr ("default");
    var current_value = textarea.val ();
    var name          = textarea.attr ("name");

    if (typeof name != 'undefined') {
      if (typeof default_value != 'undefined') {
//        console.log (textarea.attr ("name"), ": default_value: ", default_value, ", current_value: ", current_value);

        if (current_value == default_value) {
          textarea.removeAttr ("name");
//          console.log ("REMOVED: ", name);
        }
      }
//      else console.log ("NO DEFAULT VALUE: ", textarea.attr ("name"));
    }

    jQuery("#ai-active-tab").attr ("value", '[' + active_tab + ',' + active_tab_0 + ']');
  });

  session.setMode ("ace/mode/ai-html");

  this.applySettings();
}

SyntaxHighlight.prototype.applySettings = function () {
  var editor = this.editor,
    session = this.session,
    settings = this.settings;

  editor.renderer.setShowGutter(settings['show_line_numbers'] == 1);
  editor.setHighlightActiveLine(settings['highlight_curr_line'] == 1);
  editor.setSelectionStyle(settings['full_line_selection'] == 1 ? "line" : "text");
  editor.setTheme("ace/theme/" + settings['theme']);
  session.setUseWrapMode(settings['word_wrap'] == 1);
  session.setTabSize(settings['tab_size']);
  session.setUseSoftTabs(settings['use_soft_tabs'] == 1);
};

function is_sticky (custom_css) {
  custom_css = custom_css.replace (/\s+/g, '');

  if (custom_css.indexOf ("position:fixed") != - 1 && custom_css.indexOf ("z-index:") != - 1) return true;

  return false;
}

function change_block_alignment (block) {
  jQuery ("select#block-alignment-" + block).change ();
  jQuery ("select#horizontal-position-" + block).change ();
  jQuery ("select#vertical-position-" + block).change ();
}

function change_banner_image (block) {
  jQuery ("input#banner-image-url-" + block).trigger ("input");
}

function ai_css_value_px (css, property) {
  var found = false;

  styles = css.split (';');
  styles.forEach (function (style, index) {
    style = style.trim ();
    if (style.indexOf (property) == 0) {
      style_parts = style.split (':');
      if (style_parts.length == 2) {
        style_property = style_parts [0].trim ();
        style_value = style_parts [1].trim ();
        if (style_property == property && style_value.endsWith ('px')) found = true;
      }
    }
  });

  return found;
}

function ai_change_css (css, property, value) {
  var replaced = false;

  styles = css.split (';');
  styles.forEach (function (style, index) {
    org_style = style;
    style = style.trim ();
    if (style.indexOf (property) == 0) {
      style_parts = style.split (':');
      if (style_parts.length == 2) {
        style_property = style_parts [0].trim ();
        style_value = style_parts [1].trim ();
        if (style_property == property && style_value.endsWith ('px')) {
          var org_style_parts = org_style.split (':');
          styles [index] = org_style_parts [0] + ': ' + value + 'px';
          replaced = true;
        }
      }
    }
  });

  var new_style = styles.join (';');

  if (!replaced) {
    new_style = new_style.trim ();
    if (new_style.length != 0 && new_style.slice (-1) == ';') new_style = new_style.substring (0, new_style.length - 1);
    return new_style + '; ' + property + ': ' + value + ';';
  }

  return new_style;
}

function update_sticky_margins (style, horizontal_margin, vertical_margin) {

  if (vertical_margin !== '') {
    if (ai_css_value_px (style, 'top')) style = ai_change_css (style, 'top', vertical_margin);
    if (ai_css_value_px (style, 'bottom')) style = ai_change_css (style, 'bottom', vertical_margin);
  }

  if (horizontal_margin !== '') {
    if (ai_css_value_px (style, 'left')) style = ai_change_css (style, 'left', horizontal_margin); else
    if (ai_css_value_px (style, 'right')) style = ai_change_css (style, 'right', horizontal_margin); else
    if (ai_css_value_px (style, 'margin-left')) style = ai_change_css (style, 'margin-left', horizontal_margin); else
    if (ai_css_value_px (style, 'margin-right')) style = ai_change_css (style, 'margin-right', horizontal_margin);
  }

  return style;
}

(function ($) {
  $.widget("toggle.checkboxButton", {
    _create : function() {
      this._on(this.element, {
        "change" : function(event) {
          this.element.next ("label").find ('.checkbox-icon').toggleClass("on");
        }
      });
    }
  });
}(jQuery));


serialize_object = function (obj) {
  var str = [];
  for(var p in obj)
    if (obj.hasOwnProperty (p)) {
      str.push(encodeURIComponent (p) + "=" + encodeURIComponent (obj[p]));
    }
  return str.join ("&");
}

Number.isInteger = Number.isInteger || function (value) {
  return typeof value === "number" &&
         isFinite (value) &&
         Math.floor (value) === value;
};

function get_editor_text (block) {
  var editor_disabled = true;
  if (typeof ace != 'undefined') {
    var editor = ace.edit ("editor-" + block);
    editor_disabled = jQuery("#simple-editor-" + block).is(":checked");
  }
  if (!editor_disabled) return editor.getSession ().getValue();
  return jQuery ("#block-" + block).val ();
}

function set_editor_text (block, text) {
  var editor_disabled = true;
  if (typeof ace != 'undefined') {
    var editor = ace.edit ("editor-" + block);
    editor_disabled = jQuery("#simple-editor-" + block).is(":checked");
  }
  if (!editor_disabled)
    editor.getSession ().setValue(text); else
      jQuery ("#block-" + block).val (text);

}

function window_open_post (url, windowoption, name, params) {
   var form = document.createElement("form");
   form.setAttribute("method", "post");
   form.setAttribute("action", url);
   form.setAttribute("target", name);
   for (var i in params) {
     if (params.hasOwnProperty(i)) {
       var input = document.createElement('input');
       input.type = 'hidden';
       input.name = i;
       input.value = encodeURI (params[i]);
       form.appendChild(input);
     }
   }
   document.body.appendChild(form);
   //note I am using a post.htm page since I did not want to make double request to the page
   //it might have some Page_Load call which might screw things up.
//   window.open ("post.htm", name, windowoption);
   window.open ("admin-ajax.php", name, windowoption);
   form.submit();
   document.body.removeChild(form);
}


jQuery(document).ready(function($) {

  var header = $('#ai-settings-' + 'header').length != 0;

  if (header) {
    $.elycharts.templates['ai'] = {
      type : "line",
      margins : [10, 38, 20, 38],
      defaultSeries : {
        fill: true,
        fillProps: {
          opacity: .15
        },
        plotProps : {
          "stroke-width" : 1,
        },
      },
      series : {
        serie1 : {
          color : "#66f",
          rounded : 0.8,
        },
        serie2 : {
          color : "#888",
          axis : "r",
          fillProps: {
            opacity: .1
          },
        }
      },
      defaultAxis : {
        labels : true,
        min: 0,
      },
      features : {
        grid : {
          draw : true,
          forceBorder : true,
          ny: 5,
          ticks : {
            active : [true, true, true],
            size : [4, 0],
            props : {
              stroke: '#ccc',
            }
          }
        },
      },
      interactive: false
    }

    $.elycharts.templates['ai-clicks'] = {
      template: 'ai',
      series : {
        serie1 : {
          color : "#0a0",
          fillProps: {
            opacity: .2
          },
        },
        serie2 : {
          color : "#888",
        }
      },
    }

    $.elycharts.templates['ai-impressions'] = {
      template: 'ai',
      series : {
        serie1 : {
          color : "#66f",
        },
        serie2 : {
          color : "#888",
        }
      },
    }

    $.elycharts.templates['ai-ctr'] = {
      template: 'ai',
      series : {
        serie1 : {
          color : "#e22",
        },
        serie2 : {
          color : "#888",
        }
      },
    }

    $.elycharts.templates['ai-versions'] = {
      type : "line",
      margins : [10, 38, 20, 38],
      defaultSeries: {
        color: "#0a0",
        fillProps: {
          opacity: .2
        },
        plotProps : {
          "stroke-width" : 2,
        },
        tooltip : {
          frameProps : {
           opacity : 0.8
          }
        },
        rounded : 0.8,
      },
      series: {
        serie1: {
          color : "#aaa",
          axis : "l",
        },
        serie2 : {
          color : "#0a0",
          axis : "r",
        },
        serie3 : {
          color: "#33f",
        },
        serie4 : {
          color : "#e22",
        },
        serie5 : {
          color : "#e2f",
        },
        serie6 : {
          color : "#ec6400",
        },
        serie7 : {
          color : "#00a3b5",
        },
        serie8 : {
          color : "#7000ff",
        },
        serie9 : {
          color : "#000",
        },
        serie10 : {
          color : "#000",   // Used also for BLOCKED
        },
      },
      defaultAxis : {
        labels : true,
        min: 0,
      },
      features : {
        grid: {
          draw: true,
          forceBorder : true,
          ny: 5,
          ticks : {
            active : [true, true, true],
            size : [4, 0],
            props : {
              stroke: '#ccc',
            }
          }
        },
      },
      interactive: true,
    }

    $.elycharts.templates['ai-versions-legend'] = {
      template: 'ai-versions',
      margins : [10, 38, 10, 38],
      defaultSeries : {
        fill: true,
        fillProps: {
          opacity: 0
        },
        plotProps : {
          "stroke-width" : 0,
        },
      },
      defaultAxis : {
        labels : false,
      },
      features: {
        grid: {
          draw: false,
          props: {
            stroke: "transparent",
          },
          ticks : {
            active : false,
          }
        },
        legend: {
          horizontal : true,
          x : 20, // X | auto, (auto solo per horizontal = true)
          y : 0,
          width : 540, // X | auto, (auto solo per horizontal = true)
          height : 20,
          itemWidth : "auto", // fixed | auto, solo per horizontal = true
          borderProps: { fill : "white", stroke: "black", "stroke-width": 0},
        },
      },
    }

    $.elycharts.templates['ai-pie'] = {
      template: 'ai-versions',
      type: "pie",
      rPerc: 100,
      startAngle: 270,
      clockwise: true,
      margins : [0, 0, 0, 0],
      defaultSeries : {
        tooltip: {
          height: 55,
          width: 120,
          padding: [5, 5],
          offset: [-15, -10],
          frameProps: {
              opacity: 0.95,
              /* fill: "white", */
              stroke: "#000"

          }
        },
        plotProps : {
         stroke : "white",
         "stroke-width" : 0,
         opacity : 1
        },
        values : [{
         plotProps : {
          fill : "#aaa"
         }
        }, {
         plotProps : {
          fill : "#0a0"
         }
        }, {
         plotProps : {
          fill : "#33f"
         }
        }, {
         plotProps : {
          fill : "#e22"
         }
        }, {
         plotProps : {
          fill : "#e2f"
         }
        }, {
         plotProps : {
          fill : "#ec6400"
         }
        }, {
         plotProps : {
          fill : "#00a3b5"
         }
        }, {
         plotProps : {
          fill : "#7000ff"
         }
        }, {
         plotProps : {
          fill : "#000"
         }
        }, {
         plotProps : {
          fill : "#000"   // Used also for BLOCKED
         }
        }]
      }
    }

    $.elycharts.templates['ai-bar'] = {
      template: 'ai-pie',
      type: "line",
      margins : [5, 0, 5, 45],
      barMargins : 1,
      defaultSeries : {
        type: "bar",
        axis: "l",
        tooltip: {
          height: 38,
        }
      },
      features: {
        grid: {
          draw: [false, false],
          props : {stroke: '#e0e0e0', "stroke-width": 0},
          ticks : {
            props : {stroke: '#e0e0e0', "stroke-width": 0},
          }
        },
      },
    }

  }


  shSettings ['theme'] = $('#ai-data').attr ('theme');

  var geo_groups = 0;
  var geo_groups_text = $('#ai-data-2').attr ('geo_groups');
  if (typeof geo_groups_text != 'undefined') {
    geo_groups = parseInt (geo_groups_text);
  }

  debug = parseInt ($('#ai-data').attr ('js_debugging'));

  if (debug) {
    var start_time = new Date().getTime();
    var last_time = start_time;
    debug_title = true;
  }

  syntax_highlighting = typeof shSettings ['theme'] != 'undefined' && shSettings ['theme'] != 'disabled';

  var header_id = 'name';
//  var preview_top = (screen.height / 2) - (820 / 2);

  function remove_default_values (block) {
    $("#tab-" + block + " input:checkbox").each (function() {
      var default_value = $(this).attr ("default");
      var current_value = $(this).is (':checked');
      var name          = $(this).attr ("name");

      if (typeof name != 'undefined') {
        if (typeof default_value != 'undefined') {
          default_value = Boolean (parseInt (default_value));
  //        console.log ($(this).attr ("name"), ": default_value: ", $(this).attr ("default"), " = ", default_value, ", current_value: ", current_value);

          if (current_value == default_value) {
            $(this).removeAttr ("name");
            $("#tab-" + block + " [name='" + name + "']").removeAttr ("name");
  //          console.log ("REMOVED: ", name);
          }
        }
//        else console.log ("NO DEFAULT VALUE:", $(this).attr ("name"));
      }
    });

    $("#tab-" + block + " input:text").each (function() {
      var default_value = $(this).attr ("default");
      var current_value = $(this).val ();
      var name          = $(this).attr ("name");

      if (typeof name != 'undefined') {
        if (typeof default_value != 'undefined') {
  //        console.log ($(this).attr ("name"), ": default_value: ", default_value, ", current_value: ", current_value);

          if (current_value == default_value) {
            $(this).removeAttr ("name");
  //          console.log ("REMOVED: ", name);
          }
        }
//        else console.log ("NO DEFAULT VALUE: ", $(this).attr ("name"));
      }
    });

    $("#tab-" + block + " select").each (function() {
      var default_value = $(this).attr ("default");
      var current_value = $(this).val();
      var name          = $(this).attr ("name");

      if (typeof name != 'undefined') {
//        console.log ($(this).attr ("id"), name, default_value, current_value);

        // to do: children of OPTGROUP
        var childern = $(this).children ();
        if (childern.prop ("tagName") == "OPTGROUP") {
          var current_value = "";
          childern.each (function() {
            var selected = $(this).val();
            if (selected.length != 0) {
              current_value = selected;
              return false;
            }
          });
        }

  //      if ($(this).attr ("selected-value") == 1) current_value = current_value.attr("value");

        if (typeof default_value != 'undefined') {
//          console.log ($(this).attr ("name"), ": default_value: ", default_value, " current_value: ", current_value);

          if (current_value == default_value) {
            $(this).removeAttr ("name");
//            console.log ("REMOVED: ", name);
          }
        }
//        else console.log ("NO DEFAULT VALUE: ", $(this).attr ("name"));
      }
    });

    $("#tab-" + block + " input:radio:checked").each (function() {
      var default_value = $(this).attr ("default");
      var current_value = $(this).is (':checked');
      var name          = $(this).attr ("name");

      if (typeof name != 'undefined') {
        if (typeof default_value != 'undefined') {
          default_value = Boolean (parseInt (default_value));
  //        console.log ($(this).attr ("name"), ": default_value: ", $(this).attr ("default"), " = ", default_value, ", current_value: ", current_value);

          if (current_value == default_value) {
            $("#tab-" + block + " [name='" + name + "']").removeAttr ("name");
  //          console.log ("REMOVED: ", name);
          }
        }
//        else console.log ("NO DEFAULT VALUE: ", $(this).attr ("name"));
      }
    });

    // Already removed in SyntaxHighlight
//    $("#tab-" + block + " textarea").each (function() {
//      var default_value = $(this).attr ("default");
//      var current_value = $(this).val ();
//      var name          = $(this).attr ("name");

//      if (typeof name != 'undefined') {
//        if (typeof default_value != 'undefined') {
//          console.log ($(this).attr ("name"), ": default_value: ", default_value, ", current_value: ", current_value);

//          console.log ('#', current_value, '#');
//          console.log ('#', default_value, '#');

//          if (current_value == default_value) {
//            $(this).removeAttr ("name");
//            console.log ("REMOVED: ", name);
//          }
//        }
//        else console.log ("NO DEFAULT VALUE: ", $(this).attr ("name"));
//      }
//    });
  }

  function configure_editor_language (block) {

    var editor = ace.edit ("editor-" + block);

    if ($("input#process-php-"+block).is(":checked")) {
      editor.getSession ().setMode ("ace/mode/ai-php");
    } else editor.getSession ().setMode ("ace/mode/ai-html");
  }

  function disable_auto_refresh_statistics () {
    $('span.icon-auto-refresh').each (function() {
      $(this).removeClass ('on');
    });
  }

  function reload_statistics (block) {
    if ($("input#auto-refresh-"+block).next ().find ('.checkbox-icon').hasClass ('on')) {
      $("input#load-custom-range-"+block).click ();
      setTimeout (function() {reload_statistics (block);}, 60 * 1000);
    }
  }

  function getDate (element) {
    var date;
    try {
      date = $.datepicker.parseDate (dateFormat, element.val ());
    } catch (error) {
      date = null;
    }

    return date;
  }

  function process_scheduling_dates (block) {
    var start_date_picker = $("#scheduling-on-"+block);
    var end_date_picker   = $("#scheduling-off-"+block);
    var scheduling = $("select#scheduling-"+block).val();
    var start_date = getDate (start_date_picker);
    var end_date   = getDate (end_date_picker);

    end_date_picker.attr ('title', '');
    end_date_picker.css ("border-color", "#ddd");

    if (start_date == null) {
      end_date_picker.attr ('title', '');
    } else
    if (end_date == null) {
      end_date_picker.attr ('title', '');
    } else
    if (end_date > start_date) {
      if (scheduling == "2") {
        var now = new Date();
        var today_date = new Date (now.getFullYear(), now.getMonth(), now.getDate(), 0, 0, 0, 0);
        if (end_date <= today_date) {
          var expiration = Math.round ((today_date - end_date) / 1000 / 3600 / 24);
          end_date_picker.attr ('title', 'Insertion expired');
          end_date_picker.css ("border-color", "#d00");
        } else {
            var duration = Math.round ((end_date - start_date) / 1000 / 3600 / 24);
            end_date_picker.attr ('title', ' Duration: ' + duration + ' day' + (duration == 1 ? '' : 's'));
          }
      }
    } else {
        end_date_picker.attr ('title', 'Invalid end date - must be after start date');
        end_date_picker.css ("border-color", "#d00");
      }
  }

  function process_chart_dates (block) {
    var start_date_picker = $("input#chart-start-date-"+block);
    var end_date_picker   = $("input#chart-end-date-"+block);
    var start_date = getDate (start_date_picker);
    var end_date   = getDate (end_date_picker);

    start_date_picker.attr ('title', '');
    start_date_picker.css ("border-color", "rgb(221, 221, 221)");
    end_date_picker.attr ('title', '');
    end_date_picker.css ("border-color", "rgb(221, 221, 221)");

    if (start_date == null) {
      end_date_picker.attr ('title', '');
    } else
    if (end_date == null) {
      end_date_picker.attr ('title', '');
    } else
    if (end_date > start_date) {
      var now = new Date();
      var today_date = new Date (now.getFullYear(), now.getMonth(), now.getDate(), 0, 0, 0, 0);
      if (today_date - start_date > 366 * 24 * 3600 * 1000) {
        start_date_picker.attr ('title', 'Invalid start date - only data for 1 year back is available');
        start_date_picker.css ("border-color", "#d00");
      }
      if (end_date - start_date > 366 * 24 * 3600 * 1000) {
        end_date_picker.attr ('title', 'Invalid date range - only data for 1 year can be displayed');
        end_date_picker.css ("border-color", "#d00");
      }
    } else {
        end_date_picker.attr ('title', 'Invalid end date - must be after start date');
        end_date_picker.css ("border-color", "#d00");
      }
  }

  function process_display_elements (block) {

    $("#paragraph-settings-"+block).hide();

    $("#html-element-settings-"+block).hide();

    $("#inside-element-"+block).hide();

    var automatic_insertion = $("select#display-type-"+block+" option:selected").attr('value');

    if (automatic_insertion == AI_BEFORE_PARAGRAPH || automatic_insertion == AI_AFTER_PARAGRAPH) {
      $("#paragraph-settings-"+block).show();
    } else {
        $("#paragraph-counting-"+block).hide();
        $("#paragraph-clearance-"+block).hide();
      }

    if (automatic_insertion == AI_BEFORE_HTML_ELEMENT || automatic_insertion == AI_AFTER_HTML_ELEMENT || automatic_insertion == AI_INSIDE_HTML_ELEMENT) {
      $("#html-element-settings-"+block).show();

      if (automatic_insertion == AI_INSIDE_HTML_ELEMENT) {
        $("#inside-element-"+block).css ('display', 'table-cell');
      }
    }

    var content_settings = automatic_insertion == AI_BEFORE_PARAGRAPH || automatic_insertion == AI_AFTER_PARAGRAPH || automatic_insertion == AI_BEFORE_CONTENT || automatic_insertion == AI_AFTER_CONTENT;

    $("#css-label-"+block).css('display', 'table-cell');
    $("#edit-css-button-"+block).css('display', 'table-cell');

    $("#css-none-"+block).hide();
    $("#custom-css-"+block).hide();
    $("#css-left-"+block).hide();
    $("#css-right-"+block).hide();
    $("#css-center-"+block).hide();
    $("#css-float-left-"+block).hide();
    $("#css-float-right-"+block).hide();
    $("#css-sticky-left-"+block).hide();
    $("#css-sticky-right-"+block).hide();
    $("#css-sticky-top-"+block).hide();
    $("#css-sticky-bottom-"+block).hide();
    $("#css-sticky-"+block).hide();
    $("#css-no-wrapping-"+block).hide();

    $("#no-wrapping-warning-"+block).hide();

    $("#sticky-position-"+block).hide();
    $("#sticky-animation-"+block).hide();

    $('#tracking-wrapping-warning-' + block).hide ();

    var alignment = $("select#block-alignment-"+block+" option:selected").attr('value');

    if (alignment == AI_ALIGNMENT_NO_WRAPPING) {
      $("#css-no-wrapping-"+block).css('display', 'table-cell');
      $("#css-label-"+block).hide();
      $("#edit-css-button-"+block).hide();
      if ($("#client-side-detection-"+block).is(":checked")) {
        $("#no-wrapping-warning-"+block).show();
      }

      if ($('#tracking-' + block).next ().find ('.checkbox-icon').hasClass ('on')) {
        $('#tracking-wrapping-warning-' + block).show ();
      }
    } else
    if (alignment == AI_ALIGNMENT_DEFAULT) {
      $("#css-none-"+block).css('display', 'table-cell');
    } else
    if (alignment == AI_ALIGNMENT_CUSTOM_CSS) {
      $("#icons-css-code-" + block).show();
      $("#custom-css-"+block).show();
      configure_selection_icons (block);
      if (is_sticky ($("#custom-css-"+block).val ())) {
        $("#sticky-position-"+block).show();
        $("#sticky-animation-"+block).show();
      }
    } else
    if (alignment == AI_ALIGNMENT_LEFT) {
      $("#css-left-"+block).css('display', 'table-cell');
    } else
    if (alignment == AI_ALIGNMENT_RIGHT) {
      $("#css-right-"+block).css('display', 'table-cell');
    } else
    if (alignment == AI_ALIGNMENT_CENTER) {
      $("#css-center-"+block).css('display', 'table-cell');
    } else
    if (alignment == AI_ALIGNMENT_FLOAT_LEFT) {
      $("#css-float-left-"+block).css('display', 'table-cell');
    } else
    if (alignment == AI_ALIGNMENT_FLOAT_RIGHT) {
      $("#css-float-right-"+block).css('display', 'table-cell');
    } else
    if (alignment == AI_ALIGNMENT_STICKY_LEFT) {
      $("#css-sticky-left-"+block).css('display', 'table-cell');
    } else
    if (alignment == AI_ALIGNMENT_STICKY_RIGHT) {
      $("#css-sticky-right-"+block).css('display', 'table-cell');
    }
    if (alignment == AI_ALIGNMENT_STICKY_TOP) {
      $("#css-sticky-top-"+block).css('display', 'table-cell');
    } else
    if (alignment == AI_ALIGNMENT_STICKY_BOTTOM) {
      $("#css-sticky-bottom-"+block).css('display', 'table-cell');
    } else
    if (alignment == AI_ALIGNMENT_STICKY) {
      $("#icons-css-code-" + block).show();
      $("#sticky-position-"+block).show();
      $("#sticky-animation-"+block).show();
      $("#css-sticky-"+block).css('display', 'table-cell');
      configure_selection_icons (block);
    }


    if ($('#icons-css-code-'+block).css ('display') != 'none') {
        $("#show-css-button-"+block+" span").text ("Hide");
    } else {
        $("#show-css-button-"+block+" span").text ("Show");
      }

    var avoid_action = $("select#avoid-action-"+block+" option:selected").text();

    if (avoid_action == "do not insert")
      $("#check-up-to-"+block).hide (); else
        $("#check-up-to-"+block).show ();


    $("#scheduling-delay-"+block).hide();
    $("#scheduling-between-dates-"+block).hide();
    $("#scheduling-delay-warning-"+block).hide();
    var scheduling = $("select#scheduling-"+block).val();
    if (scheduling == "1" || scheduling == "3") {
//      if (content_settings) {
        $("#scheduling-delay-"+block).show();
//      } else {
//          $("#scheduling-delay-warning-"+block).show();
//        }
    } else
    if (scheduling == "2" || scheduling == "4" || scheduling == "5" || scheduling == "6") {
      $("#scheduling-between-dates-"+block).show();
      process_scheduling_dates (block);
    }


    $("#adb-block-replacement-"+block).hide();
    var adb_block_action = $("select#adb-block-action-"+block).val();
    if (adb_block_action == AI_ADB_BLOCK_ACTION_REPLACE) {
      $("#adb-block-replacement-"+block).show();
    }

    if (syntax_highlighting) configure_editor_language (block);

    check_insertion (block);
  }

  function process_adsense_elements (block) {
    var adsense_type  = parseInt ($("select#adsense-type-" + block +" option:selected").attr ('value'));
    var adsense_size  = parseInt ($("select#adsense-size-" + block +" option:selected").attr ('value'));

    if ((adsense_type == AI_ADSENSE_STANDARD || adsense_type == AI_ADSENSE_LINK) && adsense_size == AI_ADSENSE_SIZE_FIXED_BY_VIEWPORT) {
      $('#adsense-layout-' + block).hide ();
      $('#adsense-viewports-' + block).show ();
    } else {
        $('#adsense-layout-' + block).show ();
        $('#adsense-viewports-' + block).hide ();
      }

    $('#tab-adsense-' + block + ' .adsense-layout').css ('visibility', 'hidden');
    $('#tab-adsense-' + block + ' .adsense-fixed-size').css ('visibility', 'hidden');
    $('#tab-adsense-' + block + ' .adsense-size').css ('visibility', 'hidden');

    switch (adsense_type) {
      case AI_ADSENSE_STANDARD:
        $('#tab-adsense-' + block + ' .adsense-size').css ('visibility', 'visible');
        if (adsense_size == AI_ADSENSE_SIZE_FIXED) $('#tab-adsense-' + block + ' .adsense-fixed-size').css ('visibility', 'visible');
        break;
      case AI_ADSENSE_LINK:
        $('#tab-adsense-' + block + ' .adsense-size').css ('visibility', 'visible');
        if (adsense_size == AI_ADSENSE_SIZE_FIXED) $('#tab-adsense-' + block + ' .adsense-fixed-size').css ('visibility', 'visible');
        break;
      case AI_ADSENSE_IN_ARTICLE:
        break;
      case AI_ADSENSE_IN_FEED:
        $('#tab-adsense-' + block + ' .adsense-layout').css ('visibility', 'visible');
        break;
      case AI_ADSENSE_MATCHED_CONTENT:
        break;
    }
  }

  function switch_editor (block, editor_disabled) {
    var editor = ace.edit ("editor-" + block);
    var textarea = $("#block-" + block);
    var ace_editor = $("#editor-" + block);

    if (editor_disabled) {
      textarea.val (editor.session.getValue());
      textarea.css ('display', 'block');
      ace_editor.css ('display', 'none');
    } else {
        editor.session.setValue (textarea.val ())
        editor.renderer.updateFull();
        ace_editor.css ('display', 'block');
        textarea.css ('display', 'none');
      }
  }

  function configure_editor (block) {

    if (debug) console.log ("configure_editor:", block);

    if (syntax_highlighting) {
      var syntax_highlighter = new SyntaxHighlight ('#block-' + block, block, shSettings);
      syntax_highlighter.editor.setPrintMarginColumn (1000);

      $('input#simple-editor-' + block).change (function () {

        var block = $(this).attr ("id").replace ("simple-editor-","");
        var editor_disabled = $(this).is(":checked");

        switch_editor (block, editor_disabled);

//        var editor = ace.edit ("editor-" + block);
//        var textarea = $("#block-" + block);
//        var ace_editor = $("#editor-" + block);

//        if (editor_disabled) {
//          textarea.val (editor.session.getValue());
//          textarea.css ('display', 'block');
//          ace_editor.css ('display', 'none');
//        } else {
//            editor.session.setValue (textarea.val ())
//            editor.renderer.updateFull();
//            ace_editor.css ('display', 'block');
//            textarea.css ('display', 'none');
//          }
      });
    }

    if (block != 'h' && block != 'f' && block != 'a' && !header) {
      if ((block - 1) >> 4) {
        $('#block'   + '-' + block).removeAttr(header_id);
        $('#display' + '-type-' + block).removeAttr(header_id);
      }

      if (block >> 2) {
        $('#option' + '-name-' + block).removeAttr(header_id);
        $('#option' + '-length-' + block).removeAttr(header_id);
      }
    }
  }

  function configure_adb () {
    $("#adb-message").hide();
    $("#adb-page-redirection").hide();

    var adb_action = $("select#adb-action option:selected").attr('value');

    if (adb_action == AI_ADB_ACTION_MESSAGE) {
      $("#adb-message").show();
    } else
    if (adb_action == AI_ADB_ACTION_REDIRECTION) {
      $("#adb-page-redirection").show();
    }
  }


  function configure_statistics_toolbar (tab) {
    $("input#load-custom-range-"+tab).click (function () {
      var block = $(this).attr ("id");
      block = block.replace ("load-custom-range-","");

      var label = $(this).next ().find ('.checkbox-icon');
      label.addClass ('on');

      var nonce = $(this).attr ('nonce');
      var start_date = $("input#chart-start-date-" + block).attr('value');
      var end_date = $("input#chart-end-date-" + block).attr('value');
      var container = $("div#statistics-elements-" + block);

      var version_charts_container = $("div#ai-version-charts-" + block);
      var version_charts_container_visible = version_charts_container.is (':visible');

      var delete_range = '';
      if ($("input#clear-range-"+block).hasClass ('delete')) {
        delete_range = '&delete=1';
      }

      var adb = '';
      if ($("input#adb-statistics-button-"+block).next ().find ('.icon-adb').hasClass ('on')) {
        adb = '&adb=1';
      }

      container.load (ajaxurl+"?action=ai_ajax_backend&statistics=" + block + "&start-date=" + start_date + "&end-date=" + end_date + delete_range + adb + "&ai_check=" + nonce, function (response, status, xhr) {
        label.removeClass ('on');
        if ( status == "error" ) {
          var message = "Error downloading data: " + xhr.status + " " + xhr.statusText ;
          $( "div#load-error-" + block).html (message);
          if (debug) console.log (message);
        } else {
            $( "div#load-error-" + block).html ('');
            if (debug) console.log ("Custom statistics loaded: " + block);
            configure_charts (container);

            container.find ("label.ai-version-charts-button.not-configured").click (function () {
              var no_delay_version_charts = $(this).hasClass ('no-version-charts-delay');

              $(this).removeClass ('not-configured');
              var version_charts_container = $(this).closest (".ai-charts").find ('div.ai-version-charts');
              version_charts_container.toggle ();

              var not_configured_charts = version_charts_container.find ('.ai-chart.not-configured.hidden');
              if (not_configured_charts.length) {
                not_configured_charts.each (function() {
                  $(this).removeClass ('hidden');
                });
                if (no_delay_version_charts) {
                  configure_charts (version_charts_container);
                } else setTimeout (function() {configure_charts (version_charts_container);}, 10);
              }
            });

            if (version_charts_container_visible) {
              container.find ("label.ai-version-charts-button.not-configured").addClass ('no-version-charts-delay').click ();
            }

            $("input#chart-start-date-"+block).css ('color', '#32373c');
            $("input#chart-end-date-"+block).css ('color', '#32373c');
          }
      });
    });

    $("input#auto-refresh-"+tab).click (function () {
      var block = $(this).attr ("id");
      block = block.replace ("auto-refresh-","");
      var label = $(this).next ().find ('.checkbox-icon');
      label.toggleClass ('on');
      if (label.hasClass ('on')) {
        reload_statistics (block);
      }
    });

    $("input#clear-range-"+tab).click (function () {
      var block = $(this).attr ("id");
      block = block.replace ("clear-range-","");

      var delete_button = this;
      var start_date = $("input#chart-start-date-" + block).attr('value');
      var end_date = $("input#chart-end-date-" + block).attr('value');

      var message = '';
      if (start_date == '' && end_date == '')
        var message = 'Delete all statistics data?'; else
          if (start_date != '' && end_date != '') var message = 'Delete statistics data between ' + start_date + ' and ' + end_date + '?';

      if (message != '')
        $('<div />').html(message).attr ('title', 'Warning').dialog({
          bgiframe: true,
          draggable: false,
          resizable: false,
          modal: true,
          height: "auto",
          width: 400,
          position: {my: 'center', at: 'center', of: '#ai-settings'},
          buttons: {
            "Delete": function() {
              $(this).dialog ("close");

              $(delete_button).addClass ('delete');
              $("input#load-custom-range-"+block).click ();
              $(delete_button).removeClass ('delete');
            },
            Cancel: function() {
              $(this).dialog ("close");
            },
          },
          open: function() {$(this).parent ().find ('button:nth-child(2)').focus();}
        });
    });

    $("input#chart-start-date-"+tab).datepicker ({dateFormat: dateFormat, autoSize: true});
    $("input#chart-end-date-"+tab).datepicker ({dateFormat: dateFormat, autoSize: true});

    $("input#chart-start-date-"+tab).change (function() {
      disable_auto_refresh_statistics ();
      var block = $(this).attr('id').replace ("chart-start-date-", "");
      $(this).css ('color', 'red');
      process_chart_dates (block);
    });

    $("input#chart-end-date-"+tab).change (function() {
      disable_auto_refresh_statistics ();
      var block = $(this).attr('id').replace ("chart-end-date-", "");
      $(this).css ('color', 'red');
      process_chart_dates (block);
    });

    $("div#custom-range-controls-"+tab+" span.data-range").click (function () {
      disable_auto_refresh_statistics ();
      var id = $(this).closest (".custom-range-controls").attr ("id");
      block = id.replace ("custom-range-controls-","");
      $("input#chart-start-date-"+block).attr ("value", $(this).data ("start-date"));
      $("input#chart-end-date-"+block).attr ("value", $(this).data ("end-date"));
      $("input#load-custom-range-"+block).click ();
    });
  }

  function configure_tab_0 () {

    if (debug) console.log ("configure_tab_0");

    $('#tab-0').addClass ('configured');

    $('#tab-0 input[type=submit], #tab-0 button.ai-button').button().show ();

    configure_editor ('h');
    configure_editor ('f');
    if ($("#block-a").length)
    configure_editor ('a');

    $('#ai-plugin-settings-tab-container').tabs();
    $('#ai-plugin-settings-tabs').show();

    $("#export-switch-0").checkboxButton ().click (function () {
      $("#export-container-0").toggle ();

      if ($("#export-container-0").is(':visible') && !$(this).hasClass ("loaded")) {
        var nonce = $(this).attr ('nonce');
        $("#export_settings_0").load (ajaxurl+"?action=ai_ajax_backend&export=0&ai_check=" + nonce, function (response, status, xhr) {
          if (status == "error" ) {
            $('#ai-error-container').text ('ERROR ' + xhr.status + ': ' + xhr.statusText).show ();
          } else {
              $("#export_settings_0").attr ("name", "export_settings_0");
              $("#export-switch-0").addClass ("loaded");
            }

        });
      }
    });

    $("input#process-php-h").change (function() {
      if (syntax_highlighting) configure_editor_language ('h');
    });

    $("input#process-php-f").change (function() {
      if (syntax_highlighting) configure_editor_language ('f')
    });

    $("input#process-php-a").change (function() {
      if (syntax_highlighting) configure_editor_language ('a')
    });

    if (syntax_highlighting) configure_editor_language ('h');
    if (syntax_highlighting) configure_editor_language ('f');
    if ($("#block-a").length)
    if (syntax_highlighting) configure_editor_language ('a');

    for (var index = 1; index <= geo_groups; index ++) {
      create_list_selector ('group-country', index);
    }

    $('#enable-header').checkboxButton ();
    $('#enable-header-404').checkboxButton ();

    $('#simple-editor-h').checkboxButton ().click (function () {
        var tab_id = $("#ai-plugin-settings-tab-container .ui-tabs-panel:visible").attr("id");
        if (active_tab == 0 && tab_id == 'tab-header') {
          $('#ai-tab-container .simple-editor-button').click();
        }
    });
    // Switch to simple editor if the button was pressed before the tab was configured
    if ($('#simple-editor-h').is(":checked")) {
      switch_editor ('h', true);
      $('#simple-editor-h').next ("label").find ('.checkbox-icon').addClass("on");
    }

    $('#process-php-h').checkboxButton ();

    $('#enable-footer').checkboxButton ();
    $('#enable-footer-404').checkboxButton ();

    $('#simple-editor-f').checkboxButton ().click (function () {
        var tab_id = $("#ai-plugin-settings-tab-container .ui-tabs-panel:visible").attr("id");
        if (active_tab == 0 && tab_id == 'tab-footer') {
          $('#ai-tab-container .simple-editor-button').click();
        }
    });
    // Switch to simple editor if the button was pressed before the tab was configured
    if ($('#simple-editor-f').is(":checked")) {
      switch_editor ('f', true);
      $('#simple-editor-f').next ("label").find ('.checkbox-icon').addClass("on");
    }

    $('#process-php-f').checkboxButton ();

    $('#tracking').checkboxButton ();

    configure_statistics_toolbar (0);

    $("input#statistics-button-0").checkboxButton ().click (function () {
      $("div#statistics-container-0").toggle ();
      $("div#tab-tracking-settings").toggle ();
      var container = $("div#statistics-container-0");
      if (container.is(':visible')) {
        if (!$(this).hasClass ('loaded')) {
          $("input#load-custom-range-0").click ();
          $(this).addClass ('loaded');
        }
      }
    });

    $('#enable-adb-detection').checkboxButton ();

    $('#simple-editor-a').checkboxButton ().click (function () {
        var tab_id = $("#ai-plugin-settings-tab-container .ui-tabs-panel:visible").attr("id");
        if (active_tab == 0 && tab_id == 'tab-adblocking') {
          $('#ai-tab-container .simple-editor-button').click();
        }
    });
    // Switch to simple editor if the button was pressed before the tab was configured
    if ($('#simple-editor-a').is(":checked")) {
      switch_editor ('a', true);
      $('#simple-editor-a').next ("label").find ('.checkbox-icon').addClass("on");
    }

    $('#process-php-a').checkboxButton ();


    configure_adb ();
    $("select#adb-action").change (function() {
      configure_adb ();
    });

    $("#preview-button-adb").button ({
    }).show ().click (function () {

      $(this).blur ();

      var code = b64e (get_editor_text ('a'));
      var php =  $("input#process-php-a").is(":checked") ? 1 : 0;

      var window_width = 820;
      var window_height = 870;
      var window_left  = 100;
      var window_top   = (screen.height / 2) - (870 / 2);
      var nonce = $(this).attr ('nonce');
      var param = {'action': 'ai_ajax_backend', 'preview': 'adb', 'ai_check': nonce, 'code': code, 'php': php};
      window_open_post (ajaxurl, 'width='+window_width+',height='+window_height+',top='+window_top+',left='+window_left+',resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,menubar=no', 'preview', param);
    });

    $("#main-content-element-button").click (function () {
      var selector      = $("input#main-content-element").val ();
      var home_url      = $("#ai-settings").data ('home-relative-url');
      var window_top    = screen.availTop;
      var window_left   = screen.availLeft;
      var window_width  = screen.availWidth - 15;
      var window_height = screen.availHeight - 65;

      var param = {
        'html_element_selection': 'main',
        'selector':               selector,
        'input':                  "input#main-content-element"
      };
      window_open_post (home_url, 'width='+window_width+',height='+window_height+',top='+window_top+',left='+window_left+',resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,menubar=no', 'ai-selector', param);
    });

    $("#custom-selectors-button").click (function () {
      var selector      = $("input#custom-selectors").val ();
      var home_url      = $("#ai-settings").data ('home-relative-url');
      var window_top    = screen.availTop;
      var window_left   = screen.availLeft;
      var window_width  = screen.availWidth - 15;
      var window_height = screen.availHeight - 65;

      var param = {
        'html_element_selection': 'adb',
        'selector':               selector,
        'input':                  "input#custom-selectors"
      };
      window_open_post (home_url, 'width='+window_width+',height='+window_height+',top='+window_top+',left='+window_left+',resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,menubar=no', 'ai-selector', param);
    });
  }

  function configure_tab (tab) {

//    if (debug) console.log ("configure_tab:", tab);

    $('#tab-' + tab).addClass ('configured');

    $('#tab-' + tab + ' input[type=submit], #tab-' + tab + ' button.ai-button').button().show ();

    configure_editor (tab);

    $("select#display-type-"+tab).change (function() {
      var block = $(this).attr('id').replace ("display-type-", "");
      process_display_elements (block);
    });

    $("select#block-alignment-"+tab).change (function() {
      var block = $(this).attr('id').replace ("block-alignment-", "");
      var alignment = $("select#block-alignment-"+block+" option:selected").attr('value');
      var automatic_insertion = $("select#display-type-"+block+" option:selected").attr('value');

      if (automatic_insertion != AI_ABOVE_HEADER &&
          (alignment == AI_ALIGNMENT_STICKY_LEFT ||
           alignment == AI_ALIGNMENT_STICKY_RIGHT ||
           alignment == AI_ALIGNMENT_STICKY_TOP || alignment ==
           AI_ALIGNMENT_STICKY_BOTTOM || alignment == AI_ALIGNMENT_STICKY)
         ) {
        $("select#display-type-"+block).val (AI_FOOTER).change ();
      }
      process_display_elements (block);
    });

    $("select#vertical-position-"+tab).change (function() {
      var block = $(this).attr('id').replace ("vertical-position-", "");
      configure_sticky_css (block);
    });

    $("select#horizontal-position-"+tab).change (function() {
      var block = $(this).attr('id').replace ("horizontal-position-", "");
      configure_sticky_css (block);
    });


    $("input#process-php-"+tab).change (function() {
      var block = $(this).attr('id').replace ("process-php-", "");
      process_display_elements (block);
    });
    $("input#show-label-"+tab).change (function() {
      var block = $(this).attr('id').replace ("show-label-", "");
//      process_display_elements (block);
    });
    $("#enable-shortcode-"+tab).change (function() {
      var block = $(this).attr('id').replace ("enable-shortcode-", "");
      process_display_elements (block);
    });
    $("#enable-php-call-"+tab).change (function() {
      var block = $(this).attr('id').replace ("enable-php-call-", "");
      process_display_elements (block);
    });
    $("select#display-for-devices-"+tab).change (function() {
      var block = $(this).attr('id').replace ("display-for-devices-", "");
      process_display_elements (block);
    });
    $("select#scheduling-"+tab).change (function() {
      var block = $(this).attr('id').replace ("scheduling-", "");
      process_display_elements (block);
    });
    $("select#adb-block-action-"+tab).change (function() {
      var block = $(this).attr('id').replace ("adb-block-action-", "");
      process_display_elements (block);
    });


    $("#display-homepage-"+tab).change (function() {
      var block = $(this).attr('id').replace ("display-homepage-", "");
      process_display_elements (block);
    });
    $("#display-category-"+tab).change (function() {
      var block = $(this).attr('id').replace ("display-category-", "");
      process_display_elements (block);
    });
    $("#display-search-"+tab).change (function() {
      var block = $(this).attr('id').replace ("display-search-", "");
      process_display_elements (block);
    });
    $("#display-archive-"+tab).change (function() {
      var block = $(this).attr('id').replace ("display-archive-", "");
      process_display_elements (block);
    });

    $("#client-side-detection-"+tab).change (function() {
      var block = $(this).attr('id').replace ("client-side-detection-", "");
      process_display_elements (block);
    });

    $("#scheduling-on-"+tab).change (function() {
      var block = $(this).attr('id').replace ("scheduling-on-", "");
      process_scheduling_dates (block);
    });

    $("#scheduling-off-"+tab).change (function() {
      var block = $(this).attr('id').replace ("scheduling-off-", "");
      process_scheduling_dates (block);
    });

    $("select#avoid-action-"+tab).change (function() {
      var block = $(this).attr('id').replace ("avoid-action-", "");
      process_display_elements (block);
    });

    process_display_elements (tab);

    $("#exceptions-button-"+tab).button ({
    }).click (function () {
      var block = $(this).attr ("id").replace ("exceptions-button-","");
      $("#block-exceptions-" + block).toggle ();
    });

    $("#show-css-button-"+tab).button ({
    }).show ().click (function () {
      var block = $(this).attr ("id").replace ("show-css-button-","");
      $("#icons-css-code-" + block).toggle ();

      if ($('#icons-css-code-'+block).is(':visible')) {
          $("#show-css-button-"+block+" span").text ("Hide");
          configure_selection_icons (block);
          process_display_elements (block);
      } else {
          $("#show-css-button-"+block+" span").text ("Show");
          $("#sticky-animation-"+block).hide ();
        }
    });

    $("#counting-button-"+tab).button ({
    }).show ().click (function () {
      var block = $(this).attr ("id").replace ("counting-button-","");
      $("#paragraph-counting-" + block).toggle ();
    });

    $("#clearance-button-"+tab).button ({
    }).show ().click (function () {
      var block = $(this).attr ("id").replace ("clearance-button-","");
      $("#paragraph-clearance-" + block).toggle ();
    });

    $("#scheduling-on-"+tab).datepicker ({dateFormat: dateFormat, autoSize: true});
    $("#scheduling-off-"+tab).datepicker ({dateFormat: dateFormat, autoSize: true});

    $(".css-code-"+tab).click (function () {
      var block = $(this).attr('class').replace ("css-code-", "");
      if (!$('#custom-css-'+block).is(':visible')) {
        $("#edit-css-button-"+block).click ();
      }
    });

    $("#edit-css-button-"+tab).button ({
    }).click (function () {
      var block = $(this).attr('id').replace ("edit-css-button-", "");

      $("#css-left-"+block).hide();
      $("#css-right-"+block).hide();
      $("#css-center-"+block).hide();
      $("#css-float-left-"+block).hide();
      $("#css-float-right-"+block).hide();
      $("#css-sticky-left-"+block).hide();
      $("#css-sticky-right-"+block).hide();
      $("#css-sticky-top-"+block).hide();
      $("#css-sticky-bottom-"+block).hide();
      $("#css-sticky-"+block).hide();

      var alignment = $("select#block-alignment-"+block+" option:selected").attr('value');

      if (alignment == AI_ALIGNMENT_DEFAULT) {
        $("#css-none-"+block).hide();
        $("#custom-css-"+block).show().val ($("#css-none-"+block).text ());
        $("select#block-alignment-"+block).val (AI_ALIGNMENT_CUSTOM_CSS).change();
      } else
      if (alignment == AI_ALIGNMENT_LEFT) {
        $("#css-left-"+block).hide();
        $("#custom-css-"+block).show().val ($("#css-left-"+block).text ());
        $("select#block-alignment-"+block).val (AI_ALIGNMENT_CUSTOM_CSS).change();
      } else
      if (alignment == AI_ALIGNMENT_RIGHT) {
        $("#css-right-"+block).hide();
        $("#custom-css-"+block).show().val ($("#css-right-"+block).text ());
        $("select#block-alignment-"+block).val (AI_ALIGNMENT_CUSTOM_CSS).change();
      } else
      if (alignment == AI_ALIGNMENT_CENTER) {
        $("#css-center-"+block).hide();
        $("#custom-css-"+block).show().val ($("#css-center-"+block).text ());
        $("select#block-alignment-"+block).val (AI_ALIGNMENT_CUSTOM_CSS).change();
      } else
      if (alignment == AI_ALIGNMENT_FLOAT_LEFT) {
        $("#css-float-left-"+block).hide();
        $("#custom-css-"+block).show().val ($("#css-float-left-"+block).text ());
        $("select#block-alignment-"+block).val (AI_ALIGNMENT_CUSTOM_CSS).change();
      } else
      if (alignment == AI_ALIGNMENT_FLOAT_RIGHT) {
        $("#css-float-right-"+block).hide();
        $("#custom-css-"+block).show().val ($("#css-float-right-"+block).text ());
        $("select#block-alignment-"+block).val (AI_ALIGNMENT_CUSTOM_CSS).change();
      } else
      if (alignment == AI_ALIGNMENT_STICKY_LEFT) {
        $("#css-sticky-left-"+block).hide();
        $("#custom-css-"+block).show().val ($("#css-sticky-left-"+block).text ());
        $("select#block-alignment-"+block).val (AI_ALIGNMENT_CUSTOM_CSS).change();
      } else
      if (alignment == AI_ALIGNMENT_STICKY_RIGHT) {
        $("#css-sticky-right-"+block).hide();
        $("#custom-css-"+block).show().val ($("#css-sticky-right-"+block).text ());
        $("select#block-alignment-"+block).val (AI_ALIGNMENT_CUSTOM_CSS).change();
      }
      if (alignment == AI_ALIGNMENT_STICKY_TOP) {
        $("#css-sticky-top-"+block).hide();
        $("#custom-css-"+block).show().val ($("#css-sticky-top-"+block).text ());
        $("select#block-alignment-"+block).val (AI_ALIGNMENT_CUSTOM_CSS).change();
      } else
      if (alignment == AI_ALIGNMENT_STICKY_BOTTOM) {
        $("#css-sticky-bottom-"+block).hide();
        $("#custom-css-"+block).show().val ($("#css-sticky-bottom-"+block).text ());
        $("select#block-alignment-"+block).val (AI_ALIGNMENT_CUSTOM_CSS).change();
      } else
      if (alignment == AI_ALIGNMENT_STICKY) {
        $("#css-sticky-"+block).hide();
        $("#custom-css-"+block).show().val ($("#css-sticky-"+block).text ());
        $("select#block-alignment-"+block).val (AI_ALIGNMENT_CUSTOM_CSS).change();
      }
    });


    $("#name-label-"+tab).click (function () {
      var block = $(this).attr('id').replace ("name-label-", "");

      if ($("div#settings-" + block).is (':visible'))

      if (!$('#name-edit-'+block).is(':visible')) {
        $("#name-edit-"+block).css('display', 'table-cell').val ($("#name-label-"+block).text ()).focus ();
        $("#name-label-"+block).hide();
      }
    });

    $("#name-label-container-"+tab).click (function () {
      var block = $(this).attr('id').replace ("name-label-container-", "");

      if ($("div#settings-" + block).is (':visible'))

      if (!$('#name-edit-'+block).is(':visible')) {
        $("#name-edit-"+block).css('display', 'table-cell').val ($("#name-label-"+block).text ()).focus ();
        $("#name-label-"+block).hide();
      }
    });

    $("#name-edit-"+tab).on('keyup keypress', function (e) {
      var keyCode = e.keyCode || e.which;
      ignore_key = true;
      if (keyCode == 27) {
        var block = $(this).attr('id').replace ("name-edit-", "");
        $("#name-label-"+block).show();
        $("#name-edit-"+block).hide();
        ignore_key = false;
      } else if (keyCode == 13) {
          var block = $(this).attr('id').replace ("name-edit-", "");
          $("#name-label-"+block).show().text ($("#name-edit-"+block).val ());
          $("#name-edit-"+block).hide();
          ignore_key = false;
          e.preventDefault();
          return false;
      }
    }).focusout (function() {
      if (ignore_key) {
        var block = $(this).attr('id').replace ("name-edit-", "");
        $("#name-label-"+block).show().text ($("#name-edit-"+block).val ());
        $("#name-edit-"+block).hide();
      }
      ignore_key = true;
    });

    $("#export-switch-"+tab).checkboxButton ().click (function () {
      var block = $(this).attr ("id");
      block = block.replace ("export-switch-","");
      $("#export-container-" + block).toggle ();

      if ($("#export-container-" + block).is(':visible') && !$(this).hasClass ("loaded")) {
        var nonce = $(this).attr ('nonce');
        $("#export_settings_" + block).load (ajaxurl+"?action=ai_ajax_backend&export=" + block + "&ai_check=" + nonce, function (response, status, xhr) {
          if (status == "error" ) {
            $('#ai-error-container').text ('ERROR ' + xhr.status + ': ' + xhr.statusText).show ();
          } else {
              $("#export_settings_" + block).attr ("name", "export_settings_" + block);
              $("#export-switch-"+block).addClass ("loaded");
            }
        });
      }
    });

    $("input#statistics-button-"+tab).checkboxButton ().click (function () {
      disable_auto_refresh_statistics ();
      var block = $(this).attr ("id");
      block = block.replace ("statistics-button-","");
      $("div#statistics-container-" + block).toggle ();
      $("div#settings-" + block).toggle ();

      $("#tab-" + block + ' .ai-toolbars .ai-settings').toggle ();
      $("#ai-main-toolbar-" + block + ' .ai-statistics').toggle ();

      var container = $("div#statistics-container-" + block);
      if (container.is(':visible')) {
        $("#name-label-container-"+block).css ('cursor', 'default');
        if (!$(this).hasClass ('loaded')) {
          $("input#load-custom-range-"+block).click ();
          $(this).addClass ('loaded');
        }
      } else {
          $("#name-label-container-"+block).css ('cursor', 'pointer');
        }
    });

    $("input#adb-statistics-button-"+tab).checkboxButton ().click (function () {
      var block = $(this).attr ("id");
      block = block.replace ("adb-statistics-button-","");
      setTimeout (function() {$("input#load-custom-range-"+block).click ();}, 2);
    });

    configure_statistics_toolbar (tab);

    $("#device-detection-button-"+tab).button ({
    }).show ().click (function () {
      var block = $(this).attr ("id");
      block = block.replace ("device-detection-button-","");
      $("#device-detection-settings-" + block).toggle ();
    });

    $("#lists-button-"+tab).button ({
    }).show ().click (function () {
      var block = $(this).attr ("id");
      block = block.replace ("lists-button-","");
      $("#list-settings-" + block).toggle ();
    });

    $("#manual-button-"+tab).button ({
    }).show ().click (function () {
      var block = $(this).attr ("id");
      block = block.replace ("manual-button-","");
      $("#manual-settings-" + block).toggle ();
    });

    $("#misc-button-"+tab).button ({
    }).show ().click (function () {
      var block = $(this).attr ("id");
      block = block.replace ("misc-button-","");
      $("#misc-settings-" + block).toggle ();
    });

    $("#scheduling-button-"+tab).button ({
    }).show ().click (function () {
      var block = $(this).attr ("id");
      block = block.replace ("scheduling-button-","");
      $("#scheduling-settings-" + block).toggle ();
    });

    $("#preview-button-"+tab).button ({
    }).show ().click (function () {
      var block = $(this).attr ("id");
      block = block.replace ("preview-button-","");

      $(this).blur ();

      var sticky = false;

      var alignment         = $("select#block-alignment-"+block+" option:selected").attr('value');
      var horizontal        = $("select#horizontal-position-"+block+" option:selected").attr('value');
      var vertical          = $("select#vertical-position-"+block+" option:selected").attr('value');
      var horizontal_margin = $("#horizontal-margin-"+block).val ();
      var vertical_margin   = $("#vertical-margin-"+block).val ();
      var animation         = $("select#animation-"+block+" option:selected").attr('value');

      var custom_css = $("#custom-css-"+block).val ();

      var alignment_css = "";
      if (alignment == AI_ALIGNMENT_DEFAULT) {
        alignment_css = $("#css-none-"+block).text ();
      } else
      if (alignment == AI_ALIGNMENT_CUSTOM_CSS) {
        alignment_css = custom_css;
        sticky = is_sticky (custom_css);
      } else
      if (alignment == AI_ALIGNMENT_LEFT) {
        alignment_css = $("#css-left-"+block).text ();
      } else
      if (alignment == AI_ALIGNMENT_RIGHT) {
        alignment_css = $("#css-right-"+block).text ();
      } else
      if (alignment == AI_ALIGNMENT_CENTER) {
        alignment_css = $("#css-center-"+block).text ();
      } else
      if (alignment == AI_ALIGNMENT_FLOAT_LEFT) {
        alignment_css = $("#css-float-left-"+block).text ();
      } else
      if (alignment == AI_ALIGNMENT_FLOAT_RIGHT) {
        alignment_css = $("#css-float-right-"+block).text ();
      } else
      if (alignment == AI_ALIGNMENT_STICKY_LEFT) {
        alignment_css = $("#css-sticky-left-"+block).text ();
      } else
      if (alignment == AI_ALIGNMENT_STICKY_RIGHT) {
        alignment_css = $("#css-sticky-right-"+block).text ();
      }
      if (alignment == AI_ALIGNMENT_STICKY_TOP) {
        alignment_css = $("#css-sticky-top-"+block).text ();
      } else
      if (alignment == AI_ALIGNMENT_STICKY_BOTTOM) {
        alignment_css = $("#css-sticky-bottom-"+block).text ();
      } else
      if (alignment == AI_ALIGNMENT_STICKY) {
        alignment_css = update_sticky_margins ($("#css-sticky-"+block).text (), horizontal_margin, vertical_margin);
        sticky = true;
      }

      var name = $("#name-label-"+block).text ();
      var code  = get_editor_text (block);
      var php   = $("input#process-php-"+block).is(":checked") ? 1 : 0;
      var label = $("input#show-label-"+block).is(":checked") ? 1 : 0;

      var close_button =  $("#close-button-"+block+" option:selected").attr('value');

      if (!sticky) {
        var window_top    = (screen.height / 2) - (820 / 2);
        var window_left   = 100;
        var window_width  = 820;
        var window_height = 820;
      } else {
          var window_top    = screen.availTop;
          var window_left   = screen.availLeft;
          var window_width  = screen.availWidth;
          var window_height = screen.availHeight;
        }

      var nonce = $("#ai-form").attr ('nonce');

      var param = {
        'action':             'ai_ajax_backend',
        'preview':            block,
        'ai_check':           nonce,
        'name':               b64e (name),
        'code':               b64e (code),
        'alignment':          btoa (alignment),
        'horizontal':         btoa (horizontal),
        'vertical':           btoa (vertical),
        'horizontal_margin':  btoa (horizontal_margin),
        'vertical_margin':    btoa (vertical_margin),
        'animation':          btoa (animation),
        'alignment_css':      btoa (alignment_css),
        'custom_css':         btoa (custom_css),
        'php':                php,
        'label':              label,
        'close':              close_button
      };
      window_open_post (ajaxurl, 'width='+window_width+',height='+window_height+',top='+window_top+',left='+window_left+',resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,menubar=no', 'preview', param);
    });

    create_list_selector ('category',     tab);
    create_list_selector ('tag',          tab);
    create_list_selector ('taxonomy',     tab);
    create_list_selector ('id',           tab);
    create_list_editor   ('url',          tab);
    create_list_editor   ('url-parameter',tab);
    create_list_editor   ('referer',      tab);
    create_list_editor   ('ip-address',   tab);
    create_list_selector ('country',      tab);

    $('#tracking-' + tab).checkboxButton ().click (function () {
      var block = $(this).attr('id').replace ("tracking-", "");
      var alignment = $("select#block-alignment-"+block+" option:selected").attr('value');
      var tracking  = !$('#tracking-' + block).next ().find ('.checkbox-icon').hasClass ('on');
      if (tracking && alignment == AI_ALIGNMENT_NO_WRAPPING) $('#tracking-wrapping-warning-' + block).show (); else $('#tracking-wrapping-warning-' + block).hide ();
    });

    $('#simple-editor-' + tab).checkboxButton ().click (function () {
      var block = $(this).attr('id').replace ("simple-editor-", "");
      if (block == active_tab) {
        $('#ai-tab-container .simple-editor-button').click();
      }
    });
    // Switch to simple editor if the button was pressed before the tab was configured
    if ($('#simple-editor-' + tab).is(":checked")) {
      switch_editor (tab, true);
      $('#simple-editor-' + tab).next ("label").find ('.checkbox-icon').addClass("on");
    }

    $('#process-php-' + tab).checkboxButton ();
    $('#disable-insertion-' + tab).checkboxButton ();

    $('#ai-misc-container-' + tab).tabs();
    $('#ai-misc-tabs-' + tab).show();

    $('#ai-devices-container-' + tab).tabs();
    $('#ai-devices-tabs-' + tab).show();

    $("#tools-button-"+tab).click (function () {
      if (!$(this).find ('.checkbox-icon').hasClass("on")) {
        $('label.rotation-button').each (function () {
          if ($(this).find ('.checkbox-icon').hasClass("on")) {
            $(this).prev ().click ();
          }
        });

        $('label.code-generator-button').each (function () {
          if ($(this).find ('.checkbox-icon').hasClass("on")) {
            $(this).prev ().click ();
          }
        });

        $('code-generator').hide ();
      }

      $('.ai-tools-toolbar').toggle();
      $('label.tools-button').find ('.checkbox-icon').toggleClass("on");
    });

    $('#ai-code-generator-container-' + tab).tabs();

    $("select#adsense-type-"+tab).change (function() {
      var block = $(this).attr('id').replace ("adsense-type-", "");
      process_adsense_elements (block);
    });

    $("select#adsense-size-"+tab).change (function() {
      var block = $(this).attr('id').replace ("adsense-size-", "");
      process_adsense_elements (block);
    });

    process_adsense_elements (tab);

    $("#code-generator-"+tab).click (function () {
      var block = $(this).attr('id').replace ("code-generator-", "");
      $('#ai-code-generator-container-' + block).toggle();
      $(this).next ("label").find ('.checkbox-icon').toggleClass("on");
    });

    $("#visual-editor-"+tab).click (function () {
      var block = $(this).attr('id').replace ("visual-editor-", "");

      var code = b64e (get_editor_text (block));
      var php =  $("input#process-php-" + block).is(":checked") ? 1 : 0;

      var window_width = 820;
      var window_height = 870;
      var window_left  = 100;
      var window_top   = (screen.height / 2) - (window_height / 2);
      var nonce = $("#ai-form").attr ('nonce');
      var param = {'action': 'ai_ajax_backend', 'edit': block, 'ai_check': nonce, 'code': code, 'php': php};
      window_open_post (ajaxurl, 'width='+window_width+',height='+window_height+',top='+window_top+',left='+window_left+',resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,menubar=no', 'edit', param);
    });

    $("#select-image-button-"+tab).click (function (event) {
      $(this).blur ();

      var block = $(this).attr('id').replace ("select-image-button-", "");
      var frame;

      event.preventDefault();

      if (frame) {
        frame.open();
        return;
      }

      frame = wp.media ({
        title: 'Select or upload banner image',
        button: {
          text: 'Use this image'
        },
        multiple: false  // Set to true to allow multiple files to be selected
      });

      frame.on ('open', function(){
//        var selected = $('#banner-image-' + block).attr ('src');
//        if (selected) {
//          var selection = frame.state().get ('selection');
//          var id = $('#banner-image-' + block).attr ('data-id');
//          selection.add (wp.media.attachment (id));
//        }
      });

      frame.on ('select', function() {
        var attachment = frame.state().get('selection').first().toJSON();
        console.log ('attachment', attachment);
        $('#banner-image-' + block).attr ('src', attachment.url);
        $('#banner-image-url-' + block).val (attachment.url).trigger ("input");
      });

      frame.open();
    });

    $("#select-placeholder-button-"+tab).click (function (event) {
      $(this).blur ();

      var block = $(this).attr('id').replace ("select-placeholder-button-", "");
      var image_url = $('#banner-image-' + block).attr ('src');

      var window_width = 820;
      var window_height = 870;
      var window_left  = 100;
      var window_top   = (screen.height / 2) - (870 / 2);
      var nonce = $("#ai-form").attr ('nonce');
      var param = {'action': 'ai_ajax_backend', 'placeholder': image_url, 'block': block, 'ai_check': nonce};
      window_open_post (ajaxurl, 'width='+window_width+',height='+window_height+',top='+window_top+',left='+window_left+',resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,menubar=no', 'preview', param);
    });

    $("#banner-image-url-" + tab).on ('input', function() {

      var block = $(this).attr('id').replace ("banner-image-url-", "");
      var image = $('#banner-image-' + block);

      var new_image_src = $(this).val ();
      if (new_image_src == '') {
//        new_image_src = '//:0';
        image.hide ();
        $('div#tab-banner-' + block + ' table.ai-settings-table').css ('position', 'relative');
      }

      image.attr ('src', new_image_src).load (function () {
        image.show ();
        $('div#tab-banner-' + block + ' table.ai-settings-table').css ('position', 'inherit');
        $(this).closest ('.ai-banner').removeClass ('ai-banner-top');
        var width   = this.naturalWidth;
        var height  = this.naturalHeight;

        if (width / height > 2 && width > 300) {
          $(this).closest ('.ai-banner').addClass ('ai-banner-top');
        }
      })
      .error (function() {
        if (image.is(':visible')) {
//          image.hide ().attr ('src', '//:0');
          image.hide ().attr ('src', '');
          $('div#tab-banner-' + block + ' table.ai-settings-table').css ('position', 'relative');
        }
      });

    });

    $("#banner-url-" + tab).on ('input', function() {
      var block = $(this).attr('id').replace ("banner-url-", "");
      var url = $(this).val ().trim();
      if (url == '') $('#banner-link-' + block).removeAttr ('href'); else
        $('#banner-link-' + block).attr ('href', $(this).val ());
    });

    $("#import-code-"+tab).click (function () {
      $(this).next ("label").find ('.checkbox-icon').addClass("on");

      var block = $(this).attr('id').replace ("import-code-", "");
      var nonce = $("#ai-form").attr ('nonce');

      $.post (ajaxurl, {'action': 'ai_ajax_backend', 'ai_check': nonce, 'import-code': b64e (get_editor_text (block))}
      ).done (function (data) {
        if (data != '') {
          $('#ai-error-container').hide ();

          try {
            var code_data = JSON.parse (data);
          } catch (error) {
            console.log ("AI IMPORT CODE ERROR:", data);
            $('#ai-error-container').text (data).show ();
          }

          if (typeof code_data !== "undefined" && typeof code_data ['type'] !== "undefined") {

            if (debug) console.log ("AI IMPORT CODE:", code_data);

            var code_type = code_data ['type'];

            $("#ai-code-generator-container-" + block).tabs ({active: code_type == AI_CODE_UNKNOWN ? AI_CODE_BANNER : code_type});

            switch (code_type) {
              case AI_CODE_BANNER:
                $("#banner-image-url-" + block).val (code_data ['image']).trigger ('input');
                $("#banner-url-" + block).val (code_data ['link']).trigger ('input');
                $("#open-new-tab-" + block).attr('checked', code_data ['target'] == '_blank');
                break;
              case AI_CODE_ADSENSE:
                $("#adsense-comment-" + block).val (code_data ['adsense-comment']);
                $("#adsense-publisher-id-" + block).val (code_data ['adsense-publisher-id']);
                $("#adsense-ad-slot-id-" + block).val (code_data ['adsense-ad-slot-id']);

                $("#adsense-type-" + block).val (code_data ['adsense-type']);
                $("#adsense-size-" + block).val (code_data ['adsense-size']);

                var ad_size = '';
                if (code_data ['adsense-width'] != '' && code_data ['adsense-height'] != '') {
                  ad_size = code_data ['adsense-width'] + 'x' + code_data ['adsense-height'];
                }
                $('#tab-adsense-' + block + ' .adsense-ad-size.fixed').parent ().find ('.scombobox-display').val (ad_size);

                $("#adsense-amp-" + block).val (code_data ['adsense-amp']);

                $("#adsense-layout-" + block).val (code_data ['adsense-layout']);
                $("#adsense-layout-key-" + block).val (decodeURIComponent (code_data ['adsense-layout-key']));

                if ($("#adsense-size-" + block).val () == AI_ADSENSE_SIZE_FIXED_BY_VIEWPORT) {
                  $('#tab-adsense-' + block + ' tr.adsense-viewport').each (function (index) {
                    var width  = code_data ['adsense-sizes'][index][0];
                    var height = code_data ['adsense-sizes'][index][1];

                    var ad_size = '';
                    if (width != '' && height != '') {
                      ad_size = width + 'x' + height;
                    }

                    $(this).find ('.adsense-ad-size').parent ().find ('.scombobox-display').val (ad_size);
                  });
                }
                process_adsense_elements (block);
                break;
              case AI_CODE_UNKNOWN:
                break;
            }
          }
        }
      }).fail (function (xhr, status, error) {
        console.log ("AI IMPORT CODE ERROR:", xhr.status, xhr.statusText);
        $('#ai-error-container').text ('ERROR ' + xhr.status + ': ' + xhr.statusText).show ();
      }).always (function() {
        $("#import-code-"+block).next ("label").find ('.checkbox-icon').removeClass("on");
      });
    });

    $("#generate-code-"+tab).click (function () {
      $('#ai-error-container').hide ();
      $(this).next ("label").find ('.checkbox-icon').addClass("on");

      var block = $(this).attr('id').replace ("generate-code-", "");
      var nonce = $("#ai-form").attr ('nonce');
      var code_type = $("#ai-code-generator-container-" + block).tabs('option', 'active');
      var code_data = {'action': 'ai_ajax_backend', 'ai_check': nonce, 'generate-code': code_type};

      switch (code_type) {
        case AI_CODE_BANNER:
          code_data ['image'] = $("#banner-image-url-" + block).val ();
          code_data ['link']  = $("#banner-url-" + block).val ();

          if ($("#open-new-tab-" + block).is(":checked"))
          code_data ['target']  = '_blank';
          break;
        case AI_CODE_ADSENSE:
          code_data ['block']                 = block;
          code_data ['adsense-comment']       = $("#adsense-comment-" + block).val ();
          code_data ['adsense-publisher-id']  = $("#adsense-publisher-id-" + block).val ();
          code_data ['adsense-ad-slot-id']    = $("#adsense-ad-slot-id-"   + block).val ();
          code_data ['adsense-type']          = parseInt ($("select#adsense-type-" + block +" option:selected").attr ('value'));
          code_data ['adsense-size']          = parseInt ($("select#adsense-size-" + block +" option:selected").attr ('value'));

          var ad_size = $('#tab-adsense-' + block + ' .adsense-ad-size.fixed').parent ().find ('.scombobox-display').val ().trim ().toLowerCase ().split ('x');
          code_data ['adsense-width']         = '';
          code_data ['adsense-height']        = '';
          if (ad_size.length == 2) {
            code_data ['adsense-width']         = parseInt (ad_size [0]);
            code_data ['adsense-height']        = parseInt (ad_size [1]);
          }

          code_data ['adsense-amp']           = parseInt ($("select#adsense-amp-" + block +" option:selected").attr ('value'));
          code_data ['adsense-layout']        = $("#adsense-layout-"       + block).val ();
          code_data ['adsense-layout-key']    = $("#adsense-layout-key-"   + block).val ();

          if (code_data ['adsense-size'] == AI_ADSENSE_SIZE_FIXED_BY_VIEWPORT) {
            var viewport_sizes = new Array();
            $('#tab-adsense-' + block + ' tr.adsense-viewport').each (function (index) {
              var ad_size = $(this).find ('.adsense-ad-size').parent ().find ('.scombobox-display').val ().trim ().toLowerCase ().split ('x');
              var adsense_size = {'width': '', 'height': ''};
              if (ad_size.length == 2) {
                adsense_size = {'width': parseInt (ad_size [0]), 'height': parseInt (ad_size [1])};
              }
              viewport_sizes.push (adsense_size);
            });
            code_data ['adsense-viewports'] = viewport_sizes;
          }
          break;
        case AI_CODE_UNKNOWN:
//          if (debug) console.log ("AI GENERATE CODE:", code_type);
          break;
      }

      if (debug) {
        console.log ("AI GENERATE CODE:", code_type);
        console.log (code_data);
      }

      $.post (ajaxurl, code_data
      ).done (function (code_data) {
        if (code_data != '') {
          var code = JSON.parse (code_data);
          if (typeof code !== "undefined")
            set_editor_text (block, code);
        }
      }).fail (function (xhr, status, error) {
        console.log ("AI GENERATE CODE ERROR:", xhr.status, xhr.statusText);
        $('#ai-error-container').text ('ERROR ' + xhr.status + ': ' + xhr.statusText).show ();
      }).always (function() {
        $("#generate-code-"+block).next ("label").find ('.checkbox-icon').removeClass("on");
      });
    });

    $("#clear-block-"+tab).click (function () {
      paste_from_clipboard (true, true, true, true);
    });

    $("#copy-block-"+tab).click (function () {
      copy_to_clipboard ();
    });

    $("#paste-name-"+tab).click (function () {
      paste_from_clipboard (true, false, false, false);
    });

    $("#paste-code-"+tab).click (function () {
      paste_from_clipboard (false, true, false, false);
    });

    $("#paste-settings-"+tab).click (function () {
      paste_from_clipboard (false, false, true, false);
    });

    $("#paste-block-"+tab).click (function () {
      paste_from_clipboard (true, true, true, false);
    });

    $("#rotation-"+tab).click (function () {
      var block = $(this).attr('id').replace ("rotation-", "");
      var rotation_container = $('#ai-rotation-container-' + block);
      $(this).next ("label").find ('.checkbox-icon').toggleClass("on");

      rotation_container.toggle();

      var option_tabs = rotation_container.tabs ();

      var ul = option_tabs.find ("ul");

      if (rotation_container.is(':visible')) {
        rotation_container.data ('code', b64e (get_editor_text (block)));
        rotation_container.data ('option', 1);

        add_rotate_options (block, 1);
        option_tabs.tabs ("option", "active", 0);

        $('input[name=ai_save]').css ('color', '#f00');
        $('.ai-rotation-warning').show ();

        setTimeout (function() {import_rotation_code (block);}, 5);
      } else {
//          set_editor_text (block, b64d (rotation_container.data ('code')));
          generate_rotatation_code (block);

          ul.find ("li").remove ();
          var div = option_tabs.find ("div.rounded").remove ();
        }
    });

    $("#add-option-"+tab).click (function () {
      var block = $(this).attr('id').replace ("add-option-", "");
      add_rotate_options (block, 1);

      $('#ai-rotation-container-' + block).find ("ul").find ("li").slice (- 1).click ();
    });

    $("#remove-option-"+tab).click (function () {
      var block = $(this).attr('id').replace ("remove-option-", "");
      remove_rotate_option (block, $('#ai-rotation-container-' + block).tabs ("option", "active"));
    });

    $("#tab-" + tab + " .adsense-list").click (function () {
      $(this).blur ();

      var container = $("#adsense-list-container");

      container.toggle ();

      if (container.is(':visible')) {
        reload_adsense_list (false);
      }
    });

    $("select#html-element-insertion-"+tab).change (function() {
      var html_element_insertion = $("select#html-element-insertion-"+tab+" option:selected").attr('value');

      if (html_element_insertion == AI_HTML_INSERTION_SEREVR_SIDE)
        $("#server-side-insertion-"+tab).hide (); else
          $("#server-side-insertion-"+tab).show ();
    });

    $("#tab-" + tab + " .adsense-ad-size").scombobox({
      showDropDown: false,
      invalidAsValue: true,
      animation: {
        duration: 50,
      }
    });

    $("select#close-button-" + tab).change (function () {
      var block = $(this).attr('id').replace ("close-button-", "");
      $("select#close-button2-"+block+"").val ($("select#close-button-"+block+" option:selected").attr('value'));
    });

    $("select#close-button2-" + tab).change (function () {
      var block = $(this).attr('id').replace ("close-button2-", "");
      $("select#close-button-"+block+"").val ($("select#close-button2-"+block+" option:selected").attr('value'));
    });

    $("#html-elements-button-"+tab).click (function () {
      var block = $(this).attr('id').replace ("html-elements-button-", "");

      var selector      = $("input#html-elements-" + block).val ();
      var home_url      = $("#ai-settings").data ('home-relative-url');
      var window_top    = screen.availTop;
      var window_left   = screen.availLeft;
      var window_width  = screen.availWidth - 15;
      var window_height = screen.availHeight - 65;

      var param = {
        'html_element_selection': block,
        'selector':               selector,
        'input':                  "input#html-elements-" + block
      };
      window_open_post (home_url, 'width='+window_width+',height='+window_height+',top='+window_top+',left='+window_left+',resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,menubar=no', 'ai-selector', param);
    });
  }

  function configure_sticky_css (block) {
    var horizontal_position = $("select#horizontal-position-"+block+" option:selected").attr('value');
    var selected_horizontal_position = $("select#horizontal-position-"+block+" option:selected");

    var vertical_position   = $("select#vertical-position-"+block+" option:selected").attr('value');
    var selected_vertical_position   = $("select#vertical-position-"+block+" option:selected");

    var custom_vertical_position_css = selected_vertical_position.data ('css-' + horizontal_position);

    if (typeof custom_vertical_position_css != 'undefined') var vertical_position_css = custom_vertical_position_css; else
      var vertical_position_css = selected_vertical_position.data ('css');

    var custom_horizontal_position_css = selected_horizontal_position.data ('css-' + vertical_position);

    if (typeof custom_horizontal_position_css != 'undefined') var horizontal_position_css = custom_horizontal_position_css; else
      var horizontal_position_css = selected_horizontal_position.data ('css');

    $('#css-sticky-' + block + ' .ai-sticky-css').text (vertical_position_css + horizontal_position_css);

    check_insertion (block);
  }

  function check_insertion (block) {
    $('#sticky-scroll-warning-' + block).hide ();
    var automatic_insertion = $("select#display-type-"+block+" option:selected").attr('value');
    var alignment_style     = $("select#block-alignment-"+block+" option:selected").attr('value');
    var vertical_position   = $("select#vertical-position-"+block+" option:selected").attr('value');

    if (alignment_style == AI_ALIGNMENT_STICKY && vertical_position == AI_SCROLL_WITH_THE_CONTENT && automatic_insertion != AI_ABOVE_HEADER && automatic_insertion != AI_DISABLED) {
      $('#sticky-scroll-warning-' + block).show ();
    }
  }

  function configure_selection_icons (block) {
    var css_code_container = $('#icons-css-code-'+block);
    if (!css_code_container.hasClass ('configured')) {
      var titles = new Array();
      $("select#display-type-"+block).imagepicker({hide_select: false}).find ('option').each (function (index) {
        titles.push ($(this).data ('title'));
      });
      $("select#display-type-"+block+" + ul").appendTo("#automatic-insertion-"+block).css ('padding-top', '10px').find ('li').each (function (index) {
        $(this).attr ('title', titles [index]);
      });

      var titles = new Array();
      $("select#block-alignment-"+block).imagepicker({hide_select: false}).find ('option').each (function (index) {
        titles.push ($(this).data ('title'));
      });
      $("select#block-alignment-"+block+" + ul").appendTo("#alignment-style-"+block).css ('padding-top', '10px').find ('li').each (function (index) {
        $(this).attr ('title', titles [index]);
      });

      var titles = new Array();
      $("select#horizontal-position-"+block).imagepicker({hide_select: false}).find ('option').each (function (index) {
        titles.push ($(this).data ('title'));
      });
      $("select#horizontal-position-"+block+" + ul").appendTo("#horizontal-positions-"+block).css ('padding-top', '10px').find ('li').each (function (index) {
        $(this).attr ('title', titles [index]);
      });

      var titles = new Array();
      $("select#vertical-position-"+block).imagepicker({hide_select: false}).find ('option').each (function (index) {
        titles.push ($(this).data ('title'));
      });
      $("select#vertical-position-"+block+" + ul").appendTo("#vertical-positions-"+block).css ('padding-top', '10px').find ('li').each (function (index) {
        $(this).attr ('title', titles [index]);
      });

//      var titles = new Array();
//      $("select#close-button-"+block).imagepicker({hide_select: false}).find ('option').each (function (index) {
//        titles.push ($(this).data ('title'));
//      });
//      $("select#close-button2-"+block+" + ul").appendTo("#close-buttons-"+block).css ('padding-top', '10px').find ('li').each (function (index) {
//        $(this).attr ('title', titles [index]);
//      });

      css_code_container.addClass ('configured');
    }
  }

  function import_rotation_code (block) {
    $("#rotation-"+block).next ("label").find ('.checkbox-icon').addClass("active");

    var nonce = $("#ai-form").attr ('nonce');

    $.post (ajaxurl, {'action': 'ai_ajax_backend', 'ai_check': nonce, 'import-rotation-code': b64e (get_editor_text (block))}
    ).done (function (data) {
      if (data != '') {
        var code_data = JSON.parse (data);
        if (typeof code_data !== "undefined" && typeof code_data ['options'] !== "undefined") {
          $('#ai-error-container').hide ();

          var options = code_data ['options'].length;

          if (debug) {
            console.log ("AI IMPORT ROTATION CODE:", options);
            console.log ("  OPTIONS:", code_data ['options']);
          }

          var rotation_container = $('#ai-rotation-container-' + block);
          rotation_container.find ("ul").find ("li").remove ();
          rotation_container.find ("div.rounded").remove ();

          var tabs = options;
          if (tabs < 1) tabs = 1;
          if (tabs > 18) tabs = 18;

          add_rotate_options (block, tabs);

          rotation_container.find ('ul li').each (function (index) {
            if (index < options) $(this).data ('code', b64e (code_data ['options'][index]['code'])); else
              $(this).data ('code', b64e (''));
          });

          rotation_container.tabs ("option", "active", 0);

          set_editor_text (block, code_data ['options'][0]['code']);

          rotation_container.find ('input.option-name').each (function (index) {
            if (index < options) $(this).val (code_data ['options'][index]['name']);
          });
          rotation_container.find ('input.option-share').each (function (index) {
            if (index < options) $(this).val (code_data ['options'][index]['share']);
          });
          rotation_container.find ('input.option-time').each (function (index) {
            if (index < options) $(this).val (code_data ['options'][index]['time']);
          });
        }
      }
    }).fail (function (xhr, status, error) {
      console.log ("AI IMPORT ROTATION CODE ERROR:", xhr.status, xhr.statusText);
      $('#ai-error-container').text ('ERROR ' + xhr.status + ': ' + xhr.statusText).show ();

      var rotation_container = $('#ai-rotation-container-' + block);
      set_editor_text (block, b64d (rotation_container.data ('code')));
      rotation_container.hide();
      $("#rotation-" + block).next ("label").find ('.checkbox-icon').removeClass("on");

      rotation_container.find ("ul").find ("li").remove ();
      rotation_container.find ("div.rounded").remove ();
    }).always (function() {
      $("#rotation-"+block).next ("label").find ('.checkbox-icon').removeClass("active");
    });
  }

  function generate_rotatation_code (block) {
    $("#rotation-"+block).next ("label").find ('.checkbox-icon').addClass("active");

    var rotation_container = $('#ai-rotation-container-' + block);
    var option = rotation_container.tabs ("option", "active") + 1;

    $(('#option-' + block + '-' + option)).data ('code', b64e (get_editor_text (block)));

    var nonce = $("#ai-form").attr ('nonce');

    var rotation_data = [];
    rotation_container.find ("div.rounded").each (function (index) {
      var code_data = $('#option-' + block + '-' + (index + 1)).data ('code');
      var code = typeof code_data == 'undefined' ? '' : b64d (code_data);
      var option_data = {'name': $(this).find ('input.option-name').val (), 'share': $(this).find ('input.option-share').val (), 'time': $(this).find ('input.option-time').val (), 'code': code};

      rotation_data.push (option_data);
    });

    if (debug) console.log ('ROTATION DATA:', rotation_data);

    $.post (ajaxurl, {'action': 'ai_ajax_backend', 'ai_check': nonce, 'generate-rotation-code': b64e (JSON.stringify (rotation_data))}
    ).done (function (data) {
      $('#ai-error-container').hide ();

      if (data != '') {
        var rotation_code = JSON.parse (data);
        if (typeof rotation_code !== "undefined") {
          if (debug) console.log ('ROTATION CODE:', rotation_code);
          set_editor_text (block, rotation_code);
        }
      }

    }).fail (function (xhr, status, error) {
      console.log ("AI GENERATE ROTATION CODE ERROR:", xhr.status, xhr.statusText);
      $('#ai-error-container').text ('ERROR ' + xhr.status + ': ' + xhr.statusText).show ();

      var rotation_container = $('#ai-rotation-container-' + block);
      set_editor_text (block, b64d (rotation_container.data ('code')));
      rotation_container.hide();
      $("#rotation-" + block).next ("label").find ('.checkbox-icon').removeClass("on");

      rotation_container.find ("ul").find ("li").remove ();
      rotation_container.find ("div.rounded").remove ();
    }).always (function() {
      $("#rotation-"+block).next ("label").find ('.checkbox-icon').removeClass("active");

      $('input[name=ai_save]').css ('color', '#555');
      $('.ai-rotation-warning').hide ();
    });
  }

  function add_rotate_options (block, new_options) {
    var rotation_container = $('#ai-rotation-container-' + block);
    var ul = rotation_container.find ("ul");
    var options = rotation_container.find ('ul >li').length;

    var rotation_tabs = $('#rotation-tabs');
    var li  = rotation_tabs.find ("li");
    var div = rotation_tabs.find ("div.rounded");

    var insertion = 0;

    for (option = options + 1; option <= options + new_options; option ++) {
      if (option > 18) break;

      var new_li = li.clone ().show ();
      new_li.find ("a").attr ('href', '#tab-option-' + block + '-' + option).text (String.fromCharCode (64 + option));
      new_li.attr ('id', 'option-' + block + '-' + option).appendTo (ul).data ('code', b64e (''));

      new_li.click (function () {
        var rotation_container = $(this).closest ('.ai-rotate');
        var block = rotation_container.attr('id').replace ("ai-rotation-container-", "");
        var old_option = rotation_container.data ('option');
        var new_option = $(this).attr('id').replace ("option-" + block + "-", "");
        rotation_container.data ('option', new_option);

        if (debug) console.log ('OPTION CHANGE:', old_option, '=>', new_option);

        $(('#option-' + block + '-' + old_option)).data ('code', b64e (get_editor_text (block)));
        set_editor_text (block, b64d ($(this).data ('code')));
      });

      div.clone ().show ().attr ('id', 'tab-option-' + block + '-' + option).appendTo (rotation_container);

      rotation_container.tabs ("refresh");
    }

    rotation_container.tabs ("option", "active", option - 2);
  }

  function remove_rotate_option (block, option) {
    var rotation_container = $('#ai-rotation-container-' + block);
    var options = rotation_container.find ('ul >li').length;

    if (options == 1) return;

    var ul = rotation_container.find ("ul");

    ul.find ("li").slice (option, option + 1).remove ();
    var div = rotation_container.find ("div.rounded").slice (option, option + 1).remove ();

    rotation_container.find ('ul li').each (function (index) {
      var option = index + 1;
      $(this).attr ('id', 'option-' + block + '-' + option).find ("a").attr ('href', '#tab-option-' + block + '-' + option).text (String.fromCharCode (64 + option));
    });

    rotation_container.find ("div.rounded").each (function (index) {
      var option = index + 1;
      $(this).attr ('id', 'tab-option-' + block + '-' + option);
    });

    rotation_container.tabs ("refresh");

    var new_option = option == 0 ? 0 : option - 1;
    active_li = $('#option-' + block + '-' + (new_option + 1));
    set_editor_text (block, b64d (active_li.data ('code')));
    ul.closest ('.ai-rotate').data ('option', new_option + 1);
  }

  function create_list_selector (element_name_prefix, index) {
    var select = $('#'+element_name_prefix+'-select-'+index);
    if (select.length !== 0) {
      var button = $('#'+element_name_prefix+'-button-'+index);
      button.click (function () {

        if (!select.hasClass ('multi-select')) {
          var options = select.find ('option');
          if (options.length == 0) {
            var nonce = $("#ai-form").attr ('nonce');

            var select_data = select.data ('select');
            var data = typeof select_data == 'undefined' ? '' : select_data;

            $('#ai-loading').show ();
            button.find ('span.ui-button-text').addClass ('ai-button-active');
            $.get (ajaxurl + '?action=ai_ajax_backend&list-options=' + element_name_prefix + '&data=' + data + '&ai_check=' + nonce, function (data) {
              if (data != '') {
                select.html (data);
                create_multi_select (select, element_name_prefix, index);
                update_selection_from_list ($('#'+element_name_prefix+'-list-'+index), element_name_prefix, true);
              }

            }).fail (function (xhr, status, error) {
              var message = "Error loading " + element_name_prefix + " options: " + xhr.status + " " + xhr.statusText ;
              console.log (message);
            })
            .always (function () {
              $('#ai-loading').hide ();
              button.find ('span.ui-button-text').removeClass ('ai-button-active');
            });

          } else create_multi_select (select, element_name_prefix, index);

        }
        update_selection_from_list ($('#'+element_name_prefix+'-list-'+index), element_name_prefix, true);
      });

      $('#'+element_name_prefix+'-list-'+index).focusout (function () {
        update_selection_from_list ($(this), element_name_prefix, false);
      });
    }
  }

  function update_list_from_selection (select_element, element_name_prefix) {

    var ms = select_element.$element;
    var ms_val = ms.val();
    if (ms_val != null) var ms_val = ms_val.join (', ');
    var index = ms.attr ('id').replace (element_name_prefix+'-select-','');
    var list = $('#'+element_name_prefix+'-list-'+index);

    var custom_data = list.attr ('data-custom');

    if (typeof custom_data != 'undefined' && custom_data != '') {
      if (ms_val != null) {
        if (ms_val != '') ms_val = ms_val + ', ';
        ms_val = ms_val + custom_data;
      } else ms_val = custom_data;
    }

    list.attr ('value', ms_val);
    select_element.qs1.cache();
    select_element.qs2.cache();
  }

  function update_selection_from_list (list_element, element_name_prefix, toggle) {

    Array.prototype.diff = function (a) {
        return this.filter(function (i) {
            return a.indexOf(i) === -1;
        });
    };

    var index = list_element.attr ('id').replace (element_name_prefix+'-list-','');
    var selection_container = $('#ms-'+element_name_prefix+'-select-'+index);
    if (toggle) selection_container.toggle();
    if (selection_container.is(':visible')) {
      var list_items = list_element.attr ('value').split (',').map (Function.prototype.call, String.prototype.trim);

      if (list_element.hasClass ('ai-list-filter'))
        for (var i = 0; i < list_items.length; i++) {
          list_items [i] = list_items [i].replace (/ /g , '-').replace (/[\!\@\#\$%\^&\*\(\)\=\+\{\}\|\[\]\\\;\'\:\"\.\/\?]/g , '');
        }

      if (list_element.hasClass ('ai-list-uppercase'))
        list_items = list_items.map (Function.prototype.call, String.prototype.toUpperCase); else
          list_items = list_items.map (Function.prototype.call, String.prototype.toLowerCase);

      // Set multiSelect
      $('#'+element_name_prefix+'-select-'+index).multiSelect ('deselect_all').multiSelect ('select', list_items).multiSelect('refresh');

      if (list_element.hasClass ('ai-list-custom')) {
        var custom_values = list_items;
        var selected_values = $('#'+element_name_prefix+'-select-'+index).val ();
        if (selected_values != null) custom_values = list_items.diff (selected_values);

        if (custom_values != null) var custom_values = custom_values.join (', ');

        list_element.attr ('data-custom', custom_values);

        // Set multiSelect again to add custom items
        $('#'+element_name_prefix+'-select-'+index).multiSelect ('deselect_all').multiSelect ('select', list_items).multiSelect('refresh');
      }
    }                                               }

  function create_multi_select (select, element_name_prefix, index) {
    select.addClass ('multi-select');

    select.multiSelect ({
      selectableHeader: "<input type='text' class='search-input' autocomplete='off' placeholder='Search...'>",
      selectedHeader: "Selected Countries",
      afterInit: function(ms){
        var that = this,
            $selectableSearch = that.$selectableUl.prev(),
            $selectionSearch = that.$selectionUl.prev(),
            selectableSearchString = '#'+that.$container.attr('id')+' .ms-elem-selectable:not(.ms-selected)',
            selectionSearchString = '#'+that.$container.attr('id')+' .ms-elem-selection.ms-selected';

        that.qs1 = $selectableSearch.quicksearch (selectableSearchString)
        .on('keydown', function(e){
          if (e.which === 40){
            that.$selectableUl.focus();
            return false;
          }
        });

        that.qs2 = $selectionSearch.quicksearch (selectionSearchString)
        .on('keydown', function(e){
          if (e.which == 40){
            that.$selectionUl.focus();
            return false;
          }
        });
      },
      afterSelect: function(values){
        update_list_from_selection (this, element_name_prefix);
      },
      afterDeselect: function(values){
        update_list_from_selection (this, element_name_prefix);
      }
    });
    $('#ms-'+element_name_prefix+'-select-' + index).hide();
  }

  function create_list_editor (element_name_prefix, index) {
    var editor  = $('#'+element_name_prefix+'-editor-'+index);
    var list    = $('#'+element_name_prefix+'-list-'+index);
    if (editor.length !== 0) {
      $('#'+element_name_prefix+'-button-'+index).click (function () {
        update_editor_from_list (list, element_name_prefix, true);
      });

      editor.focusout (function () {
        update_list_from_editor (editor, element_name_prefix)
      });

      list.focusout (function () {
        if (editor.is(':visible'))
          update_editor_from_list ($(this), element_name_prefix, false);
      });
    }
  }

  function clean_url_list (list_element, list_items) {

    var clean_protocol = list_element.hasClass ('ai-clean-protocol');
    var clean_domain   = list_element.hasClass ('ai-clean-domain');
    var only_domain    = list_element.hasClass ('ai-only-domain');
    var sort_list      = list_element.hasClass ('ai-list-sort');

    function onlyUnique (value, index, self) {
        return self.indexOf (value) === index;
    }

    list_items = list_items.filter (onlyUnique);

    var clean_list_items = [];

    for (var i = 0; i < list_items.length; i++) {
      var list_item = list_items [i];

      if (clean_protocol && list_item.indexOf ('http') == 0) {
        list_item = list_item.replace ('http://', '');
        list_item = list_item.replace ('https://', '');

        var slash = list_item.indexOf ("/");

        if (clean_domain) {
          if (slash > 0) {
            list_item = list_item.substring (slash);
          } else list_item = '';
        } else
        if (only_domain) {
          if (slash > 0) {
            list_item = list_item.substring (0, slash);
          }
        }
      }

      if (list_item != '') clean_list_items.push (list_item);
    }

    if (sort_list) {
      clean_list_items.sort();
    }

    return clean_list_items;
  }

  function update_editor_from_list (list_element, element_name_prefix, toggle) {
    var index = list_element.attr ('id').replace (element_name_prefix+'-list-','');
    var editor = $('#'+element_name_prefix+'-editor-'+index);
    if (toggle) editor.toggle();
    if (editor.is(':visible')) {

      var list = list_element.attr ('value');
      var list_separator = ',';

      if (list_element.hasClass ('ai-list-space')) {
        if (list.indexOf (' ') > - 1 && list.indexOf (',') == - 1) list_separator = ' ';
      }

      var list_items = list.split (list_separator).map (Function.prototype.call, String.prototype.trim);

      clean_list_items = clean_url_list (list_element, list_items);

      editor.val (clean_list_items.join ("\n"));
    } else update_list_from_editor (editor, element_name_prefix)
  }

  function update_list_from_editor (editor, element_name_prefix) {
    var list_items = editor.val ().split ("\n").map (Function.prototype.call, String.prototype.trim);

    var index = editor.attr ('id').replace (element_name_prefix+'-editor-','');
    var list_element = $('#'+element_name_prefix+'-list-'+index);

    clean_list_items = clean_url_list (list_element, list_items);

    list_element.attr ('value', clean_list_items.join (', '));
  }

  function configure_hidden_tab () {
    var current_tab;
    var tab;

    if (debug) console.log ("");
    if (debug) {
      var current_time_start = new Date().getTime();
      console.log ("since last time: " + ((current_time_start - last_time) / 1000).toFixed (3));
    }
    if (debug) console.log ("configure_hidden_tab");
    if (debug) console.log ("tabs_to_configure: " + tabs_to_configure);

    do {
      if (tabs_to_configure.length == 0) {
        if (debug_title) $("#plugin_name").css ("color", "#000");
        if (debug) console.log ("configure_hidden_tab: DONE");
        return;
      }
      current_tab = tabs_to_configure.pop();
      tab = $("#tab-" + current_tab);
    } while (tab.hasClass ('configured'));

    if (debug) console.log ("Configuring tab: " + current_tab);

    if (current_tab != 0) configure_tab (current_tab); else configure_tab_0 ();

    if (debug) {
      var current_time = new Date().getTime();
      console.log ("time: " + ((current_time - current_time_start) / 1000).toFixed (3));
      console.log ("TIME: " + ((current_time - start_time) / 1000).toFixed (3));
      last_time = current_time;
    }

    if (tabs_to_configure.length != 0) setTimeout (configure_hidden_tab, 10); else if (debug_title) $("#plugin_name").css ("color", "#000");
  }

  function configure_chart (container) {
    var ai_adb_flag_blocked = 0x80;

    if (!$(container).hasClass ('not-configured')) return;
    var template = $(container).data ('template');

    if (typeof template != 'undefined') {
      var new_colors = [];
      var color_indexes = $(container).data ('colors');
      if (typeof color_indexes != 'undefined') {
        var colors = $.elycharts.templates['ai-pie'].defaultSeries.values;
        color_indexes.forEach (function (element) {
          if (element == ai_adb_flag_blocked )
            new_colors.push (colors [9]); else
              new_colors.push (colors [element]);
        });
      }

      var values = $(container).data ('values-1');
      if (values == null) values = $(container).data ('values-2');
      if (values == null) values = $(container).data ('values-3');
      if (values == null) values = $(container).data ('values-4');
      if (values == null) values = $(container).data ('values-5');
      if (values == null) values = $(container).data ('values-6');
      if (values == null) values = $(container).data ('values-7');
      if (values == null) values = $(container).data ('values-8');
      if (values == null) values = $(container).data ('values-9');

      var legend = $(container).data ('legend');
      if (typeof legend != 'undefined' && typeof legend ['serie' + (ai_adb_flag_blocked + 1)] != 'undefined') {
        var new_legend = {};
        for (var legend_item in legend) {
          if (legend_item == 'serie' + (ai_adb_flag_blocked + 1))
            new_legend ['serie10'] = legend [legend_item]; else
              new_legend [legend_item] = legend [legend_item];
        }
        legend = new_legend;
      }

      $(container).chart({
        template: template,
        labels:   $(container).data ('labels'),
        values: {
          serie1: values,
          serie2: $(container).data ('values-2'),
          serie3: $(container).data ('values-3'),
          serie4: $(container).data ('values-4'),
          serie5: $(container).data ('values-5'),
          serie6: $(container).data ('values-6'),
          serie7: $(container).data ('values-7'),
          serie8: $(container).data ('values-8'),
          serie9: $(container).data ('values-9'),
          serie10: $(container).data ('values-' + (ai_adb_flag_blocked + 1)),  // BLOCKED
        },
        legend: legend,
        tooltips: {serie1: $(container).data ('tooltips')},
        defaultSeries: {values: new_colors, tooltip: {height: $(container).data ('tooltip-height')}},
        defaultAxis : {
          max: $(container).data ('max'),
        },
        features: {
          grid: {
            draw: values.length < 50,
          }
        }
      });

      $(container).removeClass ('not-configured');
      $(container).parent().find ('div.ai-chart-label').show ();
    }
  }

  function update_rating (parameter) {
    var rating_bar = $('#ai-rating-bar');
    var nonce = rating_bar.attr ('nonce');
    $("#rating-value span").load (ajaxurl+"?action=ai_ajax_backend&rating=" + parameter + "&ai_check=" + nonce, function() {
      var rating = $("#rating-value span").text ();
      var rating_value = 0;
      if (rating != '') var rating_value = parseFloat (rating);
      $("#rating-value").css ('width', rating_value * 20 + '%');

      if ($("#rating-value span").text () == '') {
        $("#ai-rating-bar").hide ();
        $('#ai-stars').show ();
      }
    });
  }

  function configure_charts (container) {
    $(container).find ('.ai-chart.not-configured').each (function() {
      if (!$(this).hasClass ('hidden')) {
        $(this).attr ('style', '');
        configure_chart (this);
      }
    });
  }

  function replace_block_number (element, attribute, old_block, new_block) {
    var attr_value = element.attr (attribute);
    var attr_number = attr_value.substr (- old_block.toString().length);
    if (attr_number == old_block) {
      element.attr (attribute, attr_value.substr (0, attr_value.length - old_block.toString().length) + new_block);

//      console.log (attribute, element.attr (attribute));
    }
  }

  function copy_to_clipboard () {
    if (debug) console.log ("AI COPY FROM BLOCK", active_tab);

    var clipboard = $('#ai-clipboard');
    clipboard.html ($('#ai-clipboard-template').html ());

    $('div#tab-' + active_tab + ' input[name]:checkbox').each (function (index){
      var attr = $(this).attr('checked');
      var checked = typeof attr !== typeof undefined && attr !== false;

      if (checked)
        clipboard.find ('input[name]:checkbox').eq (index).attr ('checked', 'checked').next ("label").find ('.checkbox-icon').addClass("on"); else
          clipboard.find ('input[name]:checkbox').eq (index).removeAttr ('checked').next ("label").find ('.checkbox-icon').removeClass("on");
    });

    $('div#tab-' + active_tab + ' select[name]').each (function (index){
      var value = $(this).find ("option:selected").val ();
      clipboard.find ('select[name]').eq (index).find ("option").removeAttr ('selected');
      clipboard.find ('select[name]').eq (index).find ("option[value = '" + value + "']").attr ("selected", true);
    });

    $('div#tab-' + active_tab + ' input[name]:text').each (function (index){
      clipboard.find ('input[name]:text').eq (index).attr ('value', $(this).val ());
    });

    clipboard.find ('textarea.simple-editor').text (get_editor_text (active_tab));

    $("#ai-container .ai-copy").each (function () {
      $(this).next ("label").find ('.checkbox-icon').addClass("on");
    });
  }

  function load_saved_settings_to_clipboard (block, paste) {
    if (debug) console.log ("AI LOAD BLOCK", block, "FROM DB");

    var tools_button = $("#tools-button-" + active_tab);
    if (!tools_button.next ('label').find ('.checkbox-icon').hasClass ("on")) {
      tools_button.click ();
    }

    $('#ai-loading').show ();
    var nonce = $("#ai-form").attr ('nonce');

    $.get (ajaxurl + '?action=ai_ajax_backend&settings=' + block + '&single=1&ai_check=' + nonce, function (settings) {
      if (debug) console.log ("AI BLOCK LOADED");

      var clipboard = $('#ai-clipboard');

      clipboard.html ($('div#tab-' + block, settings).html ());

      clipboard.find ('[id]').each (function () {
        replace_block_number ($(this), 'id', block, 999);
      });

      clipboard.find ('[for]').each (function () {
        replace_block_number ($(this), 'for', block, 999);
      });

      clipboard.find ('[href]').each (function () {
        replace_block_number ($(this), 'href', block, 999);
      });

      clipboard.find ('[name]').each (function () {
        replace_block_number ($(this), 'name', block, 999);
      });

      clipboard.find ('[class]').each (function () {
        replace_block_number ($(this), 'class', block, 999);
      });

      clipboard.find ('pre.ai-block-number').each (function () {
        var text = $(this).text ().replace (block, 999);
        $(this).text (text);
      });

      $("#ai-container .ai-copy").each (function () {
        $(this).next ("label").find ('.checkbox-icon').addClass("on");
      });

//      if (paste) {
//        var tools_visible = $('#ai-tools-toolbar-' + active_tab).is(':visible');

//        paste_from_clipboard (true, true, true, false);

//        if (tools_visible) {
//          $('#ai-tools-toolbar-' + active_tab).show ();
//          $("#tools-button-"+active_tab).next ('label').find ('.checkbox-icon').addClass("on");
//        }
//      }
    }).fail (function (xhr, status, error) {
      console.log ("AI LOADING ERROR:", xhr.status, xhr.statusText);
      $('#ai-error-container').text ('ERROR ' + xhr.status + ': ' + xhr.statusText).show ();
    })
    .always (function () {
      $('#ai-loading').hide ();
    });
  }

  function paste_from_clipboard (paste_name, paste_code, paste_settings, clear) {

    if (clear) {
      var clipboard_template = $('#ai-clipboard-template');
      clipboard_template.find ('input#name-edit-999').attr ('value', 'Block ' + active_tab).attr ('default', 'Block ' + active_tab);
      var clipboard = clipboard_template.html ();
    } else {
        var clipboard = $('#ai-clipboard').html ();
      }

    if (clipboard != '' && active_tab != 0) {
      if (debug) console.log ("AI PASTE TO BLOCK", active_tab);

      var destination_tab = $('div#tab-' + active_tab);

      var name = destination_tab.find ('input#name-edit-' + active_tab).val ();
      var code = get_editor_text (active_tab);

      if (paste_settings) {
        var simple_editor = $('#simple-editor-' + active_tab).is(":checked");
        var tools_visible = $('#ai-tools-toolbar-' + active_tab).is(':visible');
        var copy_active   = destination_tab.find ('.ai-copy').next ("label").find ('.checkbox-icon').hasClass("on");

        if (simple_editor) {
          $('#simple-editor-' + active_tab).click ();
        }

        var save_button_text = destination_tab.find ('input[name=ai_save]').attr('value');
        destination_tab.html (clipboard).find ('input[name=ai_save]').attr('value', save_button_text);

        if (!paste_name) {
          destination_tab.find ('input#name-edit-999').val (name);
        }

        if (!paste_code) {
          destination_tab.find ('textarea#block-999').val (code);
        }

        destination_tab.find ('span#name-label-999').text (destination_tab.find ('input#name-edit-999').val ());

        var block_name = destination_tab.find ('input#name-edit-999').val ();
        destination_tab.find ('pre.ai-block-name').text ('[adinserter name="' + block_name + '"]');

        destination_tab.find ('[id]').each (function () {
          replace_block_number ($(this), 'id', 999, active_tab);
        });

        destination_tab.find ('[for]').each (function () {
          replace_block_number ($(this), 'for', 999, active_tab);
        });

        destination_tab.find ('[href]').each (function () {
          replace_block_number ($(this), 'href', 999, active_tab);
        });

        destination_tab.find ('[name]').each (function () {
          replace_block_number ($(this), 'name', 999, active_tab);
        });

        destination_tab.find ('[class]').each (function () {
          replace_block_number ($(this), 'class', 999, active_tab);
        });

        destination_tab.find ('pre.ai-sidebars').text ('');

        destination_tab.find ('pre.ai-block-number').each (function () {
          var text = $(this).text ().replace (999, active_tab);
          $(this).text (text);
        });

        configure_tab (active_tab);

        if (simple_editor) {
          $('#simple-editor-' + active_tab).click ();
        }

        if (tools_visible) {
          $('#ai-tools-toolbar-' + active_tab).show ();
          $("#tools-button-" + active_tab).next ('label').find ('.checkbox-icon').addClass ("on");
        }

        if (copy_active) {
          destination_tab.find ('.ai-copy').next ("label").find ('.checkbox-icon').addClass("on");
        }
      } else {
          if (paste_name) {
            var clipboard_name = $(clipboard).find ('input#name-edit-999').val ();
            destination_tab.find ('input#name-edit-' + active_tab).val (clipboard_name);
            destination_tab.find ('span#name-label-' + active_tab).text (clipboard_name);
            destination_tab.find ('pre.ai-block-name').text ('[adinserter name="' + clipboard_name + '"]');
          }

          if (paste_code) {
            set_editor_text (active_tab, $(clipboard).find ('textarea#block-999').val ());
          }
        }

      if (debug) console.log ("AI PASTE END");
    } else if (debug) console.log ("AI PASTE FAILED");
  }


  function reload_list () {
    list_search_reload = false;
    var list = encodeURIComponent ($("#ai-list-search").val());
    var all = + !$("#ai-load-all").parent ().find ('.checkbox-icon').hasClass ('on');
    var nonce = $("#ai-form").attr ('nonce');

    var rearrange_controls = $('#list-rearrange-controls');
    var rearrange = rearrange_controls.hasClass ('rearrange')
    rearrange_controls.removeClass ('rearrange').hide ();
    $("#ai-rearrange").parent ().find ('.checkbox-icon').removeClass ('on');

    var rearrange_data = '';
    if (rearrange) {
      var table = $('table#ai-list-table');
      var original_blocks = table.data ('blocks');
      if (typeof original_blocks == 'undefined') original_blocks = new Array();

      var new_blocks = new Array();
      table.find ('tbody tr').each (function (index) {
        new_blocks.push ($(this).data ('block'));
      });

      rearrange_data = "&blocks-org=" + JSON.stringify (original_blocks) + "&blocks-new=" + JSON.stringify (new_blocks);
    }

    var data_container = $("#ai-list-data");

    data_container.load (ajaxurl+"?action=ai_ajax_backend&list=" + list + "&all=" + all + "&start=" + start + "&end=" + end + rearrange_data + "&ai_check=" + nonce, function (response, status, xhr) {
      if (status == "error") {
        var message = "Error downloading list data: " + xhr.status + " " + xhr.statusText;
        data_container.html (message);
        if (debug) console.log (message);
      } else {
          $(".ai-tab-link").click (function () {
            var tab = $(this).data ('tab') - start;
            $("#ai-tab-container").tabs ({active: tab});
          });

          $("label.ai-copy-block").click (function () {
            var block = $(this).closest ('tr').data ('block');

            load_saved_settings_to_clipboard (block, true);
          });

          $("label.ai-preview-block").click (function () {
            var block = $(this).closest ('tr').data ('block');

            var window_width = 820;
            var window_height = 820;
            var window_left  = 100;
            var window_top   = (screen.height / 2) - (820 / 2);
            var nonce = $("#ai-form").attr ('nonce');

            var param = {'action': 'ai_ajax_backend', 'preview': block, 'ai_check': nonce, 'read_only': 1};
            window_open_post (ajaxurl, 'width='+window_width+',height='+window_height+',top='+window_top+',left='+window_left+',resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,menubar=no', 'preview', param);
          });


          data_container.disableSelection();

          if (rearrange) reload_settings ();
        }
    });
  }

  function reload_adsense_list (update_ad_units) {
    adsense_search_reload = false;
    var list = encodeURIComponent ($("#adsense-list-search").val());
    var all = + !$("#adsense-load-all").parent ().find ('.checkbox-icon').hasClass ('on');
    var nonce = $("#ai-form").attr ('nonce');

    var data_container = $("#adsense-list-data");

    data_container.load (ajaxurl+"?action=ai_ajax_backend&adsense-list=" + list + "&all=" + all + "&update_ad_units=" + (update_ad_units ? 1 : 0) + "&ai_check=" + nonce, function (response, status, xhr) {
      $("#adsense-reload").parent ().find ('.checkbox-icon').removeClass ('on');

      if (status == "error") {
        var message = "Error downloading AdSense data: " + xhr.status + " " + xhr.statusText;
        data_container.html (message);
        if (debug) console.log (message);


      } else {
          if ($('#adsense-client-id', data_container).length) {
            $('#adsense-list-controls').hide ();
            $('button.ai-top-button', data_container).button().show ();

            $("#save-client-ids").click (function () {

              var client_id = $("input#adsense-client-id").val ();
              var client_secret = $("input#adsense-client-secret").val ();

              data_container.text ('Loading...');

              var nonce = $("#ai-form").attr ('nonce');

              $('#ai-loading').show ();
              $.get (ajaxurl + '?action=ai_ajax_backend&adsense-client-id=' + btoa (client_id) + '&adsense-client-secret=' + btoa (client_secret) + '&ai_check=' + nonce, function (data) {
                reload_adsense_list (false);
              }).fail (function (xhr, status, error) {
                var message = "Error saving AdSense client IDs: " + xhr.status + " " + xhr.statusText ;
                console.log (message);
              })
              .always (function () {
                $('#ai-loading').hide ();
              });
            });

            $(".authorize-adsense", data_container).click (function () {

              $('#adsense-list-controls').show ();
              data_container.text ('Loading...');

              authorization_code = '';
              update_adsense_authorization (authorization_code);
            });

            return;
          } else

          if ($('#adsense-authorization-code', data_container).length) {
            $('#adsense-list-controls').hide ();
            $('button.ai-top-button', data_container).button().show ();

            $(".authorize-adsense", data_container).click (function () {

              var authorization_code = $("input#adsense-authorization-code").val ();

              $('#adsense-list-controls').show ();
              data_container.text ('Loading...');

              if ($(this).hasClass ('clear-adsense')) authorization_code = '';
              if ($(this).hasClass ('own-ids')) authorization_code = 'own-ids';


              update_adsense_authorization (authorization_code);
            });

            return;
          }

          $('#adsense-list-controls').show ();

          var publisher_id = $('#adsense-data', data_container).data ('publisher-id');
          if (typeof publisher_id == 'undefined') publisher_id = '';

          $('label#google-adsense-button').attr ('title', 'Google AdSense Home ' + publisher_id);

          $("label.adsense-copy-code").click (function () {
            var ad_slot_id = $(this).closest ('tr').data ('id');
            var ad_name = atob ($(this).closest ('tr').data ('name'));
            var nonce = $("#ai-form").attr ('nonce');

            if (debug) console.log ('ADSENSE CODE: ', ad_slot_id);

            $('#ai-loading').show ();
            $.get (ajaxurl + '?action=ai_ajax_backend&adsense-code=' + ad_slot_id + '&ai_check=' + nonce, function (data) {

              var code_data = JSON.parse (data);
              var error = code_data ['error-message'];

              if (error == '') {
                var adsense_code = code_data ['code'];

                if (debug) console.log (adsense_code);

                var clipboard_template  = $('#ai-clipboard-template');
                var clipboard           = $('#ai-clipboard');
                clipboard.html (clipboard_template.html ());
                clipboard.find ('input#name-edit-999').attr ('value', ad_name).attr ('default', ad_name);

                clipboard.find ('textarea.simple-editor').text (adsense_code);

                $("#ai-container .ai-copy").each (function () {
                  $(this).next ("label").find ('.checkbox-icon').addClass("on");
                });

                var tools_button = $("#tools-button-" + active_tab);
                if (!tools_button.next ('label').find ('.checkbox-icon').hasClass ("on")) {
                  tools_button.click ();
                }
              } else {
                  console.log ('AdSense API error:', error);
                }
            }).fail (function (xhr, status, error) {
              var message = "Error downloading AdSense code: " + xhr.status + " " + xhr.statusText ;
              console.log (message);
            })
            .always (function () {
              $('#ai-loading').hide ();
            });

          });

          $("label.adsense-preview-code").click (function () {
            var ad_slot_id = $(this).closest ('tr').data ('id');
            var ad_name = $(this).closest ('tr').data ('name');

            var window_width = 820;
            var window_height = 820;
            var window_left  = 100;
            var window_top   = (screen.height / 2) - (820 / 2);
            var nonce = $("#ai-form").attr ('nonce');

            var param = {'action': 'ai_ajax_backend', 'preview': 'adsense', 'ai_check': nonce, 'read_only': 1, 'slot_id': btoa (ad_slot_id), 'name': ad_name};
            window_open_post (ajaxurl, 'width='+window_width+',height='+window_height+',top='+window_top+',left='+window_left+',resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,menubar=no', 'preview', param);
          });

          $("label.adsense-get-code").click (function () {
            var ad_slot_id = $(this).closest ('tr').data ('id');
            var ad_name = atob ($(this).closest ('tr').data ('name'));
            var nonce = $("#ai-form").attr ('nonce');

            if (debug) console.log ('ADSENSE CODE: ', ad_slot_id);

            $('#ai-loading').show ();
            $.get (ajaxurl + '?action=ai_ajax_backend&adsense-code=' + ad_slot_id + '&ai_check=' + nonce, function (data) {

              var code_data = JSON.parse (data);
              var error = code_data ['error-message'];

              if (error == '') {
                var adsense_code = code_data ['code'];

                if (debug) console.log (adsense_code);

                set_editor_text (active_tab, adsense_code);
                setTimeout (function() {$("#import-code-"+active_tab).click ();}, 10);
              } else {
                  console.log ('AdSense API error:', error);
                }
            }).fail (function (xhr, status, error) {
              var message = "Error downloading AdSense code: " + xhr.status + " " + xhr.statusText ;
              console.log (message);
            })
            .always (function () {
              $('#ai-loading').hide ();
            });
          });

          data_container.disableSelection();
        }
    });
  }

  function configure_tabs () {

    var tabs_array = new Array ();
    if (active_tab != 0) tabs_array.push (0);
    for (var tab = end; tab >= start; tab --) {
      if (tab != active_tab) tabs_array.push (tab);
    }
    // Concatenate existing tabs_to_configure (if tab was clicked before page was loaded)
    tabs_to_configure = tabs_array.concat (tabs_to_configure);

    setTimeout (configure_hidden_tab, 700);

    var index = 16;
    if (active_tab != 0) index = active_tab - start;
    var block_tabs = $("#ai-tab-container").tabs ({active: index});
    $("#ai-plugin-settings-tab-container").tabs ({active: active_tab_0});

    $('#ai-settings').tooltip({
      show: {effect: "blind",
             delay: 400,
             duration: 100}
    });

    if (debug_title) $("#plugin_name").css ("color", "#00f");

    if (active_tab == 0) configure_tab_0 (); else configure_tab (active_tab);

    $('#dummy-tabs').hide();
    $('#ai-tabs').show();

    $('.ai-tab').click (function () {
      var tab_block = $(this).attr ("id");
      tab_block = parseInt (tab_block.replace ("ai-tab",""));
      active_tab = tab_block;

      if (debug) console.log ("active_tab: " + active_tab);

      if (syntax_highlighting) {
        if (!$("#tab-" + tab_block).hasClass ('configured')) {
          if (debug) console.log ("");
          if (debug) console.log ("Empty tab: " + tab_block);
          tabs_to_configure.push (tab_block);
          setTimeout (configure_hidden_tab, 10);
          if (debug) console.log ("tabs_to_configure: " + tabs_to_configure);
        } else if (tab_block != 0) {
            var editor = ace.edit ("editor-" + tab_block);
            editor.getSession ().highlightLines (10000000);
          }
      }
    });

    $('.ai-plugin-tab').click (function () {
      active_tab_0 = $("#ai-plugin-settings-tab-container").tabs ('option', 'active');
      if (debug) console.log ("active_tab_0: " + active_tab_0);

      if (syntax_highlighting) {
        var tab_block = $(this).attr ("id");
        tab_block = tab_block.replace ("ai-","");

        if (tab_block == 'h') {
            var editor = ace.edit ("editor-h");
            editor.getSession ().highlightLines (10000000);
        } else
        if (tab_block == 'f') {
            editor = ace.edit ("editor-f");
            editor.getSession ().highlightLines (10000000);
        } else
        if (tab_block == 'a') {
            editor = ace.edit ("editor-a");
            editor.getSession ().highlightLines (10000000);
        }
      }
    });
  }


  function reload_settings () {
    if (debug) console.log ('RELOAD SETTINGS');

    var nonce = $("#ai-form").attr ('nonce');
    var settings_container = $("#ai-container");

    $('#ai-error-container').hide ();
    if (debug_title) $("#plugin_name").css ("color", "#f00");

    $('#ai-loading').show ();

    var tools         = $('#ai-tools-toolbar-' + active_tab).is (':visible');
    var simple_editor = $('#simple-editor-' + active_tab).is(":checked");
    var copy          = $("#copy-block-" + active_tab).next ("label").find ('.checkbox-icon').hasClass("on");



    settings_container.load (ajaxurl+"?action=ai_ajax_backend&settings=" + active_tab + "&ai_check=" + nonce, function (response, status, xhr) {
      if (status == "error") {
        $('#ai-loading').hide ();
        var message = "Error reloading settings: " + xhr.status + " " + xhr.statusText;
        $('#ai-error-container').text (message).show ();
        if (debug) console.log (message);
      } else {
          if (debug) console.log ('  Configuring...');

          if (debug) {
            start_time = new Date().getTime();
            last_time = start_time;
          }

          configure_tabs ();

          if (simple_editor) $('#simple-editor-' + active_tab).click ();

          if (tools) $('#tools-button-' + active_tab).click ();

          if (copy) {
            $("#ai-container .ai-copy").each (function () {
              $(this).next ("label").find ('.checkbox-icon').addClass("on");
            });
          }

          if (debug) console.log ('  Configured');
          $('#ai-loading').hide ();
        }
    });
  }

  function update_adsense_authorization (authorization_code) {
    var nonce = $("#ai-form").attr ('nonce');

    $('#ai-loading').show ();
    $.get (ajaxurl + '?action=ai_ajax_backend&adsense-authorization-code=' + btoa (authorization_code) + '&ai_check=' + nonce, function (data) {
      reload_adsense_list (false);
    }).fail (function (xhr, status, error) {
      var message = "Error saving AdSense authorization: " + xhr.status + " " + xhr.statusText ;
      console.log (message);
    })
    .always (function () {
      $('#ai-loading').hide ();
    });
  }

  function update_block_code_demo () {
    var nonce = $("#ai-form").attr ('nonce');

    var block_class_name    = encodeURIComponent ($('#block-class-name').val ());
    var block_class         = $('#block-class').is(":checked") ? 1 : 0;
    var block_number_class  = $('#block-number-class').is(":checked") ? 1 : 0;
    var inline_styles       = $('#inline-styles').is(":checked") ? 1 : 0;

    $.get (ajaxurl + '?action=ai_ajax_backend&update=block-code-demo&block_class_name=' + block_class_name + '&block_class=' + block_class + '&block_number_class=' + block_number_class + '&inline_styles=' + inline_styles + '&ai_check=' + nonce, function (data) {
      $('span#ai-block-code-demo').html (data);
    }).fail (function (xhr, status, error) {
      var message = "Error updating block code demo: " + xhr.status + " " + xhr.statusText ;
      console.log (message);
    });
  }

  if (debug) console.log ("READY");
  if (debug_title) $("#plugin_name").css ("color", "#f00");
  if (debug) {
    var current_time_ready = new Date().getTime();
    console.log ("TIME: " + ((current_time_ready - start_time) / 1000).toFixed (3));
  }

  $("#blocked-warning").removeClass ('warning-enabled');
  $("#blocked-warning").hide ();

  start         = parseInt ($('#ai-form').attr('start'));
  end           = parseInt ($('#ai-form').attr('end'));

  active_tab    = start;
  active_tab_0  = 0;
  try {
    var active_tabs = JSON.parse ($("#ai-active-tab").attr ("value"));
    if (typeof active_tabs !== "undefined" && active_tabs.constructor === Array && Number.isInteger (active_tabs [0]) && Number.isInteger (active_tabs [1])) {
      active_tab    = parseInt (active_tabs [0]);
      if (active_tab != 0)
        if (active_tab < start || active_tab > end) active_tab = start;
      active_tab_0  = parseInt (active_tabs [1]);
    }
  } catch (e) {}

  if (debug) console.log ("active_tabs:", active_tab, active_tab_0);

  var plugin_version = $('#ai-data').attr ('version').split ('-') [0];
  if (javascript_version != plugin_version) {
    console.log ('AD INSERTER: plugin version: ' + plugin_version + ', loaded Javascript version: ' + javascript_version);

    // Check page HTML
    var javascript_version_parameter = $("script[src*='ad-inserter.js']").attr('src');
    if (typeof javascript_version_parameter == 'undefined') $("#javascript-version-parameter-missing").show (); else {
      javascript_version_parameter_string = javascript_version_parameter.split('=')[1];
      if (typeof javascript_version_parameter_string == 'undefined') {
        $("#javascript-version-parameter-missing").show ();
      }
      else if (javascript_version_parameter_string != plugin_version) {
        console.log ('AD INSERTER: plugin version: ' + plugin_version + '- Javascript file version: ' + javascript_version_parameter_string);
        $("#javascript-version-parameter").show ();
      }
    }

    $("#javascript-version").html ("&nbsp;javascript " + javascript_version);
    $("#javascript-warning").show ();
  }

  var css_version = $('#ai-data').css ('font-family').replace(/[\"\']/g, '');
  if (css_version.indexOf ('.') == - 1) $("#blocked-warning").show (); else
    if (css_version != plugin_version) {
      console.log ('AD INSERTER: plugin version:', plugin_version, 'loaded CSS version:', css_version);

      // Check page HTML
      var css_version_parameter = $("link[href*='ad-inserter.css']").attr('href');
      if (typeof css_version_parameter == 'undefined') $("#css-version-parameter-missing").show (); else {
        css_version_parameter_string = css_version_parameter.split('=')[1];
        if (typeof css_version_parameter_string == 'undefined') {
          $("#css-version-parameter-missing").show ();
        }
        else if (css_version_parameter_string != plugin_version) {
          console.log ('AD INSERTER: plugin version:', plugin_version, '- CSS file version:', css_version_parameter_string);
          $("#css-version-parameter").show ();
        }
      }

      $("#css-version").html ("&nbsp;CSS " + css_version);
      $("#css-warning").show ();
    }

  $('.header button').button().show ();

  $('#dummy-ranges').hide();
  $('#ai-ranges').show();

  $("#ai-form").submit (function (event) {
      for (var tab = start; tab <= end; tab ++) {
        remove_default_values (tab);
      }
      remove_default_values (0);
  });

  $("div#tab-999").attr ('id', 'ai-clipboard-template').insertBefore ("#ai-clipboard");

  configure_tabs ();

  $('#plugin_name').dblclick (function () {
    $(".system-debugging").toggle();
  });

  $('#ai-stars').click (function () {
    if ($("#rating-value span").text () != '') {
      $("#ai-rating-bar").css ('display', 'inline-block');
      $('#ai-stars').hide ();
    }
    update_rating ('update', '');
  });

  $("#ai-rating-bar").click (function () {
    $("#ai-rating-bar").hide ();
    $('#ai-stars').show ();
  });


  $("#ai-list").click (function () {
    var container = $("#ai-list-container");

    container.toggle ();

    if (container.is(':visible')) {
      reload_list ();
    }
  });

  $("#ai-list-search").keyup (function (event) {
    if (!list_search_reload) {
      list_search_reload = true;
      setTimeout (reload_list, 200);
    }
  });

  $("#ai-load-all").click (function () {
    $(this).parent ().find ('.checkbox-icon').toggleClass ('on');
    reload_list ();
  });

  $("#ai-rearrange").click (function () {
    $(this).parent ().find ('.checkbox-icon').toggleClass ('on');

    var data_container = $("#ai-list-data");
    var rearrange_controls = $('#list-rearrange-controls');
    if ($(this).parent ().find ('.checkbox-icon').hasClass ('on')) {
      $("#ai-rearrange").parent ().find ('.checkbox-button').attr ('title', 'Cancel block order rearrangement');
      rearrange_controls.show ();
      data_container.find ('tbody').sortable ({
        start: function (event, ui) {$('#list-save').show ();},
        placeholder: "ui-state-highlight"
      }).css ('cursor', 'move');
    } else {
        data_container.find ('tbody').sortable ("disable");
        $("#ai-rearrange").parent ().find ('.checkbox-button').attr ('title', 'Rearrange block order');
        $('#list-save').hide ();
        rearrange_controls.hide ();
        reload_list ();
      }
  });

  $("#ai-save-changes").click (function () {
    $('#list-rearrange-controls').addClass ('rearrange')
    reload_list ();
  });

  if ($("#maxmind-db-status").hasClass ('maxmind-db-missing')) {
    var nonce = $("#ai-form").attr ('nonce');
    var page = ajaxurl+"?action=ai_ajax_backend&update=maxmind&ai_check=" + nonce;

    $("span.maxmind-db-missing").text ('downloading...');
    $.get (page, function (update_status) {

      if (update_status == '') {
        $("span.maxmind-db-missing").closest ('.notice.notice-error').hide ();
        $("#maxmind-db-status").text ('');
      } else {
        console.log (update_status);
          var status = JSON.parse (update_status);
        console.log (status);
          if (typeof status !== "undefined") {
            $(".notice span.maxmind-db-missing").text (status [0]);
            $("#maxmind-db-status").text (status [1]);
          } else $("span.maxmind-db-missing").text ('update error');
        }
    }).fail (function(jqXHR, status, err) {
      $("span.maxmind-db-missing").text ('download error');
    });
  }

  $("#adsense-load-all").click (function () {
    $(this).parent ().find ('.checkbox-icon').toggleClass ('on');
    reload_adsense_list (false);
  });

  $("#adsense-list-search").keyup (function (event) {
    if (!adsense_search_reload) {
      adsense_search_reload = true;
      setTimeout (function() {reload_adsense_list (false);}, 200);

    }
  });

  $("#adsense-reload").click (function () {
    $(this).parent ().find ('.checkbox-icon').addClass ('on');
    setTimeout (function() {reload_adsense_list (true);}, 200);
  });

  $("#clear-adsense-authorization").click (function () {
    $("#adsense-list-data").text ('Updating...');
    update_adsense_authorization ('');
  });

  $('.ai-block-code-demo').change (function () {
    update_block_code_demo ();
  }).on('input',function(e){
    update_block_code_demo ();
  });

  setTimeout (function() {update_rating ('');}, 1000);

  if (debug) console.log ("");
  if (debug) console.log ("READY END");
  if (debug) {
    var current_time = new Date().getTime();
    console.log ("main time: " + ((current_time - current_time_ready) / 1000).toFixed (3));
  }
});


