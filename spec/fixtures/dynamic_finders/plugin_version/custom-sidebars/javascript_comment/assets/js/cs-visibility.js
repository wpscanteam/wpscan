/*! Custom Sidebars - v3.1.2
 * https://premium.wpmudev.org/project/custom-sidebars-pro/
 * Copyright (c) 2018; * Licensed GPLv2+ */
/*global jQuery:false */
/*global window:false */
/*global document:false */
/*global wp:false */
/*global wpmUi:false */

jQuery(function init_visibility() {
	var $doc = jQuery( document );

	/**
	 * Moves the "Visibility" button next to the save button.
	 */
	var init_widget = function init_widget( ev, el ) {
		var $widget = jQuery( el ).closest( '.widget' ),
			$btn = $widget.find( '.csb-visibility-button' ),
			$target = $widget.find( '.widget-control-actions .widget-control-save' ),
			$spinner = $widget.find( '.widget-control-actions .spinner' );

		if ( $widget.data( '_csb_visibility' ) ) {
			return;
		}

		$spinner.insertBefore( $target ).css({ 'float': 'left' });
		$btn.insertBefore( $target ).click( toggle_section );
		$widget.on( 'click', '.toggle-action b', toggle_action );
		$widget.on( 'csb:update', update_display );
		$widget.on( 'click', '.clear-filter', remove_filter );
		$widget.on( 'click', '.choose-filters', show_filter_menu );
		$widget.on( 'click', '.add-filter', add_filter );
		$widget.on( 'change', 'input[data-lbl-all][data-lbl-single]', toggle_label );
		$widget.on( 'change', 'select.posttype', update_posttypes );

		$widget.data( '_csb_visibility', true );
	};

	/**
	 * Removes the current filter row from the conditions
	 */
	var remove_filter = function remove_filter( ev ) {
		var $me = jQuery( this ),
			$row = $me.closest( '.csb-option-row' ),
			$widget = $me.closest( '.widget' ),
			sel = '.' + jQuery.trim( $row.attr( 'class' ).replace( 'csb-option-row', '') ),
			$add_item = $widget.find( '[data-for="' + sel + '"]' ),
			$input = $row.find( 'input, select, textarea' );

		ev.preventDefault();
		$add_item.show();
		$row.fadeOut( 400, function clear_values() {
			// After row is hidden clear the input values.
			$input.val('').trigger('change.select2');
			$widget.trigger('csb:update');
		} );
		return false;
	};

	/**
	 * User clicks on a new filter option in the "Add filter" dropdown.
	 * Show the filter row.
	 */
	var add_filter = function add_filter( ev ) {
		var $me = jQuery( this ),
			sel = $me.data( 'for' ),
			$widget = $me.closest( '.widget' ),
			$always = $widget.find( '.csb-always' ),
			$filter = $widget.find( sel );

		ev.preventDefault();
		$filter.show();
		$me.hide();
		$always.hide();
		hide_filter_menu();
		$widget.trigger('csb:update');
		return false;
	};

	/**
	 * When a filter block is added or removed we need to show/hide some hints.
	 */
	var update_display = function update_display() {
		var $widget = jQuery( this ).closest( '.widget' ),
			$always = $widget.find( '.csb-always' ),
			$rows = $widget.find( '.csb-option-row:visible:not(.csb-action,.csb-always)' );

		if ( $rows.length === 0 ) {
			$always.show();
		} else {
			$always.hide();
			$rows.find( '.csb-and' ).show();
			$rows.first().find( '.csb-and' ).hide();
		}
		wpmUi.upgrade_multiselect( $widget );
	};

	/**
	 * Let user add a new filter.
	 */
	var show_filter_menu = function show_filter_menu( ev ) {
		var $me = jQuery( this ),
			$row = $me.closest( '.csb-option-row' ),
			$menu = $row.find( '.dropdown' );

		ev.preventDefault();
		$menu.show();
		$doc.one( 'click', hide_filter_menu );
		return false;
	};

	/**
	 * Close the filter menu again.
	 */
	var hide_filter_menu = function hide_filter_menu( ev ) {
		jQuery( '.csb-action .dropdown:visible' ).hide();
	};

	/**
	 * Shows or hides the visibility-options for the current widget.
	 */
	var toggle_section = function toggle_section( ev ) {
		var $me = jQuery( this ),
			$widget = $me.closest( '.widget' ),
			$section = $widget.find( '.csb-visibility-inner' ),
			$flag = $section.find( '.csb-visible-flag' );

		ev.preventDefault();
		if ( $flag.val() === '0' ) {
			$flag.val('1');
			$section.show();
			$widget.trigger('csb:update');
		} else {
			$flag.val('0');
			$section.hide();
		}

		return false;
	};

	/**
	 * Toggles the widget state between "show if" / "hide if"
	 */
	var toggle_action = function toggle_action( ev ) {
		var $me = jQuery( this ).closest( 'label' ),
			$widget = $me.closest( '.widget' ),
			sel = '#' + $me.attr( 'for' ),
			$action = $widget.find( sel ),
			state = $action.val(),
			$lbl_show = $widget.find( '.lbl-show-if' ),
			$lbl_hide = $widget.find( '.lbl-hide-if' );

		ev.preventDefault();
		if ( 'show' !== state ) {
			$lbl_show.show();
			$lbl_hide.hide();
			$action.val( 'show' );
		} else {
			$lbl_show.hide();
			$lbl_hide.show();
			$action.val( 'hide' );
		}
		return false;
	};

	/**
	 * Used for the posttype filter: When user changes the "All posts" checkbox
	 * the label will toggle between "All posts" and "Only these posts".
	 */
	var toggle_label = function toggle_label( ev ) {
		var $me = jQuery( this ).closest( 'label' ),
			$row = $me.closest( '.csb-detail-row' ),
			$inp = $me.find( 'input[type=checkbox]' ),
			$lbl = $me.find( '.lbl' ),
			$detail = $row.find( '.detail' ),
			$detail_inp = $detail.find( 'input,select,textarea' );

		if ( $inp.prop( 'checked' ) ) {
			$lbl.text( $inp.data( 'lbl-single' ) );
			$detail.show();
		} else {
			$lbl.text( $inp.data( 'lbl-all' ) );
			$detail.hide();
			$detail_inp.val('').trigger('change.select2');
		}
	};

	/**
	 * When the user changes the posttype-filter show or hide the detail-rows
	 * for each posttype.
	 */
	var update_posttypes = function update_posttypes( ev ) {
		var $me = jQuery( this ),
			$row = $me.closest( '.csb-option-row' ),
			$types = $row.find( '.csb-detail-row' ),
			types = $me.val(),
			i;

		$types.addClass( 'csb-hide' );
		if ( types ) {
			for ( i = 0; i < types.length; i += 1 ) {
				$types.filter( '.csb-pt-' + types[i] ).removeClass( 'csb-hide ');
			}
		}

		$types.each(function check_detail_row() {
			var $detail = jQuery( this ),
				$check = $detail.find( 'input[type=checkbox]' );

			if ( $detail.hasClass( 'csb-hide' ) ) {
				$detail.hide();
				$check.prop( 'checked', false );
				toggle_label.call( $check );
			} else {
				$detail.show();
			}
		});
	};

	jQuery( '#widgets-right .widget' ).each( init_widget );
	$doc.on( 'widget-added', init_widget );
});
