/**
 * Widget CSS Classes Plugin
 *
 * @author C.M. Kendrick <cindy@cleverness.org>
 * @package widget-css-classes
 * @version 1.5.2.1
 */

jQuery( document ).ready( function ( $ ) {

	// Change opacity if predefined classes is disabled.
	$( 'input.wcssc_type' ).on( 'change', function() {
		var val = $(this).val();
		if ( '2' === val || '3' === val ) {
			$('.wcssc_defined_classes').parents('tr').css( { 'opacity': '' } );
		} else {
			$('.wcssc_defined_classes').parents('tr').css( { 'opacity': '.5' } );
		}
	} ).filter(':checked').trigger('change');

	// Defined classes new and delete handlers.
	$( document ).on( 'click', '.wcssc_defined_classes.wcssc_sort_fixed .wcssc_copy', function(e) {
		e.preventDefault();
		var elem = $( this ).parents('.wcssc_defined_classes');
		var clone = elem.clone().hide().insertBefore( elem );
		clone.removeClass('wcssc_sort_fixed').find('.wcssc_copy').remove();
		clone.slideDown('fast');

	} ).on( 'click', '.wcssc_defined_classes .wcssc_remove', function(e) {
		e.preventDefault();
		$( this ).parent().slideUp( 'fast', function () {
			$( this ).remove();
		} );
	} );

	// Make defined classes sortable.
	if ( $.isFunction( $.fn.sortable ) ) {
		$('.wcssc_sortable .wcssc_sort').show();
		$('.wcssc_sortable').sortable({
			items: 'p:not(.wcssc_sort_fixed)',
			placeholder: 'wcssc_drop_placeholder'
		});
	}

} );