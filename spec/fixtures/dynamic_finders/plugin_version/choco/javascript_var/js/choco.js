/*
 * choco.js
 *
 * -*- Encoding: utf8n -*-
 *
 */

var choco = { 'version': '1.17', id: 1 };

choco.loadTinyMceForm = function () {
    if (choco.tinyMceForm != null) {
        return;
    }

    //console.log(choco.baseUrl);

    // load tiny_mce.html
    jQuery.ajax({
        global: false,
        type: 'GET',
        url: choco.baseUrl + "/js/tiny_mce.html",
        dataType: 'html'
    }).success(function (tiny_mce_html) {
        //console.log(tiny_mce_html);
        choco.tinyMceForm = tiny_mce_html;
        jQuery(tiny_mce_html).prependTo('body');
        choco.initTinyMce();
        choco.setClickEventTinyMceSaveButton();
        choco.setClickEventTinyMceCancelButton();
    }).error(function () {
        console.log("choco: Error: Can't get tiny_mce screen.");
    });
};


choco.initTinyMce = function () {
    var height = parseInt(jQuery(window).height() * 0.70);

    tinymce.init({
        //setup: chocoCustomOnInit,
        language: chocolanguage,
        selector: "textarea#choco_tinymce",
        //height: "400",
        height: height,
        paste_data_images: true,
        // p tag
        forced_root_block: "",
        force_br_newlines: true,
        force_p_newlines: false,
        fontsize_formats: "8px 9px 10px 11px 12px 14px 16px 18px 20px 22px 24px 26px 30px 36px",
        /*
        templates: [
            {
                title: "Fill Cell",
                url: choco.templatePath + "fillcell.html",
                description: ""
            },
            {
                title: "My Snippet",
                url: choco.templatePath + "snippet.htm",
                description: "Adds a HTML snippet"
            },
        ],
        // Replace values for the template plugin
        template_replace_values: {
            username: "Some User",
            staffid: "991234"
        },
        */
        plugins: [
            "advlist autolink lists link image charmap print preview anchor",
            "searchreplace visualblocks code fullscreen",
            "insertdatetime media table contextmenu paste textcolor emoticons code template colorpicker hr"
        ],
        toolbar: "insertfile undo redo | fontsizeselect | styleselect | bold italic | forecolor backcolor emoticons | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image hr | template | code"
    });
};

choco.setClickEventTinyMceCancelButton = function () {
    jQuery("#tiny_mce_cancel,#tiny_mce_bg").unbind();
    // button cancel and click background
    jQuery("#tiny_mce_cancel,#tiny_mce_bg").click(function () {
        //jQuery("#choco_tiny_mce").remove();
        jQuery('#tiny_mce_bg').css('display', 'none');
        jQuery('#tiny_mce_input').css('display', 'none');
        tinyMCE.execCommand('mceSetContent', false, '');
    });
};

choco.rewriteAll = function (records) {
    for (var i = 0; i < records.length; i++) {
        jQuery(records[i].selector).eq(records[i].selector_index).html(choco.decodeHtmlSpecialChars(records[i].data)).addClass('modified_by_choco');
        //console.log(": " + records[i].selector + " " + records[i].selector_index + ' ' + records[i].data);
    }
};

choco.getAllData = function (selectors) {
    if (!selectors.length) {
        return;
    }

    /*
    for (var i = 0; i < records.length; i++) {
        console.log(records[i].selector + ' ' + records[i].selector_index);
    }
    */

    var sendData = {
        "ajax_nonce": choco_ajax_nonce,
        "action": choco.action,
        "cmd": "get_all_data",
        "selectors": selectors
    };

    jQuery.ajax({
        global: false,
        url: choco.chocoServer,
        //url: choco.baseUrl + "/include/" + "?" + parseInt((new Date) / 1000),
        type: "POST",
        dataType: "json",
        data: sendData,
        cache: false
    }).success(function (data) {
        //console.log(data);
        if (data == null) {
            console.log("choco: no data.");
            return;
        }
        //console.log("success");
        //console.log(data);
        choco.rewriteAll(data);
    }).error(function (data) {
        console.log("choco: Error: Get all data request failed.");
    });
};

choco.getSelectors = function() {
    var selectors = [];
    var i = 0;
    jQuery(choco.selector).each(function() {
        selectors[i++] = choco.getSelector(this);
    });
    return selectors;
};

