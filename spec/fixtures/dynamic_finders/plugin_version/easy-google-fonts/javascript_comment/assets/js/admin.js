/**===============================================================
 * Easy Google Fonts Admin js
 * ===============================================================
 * 
 * This file contains all custom jQuery plugins and code used on 
 * the Admin Font Settings Screen. It contains all of the js
 * code necessary to enable the custom controls used in the live
 * previewer.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, 
 * software distributed under the License is distributed on an 
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, 
 * either express or implied. See the License for the specific 
 * language governing permissions and
 * limitations under the License.
 *
 * PLEASE NOTE: The following jQuery plugin dependancies are required
 * in order for this file to run correctly:
 *
 * 1. jQuery			( http://jquery.com/ )
 * 2. jQuery UI			( http://jqueryui.com/ )
 *
 * @todo increase dependancy on JS in future releases.
 * 
 * @since 1.2
 * @version 1.4.3
 *
 * =============================================================== */

/**===============================================================
 * TAG PLUGIN
 * =============================================================== */
;( function($, window, document, undefined) {
	$.fn.themeFontManager = function() {
		var api = this;

		// Flag to listen for control changes
		var controlChanged = false;

		/**
		 * Setup Plugin
		 * 
		 * @description - Calls all of the required plugins 
		 *     for the Font Controls Admin Screen.
		 *
		 * @since 1.2
		 * @version 1.4.3
		 * 
		 */
		api.init = function() {
			api.setupInputWithDefaultTitle();
			api.registerEditEvents();
			api.registerManagementEvents();
			api.registerAdvancedEvents();
			api.unregisterChange();
			// Add unload event	
			$(window).on( 'beforeunload', function() {
				if ( controlChanged ) {
					return ttFontl10n.confirmation;
				}
			});
		};

		/**
		 * Register Control Changes
		 *
		 * @description - Set the controlChanged variable to 
		 *     true to flag any unsaved changes in the admin 
		 *     interface.
		 *
		 * @since 1.2
		 * @version 1.4.3
		 * 
		 */
		api.registerChange = function() {
			controlChanged = true;
		};

		/**
		 * Unregister Control Changes
		 *
		 * @description - Set the controlChanged variable to 
		 *     true to flag any unsaved changes in the admin 
		 *     interface.
		 * 
		 * @since 1.2
		 * @version 1.4.3
		 * 
		 */
		api.unregisterChange = function() {
			controlChanged = false;
		};

		/**
		 * Create Control Using AJAX
		 *
		 * Sends an AJAX request in order to create a new
		 * font control instance.
		 * 
		 * @param  {string}   controlName    - The font control name
		 * @param  {function} processMethod  - Function to run during an ajax request
		 * @param  {function} callback       - Function to run after a successful ajax request
		 * 
		 * @since 1.2
		 * @version 1.4.3
		 * 
		 */
		api.createNewControl = function( controlName, processMethod, callback ) {
			api.unregisterChange();

			processMethod = processMethod || function(){};
			callback      = callback || function(){};
			var nonce     = $( '#tt_font_edit_control_instance_nonce' ).val();

			var dataObj = {
				'action': 'tt_font_create_control_instance',
				'tt_font_edit_control_instance_nonce' : nonce,
				'control_name' : controlName
			};

			$.post( ajaxurl, dataObj, function() {
				processMethod();
			}).done( function(response) {
				var newControlId;
				var redirectUrl = $( '#create_control_header' ).attr( 'data-redirect-url' );

				callback();

				// Get new control ID 
				$(response).find('supplemental').each(function(){
					newControlId = $(this).find('new_control_id').text();
					redirectUrl  += '&control=' + newControlId;
				});

				// Redirect the user to the newly created control
				window.location = redirectUrl.replace( ' ', '+' );
			});
		};
		
		/**
		 * Save Font Control Using AJAX
		 *
		 * @description - Sends an AJAX request in order to 
		 *     delete a specific font control with the id that 
		 *     matches the value passed into this function. 
		 * 
		 * @param  {string}   controlName    - Font control name
		 * @param  {string}   controlId      - Font control id
		 * @param  {function} processMethod  - Function to run during an ajax request
		 * @param  {function} callback       - Function to run after a successful ajax request
		 * 
		 * @since 1.2
		 * @version 1.4.3
		 * 
		 */
		api.saveControl = function( controlName, controlId, turnOn, processMethod, callback ) {
			api.unregisterChange();

			controlName          = controlName || '';
			controlId            = controlId || '0';
			processMethod        = processMethod || function(){};
			callback             = callback || function(){};
			var nonce            = $( '#tt_font_edit_control_instance_nonce' ).val();
			var controlSelectors = {};
			var position         = 0;

			$('#tt-font-tags li .tagit-label').each( function(e){
				controlSelectors[position] = $(this).text();
				position++;
			});

			var dataObj = {
				'action': 'tt_font_update_control_instance',
				'controlName' : controlName,
				'controlId': controlId,
				'force-styles': turnOn,
				'tt_font_edit_control_instance_nonce' : nonce,
				'control-selectors' : controlSelectors
			};
			
			$.post( ajaxurl, dataObj, function() {
				processMethod();
			}).done( function( response ) {
				var newControlName;
				// Get new control name
				$(response).find('supplemental').each(function(){
					newControlName = $(this).find('control_name').text();
				});
				callback( newControlName );
			});
		};

		/**
		 * Delete Font Control Using AJAX
		 *
		 * @description - Sends an AJAX request in order to 
		 *     delete a specific control with the id that 
		 *     matches the value passed into this function. 
		 * 
		 * @param  {string}   controlId      - The ID (post meta id not post id) of the control we want to delete
		 * @param  {function} processMethod  - Function to run during an ajax request
		 * @param  {function} callback       - Function to run after a successful ajax request
		 * 
		 * @since 1.2
		 * @version 1.4.3
		 * 
		 */
		api.deleteControl = function( controlId, processMethod, callback ) {
			api.unregisterChange();

			processMethod = processMethod || function(){};
			callback      = callback || function(){};
			var nonce     = $( '#tt_font_delete_control_instance_nonce' ).val();

			var dataObj = {
				'action': 'tt_font_delete_control_instance',
				'controlId': controlId,
				'tt_font_delete_control_instance_nonce' : nonce
			};

			$.post( ajaxurl, dataObj, function() {
				processMethod();
			}).done( function() {
				callback();
			});
		};

		/**
		 * Delete All Font Controls Using AJAX
		 *
		 * @description - Constructs an AJAX request to 
		 *     delete all control instances. Sends the 
		 *     WordPress generated nonce to ensure that 
		 *     this is a legitamate request.
		 * 
		 * @param  {Function}   processMethod - Function to execute during request
		 * @param  {Function}   callback      - Function to execute after successful AJAX reequest.
		 *
		 * @since 1.2
		 * @version 1.4.3
		 * 
		 */
		api.deleteAllControls = function( processMethod, callback ) {
			api.unregisterChange();

			processMethod = processMethod || function(){};
			callback      = callback || function(){};
			var nonce     = $( '#tt_font_delete_control_instance_nonce' ).val();

			var dataObj = {
					'action': 'tt_font_delete_all_control_instances',
					'tt_font_delete_control_instance_nonce' : nonce
			};

			$.post( ajaxurl, dataObj, function() {
				processMethod();
			}).done( function() {
				callback();
			});
		};
		
		/**
		 * Turn Control Force Styles On/Off using AJAX
		 *
		 * @description - Constructs an AJAX request to 
		 *     turn force styles on/off for a control. 
		 *     Sends the WordPress generated nonce to 
		 *     ensure that this is a legitamate request.
		 * 
		 * @param  {string}     controlId     - ID of the Control
		 * @param  {string}     turnOn        - true/false to turn on/off
		 * @param  {Function}   processMethod - Function to execute during request
		 * @param  {Function}   callback      - Function to execute after successful AJAX reequest.
		 * 
		 * @since 1.2
		 * @version 1.4.3
		 * 
		 */
		api.forceControls = function( controlId, turnOn, processMethod, callback ) {
			api.unregisterChange();
			
			processMethod = processMethod || function(){};
			callback      = callback || function(){};
			var nonce     = $( '#tt_font_edit_control_instance_nonce' ).val();

			var dataObj = {
					'action': 'tt_font_control_force_styles',
					'controlId': controlId,
					'tt_font_edit_control_instance_nonce' : nonce,
					'force-styles': turnOn
			};

			$.post( ajaxurl, dataObj, function() {
				processMethod();
			}).done( function() {
				callback();
			});
		};

		api.updateGoogleApiKey = function( apiKey, processMethod, callback ) {
			api.unregisterChange();
			
			processMethod = processMethod || function(){};
			callback      = callback || function(){};
			var nonce     = $( '#tt_font_edit_control_instance_nonce' ).val();

			var dataObj = {
				'action': 'tt_font_set_google_api_key',
				'apiKey': apiKey,
				'tt_font_edit_control_instance_nonce' : nonce
			};

			$.post( ajaxurl, dataObj, function() {
				processMethod();
			}).done( function() {
				var redirectUrl = $( '#egf_save_api_key' ).data( 'redirect-url' );
				callback( redirectUrl );
			});			
		};
		
		/**
		 * Set Input Placeholder Text
		 *
		 * @description - Provides a cross browser compatible 
		 *     way to set placeholder text for input fields.
		 *
		 * @since 1.2
		 * @version 1.4.3
		 * 
		 */
		api.setupInputWithDefaultTitle = function() {
			var name = 'input-with-default-title';

			$( '.' + name ).each( function(){
				var $t    = $(this);
				var title = $t.attr('title');
				var val   = $t.val();
				$t.data( name, title );

				if( '' === val ) {
					$t.val( title );
				} else if( title === val ) {
					return;
				} else {
					$t.removeClass( name );
				}

				// Add class on input focus event
				$t.on( 'focus', function() {
					if( $t.val() === $t.data(name) ) {
						$t.val('').removeClass( name );
					}
				});

				// Remove class on input blur event
				$t.on( 'blur', function() {
					if( '' === $t.val() ) {
						$t.addClass( name ).val( $t.data(name) );
					}
				});

			});

			$( '.blank-slate .input-with-default-title' ).focus();
		};

		/**
		 * Register Edit Events
		 *
		 * @description - Registers all event handlers that
		 *     exist on the Edit Font Controls page.
		 * 
		 * @since 1.2
		 * @version 1.4.3
		 * 
		 */
		api.registerEditEvents = function() {
			
			// Font Control change event listeners
			$( '#custom-control-name, #tt-font-tags, #control-force-styles' ).on( 'change', function(){
				api.registerChange();
			});

			/**
			 * Create Event
			 * Attach event listener in order to create a new font
			 * control instance.
			 */
			$( '#create_control_header, #create_control_footer' ).on( 'click', function() {

				var controlNameLabel = $( '.custom-control-label' );
				var controlNameInput = $( '#custom-control-name' );
				var spinner          = $( '.control-edit .spinner' );

				if ( controlNameInput.attr('title') === controlNameInput.val() ) {
					controlNameLabel.addClass('form-invalid');
					return false;

				} else {
					controlNameLabel.removeClass('form-invalid');
					spinner.toggleClass( "egf-visible", 200 );
					// spinner.fadeIn(200);
					api.createNewControl( controlNameInput.val(), false );
				}

				return false;
			});

			/**
			 * Save/Update Event
			 * Attaches an event listener to the 'Save Font Control' 
			 * buttons.
			 */
			 $( '#save_control_header, #save_control_footer' ).on( 'click', function() {
				
				var controlName      = $( '#custom-control-name' ).val();
				var controlId        = $(this).attr( 'data-control-id' );
				var spinner          = $( '.control-edit .spinner' );
				var controlNameLabel = $( '.custom-control-label' );
				var redirectUrl      = $(this).attr( 'data-redirect-url' );
				var forceStyles      = $( '#control-force-styles' ).prop('checked');

				var processMethod = function() {};
				var callback      = function( newControlName ) {

					// Fade out spinner and redirect user
					spinner.toggleClass( "egf-visible", 200 );
					// spinner.fadeOut(200);
					redirectUrl  += '&name=' + newControlName;
					window.location = redirectUrl.replace( ' ', '+' );
				};

				// Make sure a control name has been entered
				if ( $( '#custom-control-name' ).attr( 'title' ) === controlName ) {
					controlNameLabel.addClass('form-invalid');
					return false;
				}

				controlNameLabel.removeClass('form-invalid');

				spinner.toggleClass( "egf-visible", 150 );
				// spinner.fadeIn(100);
				api.saveControl( controlName, controlId, forceStyles, processMethod, callback );
				return false;

			 });
			
			/**
			 * Delete Font Control Event
			 * Attaches an event listener to each font control 
			 * 'Delete Font Control' link.
			 */
			$( '#delete-control' ).on( 'click', function() {

				var confirmation = confirm( ttFontl10n.deleteWarning );
				var controlId    = $(this).attr( 'data-control-id' );
				var spinner      = $( '.control-edit .spinner' );
				var redirectUrl  = $(this).attr( 'data-redirect-url' );

				var processMethod = function() {};
				var callback      = function() {
					api.unregisterChange();
					window.location = redirectUrl.replace( ' ', '+' );
				};

				// Delete control now that we have gained user consent
				if( confirmation ) {
					if( controlId !== '0' ) {
						spinner.toggleClass( "egf-visible", 200 );
						// spinner.fadeIn(200);
						api.deleteControl( controlId, processMethod, callback );
					} else {
						callback();
					}
				}
				return false;
			});
		};

		/**
		 * Register Management Events
		 *
		 * @description - Registers all event handlers that
		 *     exist on the Manage Font Controls page.
		 *
		 * @since 1.2
		 * @version 1.4.3
		 */
		api.registerManagementEvents = function() {
			
			/**
			 * Create New Control Event
			 * Attaches an event listener to the create new control button.
			 */
			$( '#create_new_control' ).on( 'click', function() {
				window.location =  $(this).attr( 'data-create-control-url' );
				return false;
			});

			/**
			 * Control Delete Control Link
			 * Attaches an event listener to the 'delete' link for
			 * each control.
			 */
			$( '#font-controls-table a.control-delete-link' ).on( 'click', function() {
				var confirmation = confirm( ttFontl10n.deleteWarning );
				var row          = $(this).closest('tr');
				var spinner      = row.find( '.spinner' );
				var controlId    = $(this).data( 'control-reference' );

				var processMethod = function() {};
				var callback      = function() {
					row.fadeOut(200, function() { 
						row.remove();

						// Update dialog screen if there are no controls
						if ( $( '#font-controls-table tbody tr' ).length === 0 ) {

							// Fade out the table if there are no controls
							$( '#font-controls-table' ).fadeOut(500);

							// Update control dialog if there are no controls
							$( '.control-dialog .manage-label' ).fadeOut(200, function(){
								$( '.control-dialog .new-label' ).fadeIn(300);
							});
						}
					});
				};

				// Delete control now that we have gained user consent.
				if( confirmation ) {
					spinner.toggleClass( "egf-visible", 200 );
					// spinner.fadeIn();
					row.addClass('deleting', 200);
					api.deleteControl( controlId, processMethod, callback );
				}

			});
			
			/**
			 * Control Force Styles
			 * @return {[type]} [description]
			 */
			$( '#font-controls-table .tt-force-styles' ).on( 'change', function() {

				var row          = $(this).closest('tr');
				var spinner      = row.find( '.spinner' );
				var controlId    = $(this).data( 'control-reference' );
				var checked      = $(this).prop('checked');

				var processMethod = function() {};
				var callback      = function() {
					spinner.toggleClass( "egf-visible", 200 );
					// spinner.fadeOut(200);
					row.addClass('success', 200);
					row.removeClass('success', 300);
				};

				spinner.toggleClass( "egf-visible", 200 );
				// spinner.fadeIn();
				api.forceControls( controlId, checked, processMethod, callback );

			});

			/**
			 * Control Delete All Event
			 * Attaches an event listener to the 'delete all' link.
			 */
			$( '#delete_all_controls' ).on( 'click', function() {

				var confirmation = confirm( ttFontl10n.deleteAllWarning );
				var spinners     = $( '#font-controls-table .spinner' );
				var rows         = $( '#font-controls-table tr' );

				var processMethod = function() {};
				var callback      = function() {
					rows.fadeOut(200);

					// Fade out the table if there are no controls
					$( '#font-controls-table, #delete_all_controls' ).fadeOut(500);

					// Update control dialog if there are no controls
					$( '.control-dialog .manage-label' ).fadeOut(200, function(){
						$( '.control-dialog .new-label' ).fadeIn(300);
					});
				};

				// Delete all controls now that we have gained user consent
				if( confirmation ) {
					spinners.fadeIn();
					rows.addClass( 'deleting', 200 );
					api.deleteAllControls( processMethod, callback );
				}

				return false;
			});

			/**
			 * Initialise the tag-it plugin
			 * Attaches an event listener to the tags and
			 * sets up the functionality.
			 */
			$( '#tt-font-tags' ).tagit({
				allowSpaces: true,
				allowDuplicates: true,
				removeConfirmation: true,
				preprocessTag: function( value ) {
					if ( ! value ) {
						return '';
					}
					return value;
				},
				beforeTagAdded: function() {
					api.registerChange();
				},
				afterTagRemoved: function() {
					api.registerChange();
				}
			});

			// Prevent form submit on input enter
			$( 'li.tagit-new input' ).keypress(function(e){
			var k = e.keyCode || e.which;
				if( k==13 ){
					e.preventDefault();
				}
			});
		};

		/**
		 * Register Advanced Events
		 *
		 * @description - Registers all event handlers that
		 *     exist on the Advanced page.
		 * 
		 * @since 1.2
		 * @version 1.4.3
		 * 
		 */
		api.registerAdvancedEvents = function() {
			
			var container = $( '.manage-google-key' );
			var spinner   = $( '.spinner' );
			
			$( '#egf-google-api-key' ).on( 'change', function() {
				api.registerChange();
			});

			$( '#egf_save_api_key' ).on( 'click', function() {
				var apiKey      = $( '#egf-google-api-key' ).val();
				var redirectUrl = $(this).data( 'redirect-url' );

				var processMethod = function() {};
				var callback      = function( redirectUrl ) {
					// Fade out spinner and redirect user
					spinner.toggleClass( "egf-visible", 200 );
					// spinner.fadeOut(200);
					window.location = redirectUrl;
				};

				spinner.toggleClass( "egf-visible", 300 );
				// spinner.fadeIn();

				api.updateGoogleApiKey( apiKey, processMethod, callback );

				return false;
			});

		};

		// Initialise Plugin
		api.init();

	}; // END $.fn.themeFontManager
}(jQuery, window, document));

/**============================================================
 * INITIALISE PLUGINS & JS ON DOCUMENT READY EVENT
 * ============================================================ */
jQuery(document).ready(function($) {"use strict";
	// Initialise Theme Font Admin Manager
	$(this).themeFontManager();
});
