/* Version: 1.2.1 */
jQuery(document).ready(function($){
	var to=(function(){var timers={};return function(callback,ms,x_id){if(!x_id){x_id='';}if(timers[x_id]){clearTimeout(timers[x_id]);}timers[x_id]=setTimeout(callback,ms);};})(),id,xstyle,xtop,slr=300,show_popup=false,allottedtime,expiration,ifautofit = 0,rd_bxslider,ads_scrolltop,ae,aeii,ae_popup_title,ae_multiple,ae_loading = false,ae_upload_type,ae_media_type,ae_submit_text,ae_key;
	String.prototype.number_format = (function(d){
		var n = this,c = isNaN(d = Math.abs(d)) ? 2 : d,s = n < 0 ? "-" : "",i = parseInt(n = Math.abs(+n || 0).toFixed(c)) + "", j = (j = i.length) > 3 ? j % 3 : 0;
		return s + (j ? i.substr(0, j) + ',' : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + ',') + (c ? '.' + Math.abs(n - i).toFixed(c).slice(2) : "");
	});

	var xa, xthis,xattach_id = 0,
	xb = $( '.ae-ua-upload .ae-upload' ),
	xc = $( '.ae-ua-upload .ae-new' ),
	xd = $( '.ae-ua-upload .ae-crop-wrap' ),
	xe = $( '.ae-ua-upload .ae-img-wrap' ),
	xawidth = parseInt( xb.attr( 'data-width' ) ),
	xawidth = ( xawidth ? xawidth : 300 ),
	xaheight = parseInt( xb.attr( 'data-height' ) ),
	xaheight = ( xaheight ? xaheight : 300 ),
	xboundaryw = xawidth + 200,
	xboundaryh = xaheight + 100;
	if( window.innerWidth <= xboundaryw ){
		xboundaryw = 300,
		xboundaryh = 200;
		xcroppie();
	}else{
		xcroppie();
	}
function xcroppie(){	
	xc.on( 'click', function() {
		xb.trigger( 'click' );
	});
	$( '.ae-ua-upload .edit-image' ).on( 'click', function() {
		if( ! xb.val() ){
			xb.trigger( 'click' );
			xc.hide();
		}else{
			xc.show();
			xd.fadeIn( function(){});
		}
	});
	$( '.ae-ua-upload .ae-cancel' ).on( 'click', function () {
		xd.fadeOut();
	});
	xb.on( 'change', function () {
		xthis = this;
	 	if( ! xa ){
			xa = $( '.ae-ua-upload .ae-crop' ).croppie({
			    enableExif: true,
			    viewport: {
			        width: xawidth,
			        height: xaheight,
			        type: 'square'
			    },
			    boundary: {
			        width: xboundaryw,
			        height: xboundaryh
			    }
			});
	 	}
	 	if( xa ){
		 	xd.fadeIn(function(){
			  	var xreader = new FileReader();
			 	xreader.onload = (function (e) {
			 		xa.croppie( 'bind', {
			  			url: e.target.result
			  		}).then(function(){});	      
			    });
			    if( xthis.files.length ){
			    	xreader.readAsDataURL( xthis.files[0] );
			    }
		 	});
		 }
	});
	$( '.ae-ua-upload .ae-save' ).on( 'click', function () {
        xa.croppie( 'result', {
            type: 'base64',
            size: 'original'
        }).then(function ( resp ){
	 		if( xthis.files.length ){
	 			var xfiledata = xthis.files[0];
                $.ajax({
                    type    : "POST",
                    url     : ae_addon.ajaxurl,
                    data    : {
                        action      : 'user_avatar_upload',
                        base64      : resp,
						file		: xb.val(),
                        filename    : xfiledata.name,
                        filetype    : xfiledata.type,
                        attach_id    : xattach_id,
						key	: xb.data( 'key' ),
                    },
                    beforeSend: function( response ) {
                        if( ! xd.find( '#save-loading' ).length ){
                        	xd.find( '.cr-boundary' ).append( '<img id="save-loading" src="' + ae_addon.spinner2x + '" />' );
                        }
                    },
                    success: function( response ){
						if(response){
							var data = JSON.parse(response);
							xattach_id = data.attach_id;
							if( data.attach_id ){
						        xe.find( 'img.image' ).attr( 'src', data.attach_url ).parent( '.ae-img-wrap' ).addClass( 'ae-img-active' );
		                    	xd.find( '#save-loading' ).remove();
		                    	xd.fadeOut();
							}else{
								xe.find( 'img.image' ).parent( '.ae-img-wrap' ).removeClass( 'ae-img-active' );
								xd.fadeOut();
		                    	xd.find( '#save-loading' ).remove();
								alert( 'ERROR #1: something went wrong !!!' );
							}
						}else{
							xe.find( 'img.image' ).parent( '.ae-img-wrap' ).removeClass( 'ae-img-active' );
					 		xd.fadeOut();
							xd.find( '#save-loading' ).remove();
						 	alert( 'ERROR #2: something went wrong !!!' );
						}
                    },      
                });
			}
    	});
	});
}

	var a, _this,attach_id = 0,
	b = $( '.ae-upload .ae-upload' ),
	c = $( '.ae-upload .ae-new' ),
	d = $( '.ae-upload .ae-crop-wrap' ),
	e = $( '.ae-upload .ae-img-wrap' ),
	awidth = parseInt( b.attr( 'data-width' ) ),
	awidth = ( awidth ? awidth : 300 ),
	aheight = parseInt( b.attr( 'data-height' ) ),
	aheight = ( aheight ? aheight : 300 ),
	boundaryw = awidth + 200,
	boundaryh = aheight + 100;
	if( window.innerWidth <= boundaryw ){
		boundaryw = 300,
		boundaryh = 200;
		croppie();
	}else{
		croppie();
	}
function croppie(){	
	c.on( 'click', function() {
		b.trigger( 'click' );
	});
	$( '.ae-upload .edit-image' ).on( 'click', function() {
		if( ! b.val() ){
			b.trigger( 'click' );
			c.hide();
		}else{
			c.show();
			d.fadeIn( function(){});
		}
	});
	$( '.ae-upload .ae-cancel' ).on( 'click', function () {
		d.fadeOut();
	});
	b.on( 'change', function () {
		_this = this;
	 	if( ! a ){
			a = $( '.ae-upload .ae-crop' ).croppie({
			    enableExif: true,
			    viewport: {
			        width: awidth,
			        height: aheight,
			        type: 'square'
			    },
			    boundary: {
			        width: boundaryw,
			        height: boundaryh
			    }
			});
	 	}
	 	if( a ){
		 	d.fadeIn(function(){
			  	var reader = new FileReader();
			 	reader.onload = (function (e) {
			 		a.croppie( 'bind', {
			  			url: e.target.result
			  		}).then(function(){
			        	/*console.log( 'jQuery bind complete' );*/
			      	});	      
			    });
			    if( _this.files.length ){
			    	reader.readAsDataURL( _this.files[0] );
			    }
		 	});
		 }
	});
	$( '.ae-upload .ae-save' ).on( 'click', function () {
        a.croppie( 'result', {
            type: 'base64',
            size: 'original'
        }).then(function ( resp ){
	 		if( _this.files.length ){
	 			var filedata = _this.files[0];
                $.ajax({
                    type    : "POST",
                    url     : ae_addon.ajaxurl,
                    data    : {
                        action      : 'single_image_crop',
                        base64      : resp,
						file		: b.val(),
                        filename    : filedata.name,
                        filetype    : filedata.type,
                        attach_id    : attach_id,
						key	: $(b.attr( 'data-id' )).attr( 'id' ),
                    },
                    beforeSend: function( response ) {
                        if( ! d.find( '#save-loading' ).length ){
                        	d.find( '.cr-boundary' ).append( '<img id="save-loading" src="' + ae_addon.spinner2x + '" />' );
                        }
                    },
                    success: function( response ){
						if(response){
							var data = JSON.parse(response);
							attach_id = data.attach_id;
							if( data.attach_id && $(b.attr( 'data-id' )).length ){
						        e.find( 'img.image' ).attr( 'src', data.attach_url ).parent( '.ae-img-wrap' ).addClass( 'ae-img-active' );
						        $(b.attr( 'data-id' )).val( data.attach_url );
		                    	d.find( '#save-loading' ).remove();
		                    	d.fadeOut();
							}else{
						        e.find( 'img.image' ).parent( '.ae-img-wrap' ).removeClass( 'ae-img-active' );
								d.fadeOut();
								d.find( '#save-loading' ).remove();
								alert( 'ERROR #3: something went wrong !!!' );
							}
						}else{
							e.find( 'img.image' ).parent( '.ae-img-wrap' ).removeClass( 'ae-img-active' );
					 		d.fadeOut();
							d.find( '#save-loading' ).remove();
						 	alert( 'ERROR #4: something went wrong !!!' );
						}
                    },      
                });
			}
    	});
	});
}


	if($('#apmediaupload').length){
		$(document).delegate('#apmediaupload','click',function(){
			if(ae_loading){return;}
			ae_filed_id = $(this).attr('field_id');
			ae_popup_title = String($(this).attr('popup_title'));
			ae_multiple = $(this).attr('multiple');
			ae_upload_type = $(this).attr('upload_type');
			ae_media_type = $(this).attr('media_type');
			ae_submit_text = $(this).attr('submit_text');
			ae_key = $(this).attr('key');
			if(ae_multiple == 'true'){
				ae_multiple = true;
			}else if(ae_multiple == 'add'){
				ae_multiple = 'add';
			}else{
				ae_multiple = false;
			}
			if(ae_media_type == 'image'){
				ae = wp.media.frames.file_frame = wp.media({
					multiple: ae_multiple,
					title: ae_popup_title,
					type: ae_media_type,
					library:{type: ae_media_type},
					button:{text : ae_submit_text},
				});
				ae.on('select', function(){
					attachment = ae.state().get('selection').toJSON();
					var ids = [];
					var images = [];
					for (i = 0; i < attachment.length; i++){
						ids[i] = attachment[i]['id'];
						images[i] = attachment[i]['url'];
					}
					if(! ids){return;}
					if(ae_upload_type == 'single'){
						ids = ids[0];
					}
					$.ajax({
						type	: "POST",
						url		: ae.ajaxurl,
						data	:{
							action		: 'ae_ajax',
							ids			: ids,
							multiple	: ae_multiple,
							type		: ae_upload_type,
							media_type	: ae_media_type,
						},
						beforeSend: function(response){
							ae_loading = true;
							if(ae_upload_type == 'single'){
								$('.agfmu-' + ae_filed_id.replace('#','').replace(' ','')).css({
									'background-image' : "url('" + ae.homeurl + "/wp-includes/images/spinner-2x.gif')",
									'background-position' : 'center center',
									'background-repeat' : 'no-repeat',
									'background-size' : 'auto',
								});
							}		
						},
						success: function(response){
							if(response && ae_upload_type == 'single'){
								$(ae_filed_id).val(response);
							}	
							if(response && ae_upload_type == 'gallery'){
								var data = JSON.parse(response);
								$(ae_filed_id).val(data.ids);
							}
							if(response && ae_upload_type == 'single'){
								$('.agfmu-' + ae_filed_id.replace('#','').replace(' ','')).css({
									'background-image' : 'url('+images[0]+')',
									'background-size' : 'auto',
								});
							}
							if(response && ae_upload_type == 'gallery'){
								var data = JSON.parse(response);
								$('#gallery-' + ae_filed_id.replace('#', '').replace(' ', '')).html(data.preview);
							}
							setTimeout(function(){
								ae_loading = false;
							}, 300);
						},		
					});				
				});
				ae.on('open', function(){
					var selection =  ae.state().get('selection');
					ids = $('input' + ae_filed_id).val();
					if(ids){
						ids = ids.split(",");
						if(ids){
							ids.forEach(function(id){
								attachments = wp.media.attachment(id);
								attachments.fetch();
								selection.add(attachments ? [ attachments ] : []);
							});
						}
					}
				});
				ae.open();
			}
		});
	}
	$( window ).on( 'resize', function(){
		to(function(){
			if( window.innerWidth <= boundaryw ){
				a.destroy();
				boundaryw = 300,
				boundaryh = 200;
				croppie();
			}
		},200);
	});
	function ajax_search(id){
		name = $(id).attr('name');
		if(! $(id).val()){$('.rd-ajax .sr').html('').hide(); return;}
		$('.rd-ajax .sr').html('<span class="loading">&nbsp;</span>');
		to(function(){
			$.ajax({
				url		: ae.ajaxurl,
				type	: 'post',
				data	:{
							action	: 'location_ajax',
							value	: $(id).val(),
							name	: name	
						},
				success	: function(data){
					$('.rd-ajax .sr').html(data).show();
				}
			});
		}, 200);
	}
});