choco.getSelector = function (obj) {
    var sr = '';
    var id = obj.id; // has class id?
    // find first class as 'choco_'.
    var classes = obj.className.trim().split(/\s+/);
    var class1st = '';
    for (var i = 0; i < classes.length; i++) {
        if (classes[i].match(/^choco_/)) {
            class1st = classes[i];
            break;
        }
    }


    if (id && class1st) {
        //console.log("found id and class.");
        //sr = '#' + id + ' .' + class1st;
        sr = '#' + id + '.' + class1st;
    } if (id && !class1st) {
        //console.log("found id only.");
        sr = '#' + id;
    } else {
        //console.log("found class only. find parents id.");
        var parents_obj = jQuery(obj).parents('[id^=choco_]');
        var parents_classes = '';
        if (parents_obj) {
            id = parents_obj.attr('id');
            // has id class?
            var parents_classes_attr = parents_obj.attr('class');
            if (parents_classes_attr) {
                var parents_classes_array = parents_classes_attr.trim().split(/\s+/);
                for (var i = 0; i < parents_classes_array.length; i++) {
                    if (parents_classes_array[i].match(/^choco_/)) {
                        parents_classes += '.' + parents_classes_array[i];
                    }
                }
            }
        }

        if (id) {
            //console.log("found parents id.");
            if (parents_classes) {
                //console.log("found parents id and parents class.");
                //sr = "#" + id.trim() + "." + id_classes.trim().replace(/\s+/g, '.') +  " ." + class1st;
                sr = "#" + id + parents_classes +  " ." + class1st;
            } else {
                //console.log("found parents id and class.");
                sr = "#" + id + " ." + class1st;
            }
        } else {
            //console.log("found class only.");
            sr = "." + class1st;
        }
    }


    // get index of selector.
    var selector_index = jQuery(sr).index(obj);
    /*
    if (index < 0) {
        return;
    }
    */

    //console.log("sr: " + sr + ", index: " + selector_index);
    return {'id': id, 'class': class1st, 'selector': sr, 'selector_index': selector_index};
};


choco.chocoCustomOnInit = function () {
    var docWidth = jQuery(document).width();
    var docHeight = jQuery(document).height();

    jQuery("#tiny_mce_bg").css({"width": docWidth, "height": docHeight});
    var padding = 4; // %
    jQuery("#tiny_mce_input").css({"width": (100 - padding) + '%', 'left': (padding / 2) + '%', 'top': (padding) + '%'});
};


choco.setClickEventTinyMceSaveButton = function () {
    // button save
    jQuery("#tiny_mce_save").unbind();

    jQuery("#tiny_mce_save").on('click', function () {
        //console.log("obj = " + obj + ", selector = " + selector + ", saveIndex = " + saveIndex);
        var value = "";
        value = tinyMCE.get('choco_tinymce').getContent();             // visual mode
        //value = jQuery('textarea[name="choco_tinymce"]').val();      // html mode
        //console.log("Data size = " + value.length);
        if (value.length > choco.maxPostSize) {
            if (!window.confirm("Can't save. Content size is larger than " + choco.maxPostSize + " bytes.")) {
                return false;
            }
        }
        // update page tags, first.
        jQuery(choco.current.selector[choco.id]).eq(choco.current.selector_index[choco.id]).html(choco.decodeHtmlSpecialChars(value));
        // save data to server
        //choco.saveData(obj, selector, saveIndex, value);
        choco.saveData(value);
        //jQuery("#choco_tiny_mce").remove();
        jQuery('#tiny_mce_bg').css('display', 'none');
        jQuery('#tiny_mce_input').css('display', 'none');
        tinyMCE.execCommand('mceSetContent', false, '');
    });
};


/**
 * Send save request to server.
 *
 * @param sendData
 */
choco.saveData = function (data) {
    // console.log("choco.id: " + choco.id);
    var sendData = {
        "ajax_nonce": choco_ajax_nonce,
        "action": choco.action,
        "cmd": "save",
        "id": choco.id,
        "selector": choco.current.selector[choco.id],
        "selector_index": choco.current.selector_index[choco.id],
        "data": data
    };

    jQuery.ajax({
        global: false,
        url: choco.chocoServer,
        type: "POST",
        dataType: "json",
        data: sendData
    }).error(function (data) {
        var msg = "choco: Error: Data save request failed.\n selector: " + choco.current.selector + "\n selector_index: " + choco.current.selector_index;
        console.log(msg);
        alert(msg);
    }).success(function (data) {
        // console.log(data);
        if (data.status == "error") {
            var msg = "choco: Error: Data save failed.\n selector: " + choco.current.selector + "\n selector_index: " + choco.current.selector_index;
            console.log(msg);
            alert(msg);
            return false;
        }
        // update page tags, second.
        // console.log("id: " + data.id);
        jQuery(choco.current.selector[data.id]).eq(choco.current.selector_index[data.id]).html(choco.decodeHtmlSpecialChars(data.data));
    });
};

choco.decodeHtmlSpecialChars = function(str) {
    return jQuery("<div/>").html(str).text();
};

choco.ready = function() {
    //choco.selector = '[id^=choco_]:has([class*=choco_]:not(:has([class*=choco_]))),[class*=choco_]:not(:has([class*=choco_]))';
    choco.selector = '[class*=choco_]:not(:has([class*=choco_]))';

    choco.login = chocoLogin;
    choco.action = 'choco_session_start';
    choco.chocoServer = choco_ajaxurl;
    choco.baseUrl = chocoBaseUrl;

    //choco.maxPostSize = 65535;                // mysql text data : 65,535 bytes.
    //choco.maxPostSize = 1.5 * 1024 * 1024;    // mysql mediumtext: 1.6MB.
    choco.maxPostSize = 5 * 1024 * 1024;        // mysql longtext  : 4.3GB.
    choco.templatePath = choco.baseUrl + "/templates/";
    choco.tinyMceForm = null;

    choco.current = {
        selector: [],
        selector_index: [],
    };

    var selectors = choco.getSelectors();
    /*
    for (var i = 0; i < selectors.length; i++) {
        console.log(selectors[i].selector + ' ' + selectors[i].selector_index);
    }
    */
    choco.getAllData(selectors);


    // -- NEED LOGIN --------------------------------------
    if (!choco.login) {
        return;
    }

    choco.loadTinyMceForm();

    jQuery(choco.selector).live({
        mouseenter: function(event){
            var selector = choco.getSelector(this);
            //console.log('hover: ' + selector.selector + ' ' + selector.selector_index);
            jQuery(selector.selector).eq(selector.selector_index).addClass("choco_mouse_hover").css({"cursor": 'url(' + choco.baseUrl + '/img/use151.cur),pointer'});
            //jQuery(event.target).css("background-color","red");
        },
        mouseleave: function(event){
            var selector = choco.getSelector(this);
            jQuery(selector.selector).eq(selector.selector_index).removeClass("choco_mouse_hover");
        }
    });

    jQuery(choco.selector).live('click', function(obj) {
        choco.id++;

        var selector = choco.getSelector(this);
        //console.log('click: ' + selector.selector + ' ' + selector.selector_index);
        //choco.loadTinyMceForm();

        // set edit selector.
        choco.current.selector[choco.id] = selector.selector;
        choco.current.selector_index[choco.id] = selector.selector_index;

        var html = jQuery(selector.selector).eq(selector.selector_index).html();
        //console.log("html = " + html);

        tinyMCE.execCommand('mceSetContent', false, html);
        choco.chocoCustomOnInit();
        jQuery('#tiny_mce_bg').css('display', 'block');
        jQuery('#tiny_mce_input').css('display', 'table');
    });
};


choco.mutationObserver = new MutationObserver(function(mutationRecords){
    //console.log('MutationObserver');
    //console.log(mutationRecords);
    choco.mutationObserver.disconnect();    // off

    var timer;
    clearTimeout(timer);
    timer = setTimeout(function() {
        //console.log("MutationObserver: execute");
        choco.getAllData(choco.getSelectors());
    }, 200);
});

jQuery(document).on("ajaxComplete", function(event, xhr, settings) {
    //console.log("ajaxComplete");
    choco.mutationObserver.observe(jQuery('body').get(0), {attributes: true, attributeOldValue: true}); // on

    var timer;
    clearTimeout(timer);
    timer = setTimeout(function() {
        //console.log("ajaxComplete: execute");
        choco.getAllData(choco.getSelectors());
    }, 200);
});

jQuery(document).ready(function () {
    choco.ready();
});

