/*!
 *  Script: chldthmcfg.js
 *  Plugin URI: http://www.childthemeconfigurator.com/
 *  Description: Handles jQuery, AJAX and other UI
 *  Version: 2.2.8.1
 *  Author: Lilaea Media
 *  Author URI: http://www.lilaeamedia.com/
 *  License: GPLv2
 *  Copyright (C) 2014-2017 Lilaea Media
 */

// ** for multiple property values: **
// make sure sequence is passed with rule/val updates
// determine sequence based on sequence of value array
// add sequence to input name

( function( $ ) {
    'use strict';
    $.chldthmcfg = {
        //console.log( 'executing main function' );
        escquo: function( str ) {
            var self = this;
            return self.is_empty( str ) ? str : str.toString().replace( /"/g, '&quot;' );
        },
                
        getxt: function( key, merge ){
            var text = window.ctcAjax[ key + '_txt' ];
            if ( text ) {
                if ( merge ) {
                    text = text.replace( /%s/, merge );
                }
                return text;
            }
            return '';
        },
        
        getname: function( themetype ){
            var self = this,
                stylesheet  = ( 'child' === themetype ? $.chldthmcfg.currchild : $.chldthmcfg.currparnt );
            //console.log( 'getname: ' + stylesheet );
            //console.log( window.ctcAjax.themes );
            if ( self.is_empty( window.ctcAjax.themes[ themetype ][ stylesheet ] ) ){
                return '';
            } else {
                return window.ctcAjax.themes[ themetype ][ stylesheet ].Name;
            }
        },
        
        frascii: function( str ) {
            var ascii = parseInt( str ),
                chr = String.fromCharCode( ascii );
            return chr;
        },
                
        toascii: function( str ) {
            var ascii = str.charCodeAt( 0 );
            return ascii;
        },
        
        /**
         * is_empty
         * return true if value evaluates to false, null, null string, 
         * empty array, empty object or undefined
         * but NOT 0 ( zero returns false ) unless zero flag is passed
         */
        is_empty: function( obj, zeros ) {
            // first bail when definitely empty or undefined ( true ) NOTE: numeric zero returns false !
            if ( 'undefined' === typeof obj || false === obj || null === obj || '' === obj ) { 
                // console.log( 'matched empty' ); 
                return true; 
            }
            // if zeros flag is set, return true for 0 or '0'
            if ( 'undefined' !== typeof zeros && '0' === obj || 0 === obj ) { 
                // console.log( 'matched zero literal:' + obj ); 
                return true; 
            }
            // then, if this is bool, string or number it must not be empty ( false )
            if ( true === obj || "string" === typeof obj || "number" === typeof obj ) { 
                return false; 
            }
            // check for object type to be safe
            if ( "object" === typeof obj ) {    
                // Use a standard for in loop
                for ( var x in obj ) {
                    // for in will iterate over members on the prototype
                    // chain as well, but Object.getOwnPropertyNames returns
                    // only those directly on the object, so use hasOwnProperty.
                    if ( obj.hasOwnProperty( x ) ) {
                        // any value means not empty ( false )
                        return false;
                    }
                }
                // no properties, so return empty ( true )
                return true;
            } 
            // this must be an unsupported datatype, so return not empty
            return false; 
        },
        
        /**
         * theme_exists
         * returns true if theme is already present for type
         */
        theme_exists: function( testslug, testtype ) {
            var exists = false;
            $.each( window.ctcAjax.themes, function( type, theme ) {
                $.each( theme, function( slug, data ) {
                    data = null;
                    if ( slug.toLowerCase() === testslug.toLowerCase() && ( 'parnt' === type || 'new' === testtype ) ) {
                        exists = true;  // no need to continue testing
                        return false;   // in this context "return false" means "break"
                    }
                } );
                if ( exists ) {         // no need to continue testing
                    return false;       // in this context "return false" means "break"
                }
            } );
            return exists;
        },
        
        validate: function() {
            var self    = this,
                regex   = /[^\w\-]/g,
                newslug = $( '#ctc_child_template' ).length ? $( '#ctc_child_template' )
                    .val().toString().replace( regex ) : '',
                slug    = $( '#ctc_theme_child' ).length && !self.is_empty( $( '#ctc_theme_child' ).val() ) ? $( '#ctc_theme_child' )
                    .val().toString().replace( regex ) : newslug,
                type    = $( 'input[name=ctc_child_type]:checked' ).val(),
                errors  = [];
            if ( 'new' === type ) {
                slug = newslug;
            }
            if ( self.theme_exists( slug, type ) ) {
                errors.push( self.getxt( 'theme_exists' ).toString().replace( /%s/, slug ) );
            }
            if ( self.is_empty( slug ) ) {
                errors.push( self.getxt( 'inval_theme' ) );
            }
            //if ( self.is_empty( $( '#ctc_child_name' ).val() ) ) {
            //    errors.push( self.getxt( 'inval_name' ) );
            //}
            if ( errors.length ) {
                self.set_notice( { 'error': errors } );
                return false;
            }
            if ( 'reset' === type ) {
                if ( confirm( self.getxt( 'load' ) ) ) { 
                    return true; 
                }
                return false;
            }
            return true;
        },
        
        autogen_slugs: function() {
            if ( $( '#ctc_theme_parnt' ).length ) {
                var self    = this,
                    parent  = $( '#ctc_theme_parnt' ).val(),
                    child   = $( '#ctc_theme_child' ).length ? $( '#ctc_theme_child' ).val() : '',
                    slugbase= ( '' !== child && $( '#ctc_child_type_duplicate' ).is( ':checked' ) ) ? child : parent + '-child',
                    slug    = slugbase,
                    name    = ( '' !== child && $( '#ctc_child_type_duplicate' ).is( ':checked' ) ) ? $.chldthmcfg.getname( 'child' ) : $.chldthmcfg.getname( 'parnt' ) + ' Child',
                    suffix  = '',
                    padded  = '',
                    pad     = '00';
                while ( self.theme_exists( slug, 'new' ) ) {
                    suffix  = ( self.is_empty( suffix ) ? 2 : suffix + 1 );
                    padded  = pad.substring( 0, pad.length - suffix.toString().length ) + suffix.toString();
                    slug    = slugbase + padded;
                }
                self.testslug = slug;
                self.testname = name + ( padded.length ? ' ' + padded : '' );
                //console.log( 'autogen_slugs: parent: ' + parent + ' slug: ' + slug );
            }
        },
        
        focus_panel: function( id ) {
            var panelid = id + '_panel';
            $( '.nav-tab' ).removeClass( 'nav-tab-active' );
            $( '.ctc-option-panel' ).removeClass( 'ctc-option-panel-active' );
            //$( '.ctc-selector-container' ).hide();
            $( id ).addClass( 'nav-tab-active' );
            $( '.ctc-option-panel-container' ).scrollTop( 0 );
            $( panelid ).addClass( 'ctc-option-panel-active' );
        },
        
        selector_input_toggle: function( obj ) {
            //console.log( 'selector_input_toggle: ' + obj );
            var self = this,
                origval;
            if ( $( '#ctc_rewrite_selector' ).length ) {
                origval = $( '#ctc_rewrite_selector_orig' ).val();
                $( '#ctc_sel_ovrd_selector_selected' ).text( origval );
                $( obj ).text( self.getxt( 'rename' ) );
            } else {
                origval = $( '#ctc_sel_ovrd_selector_selected' ).text();
                $( '#ctc_sel_ovrd_selector_selected' ).html( 
                    '<textarea id="ctc_rewrite_selector"' +
                    ' name="ctc_rewrite_selector" autocomplete="off"></textarea>' +
                    '<input id="ctc_rewrite_selector_orig" name="ctc_rewrite_selector_orig"' +
                    ' type="hidden" value="' + self.escquo( origval ) + '"/>' );
                $( '#ctc_rewrite_selector' ).val( origval );
                $( obj ).text( self.getxt( 'cancel' ) );
            }
        },
            
        coalesce_inputs: function( obj ) {
            //**console.log( 'coalesce_inputs ' + $( obj ).attr( 'id' ) );
            var self        = this,
                id          = $( obj ).attr( 'id' ),
                regex       = /^(ctc_(ovrd|\d+)_(parent|child)_([0-9a-z\-]+)_(\d+?)(_(\d+))?)(_\w+)?$/,
                container   = $( obj ).parents( '.ctc-selector-row, .ctc-parent-row' ).first(),
                swatch      = container.find( '.ctc-swatch' ).first(),
                cssrules    = { 'parent': {}, 'child': {} },
                gradient    = { 
                    'parent': {
                        'origin':   '',
                        'start':    '',
                        'end':      ''
                    }, 
                    'child': {
                        'origin':   '',
                        'start':    '',
                        'end':      ''
                    } 
                },
                has_gradient    = { 'child': false, 'parent': false },
                postdata        = {};
            // set up objects for all neighboring inputs
            container.find( '.ctc-parent-value, .ctc-child-value' ).each( function() {
                var inputid     = $( this ).attr( 'id' ),
                    inputparts  = inputid.toString().match( regex ),
                    inputseq    = inputparts[ 2 ],
                    inputtheme  = inputparts[ 3 ],
                    inputrule   = ( 'undefined' === typeof inputparts[ 4 ] ? '' : inputparts[ 4 ] ),
                    rulevalid   = inputparts[ 7 ],
                    qsid        = inputparts[ 5 ],
                    rulepart    = ( 'undefined' === typeof inputparts[ 7 ] ? '' : inputparts[ 8 ] ),
                    value       = ( 'parent' === inputtheme ? $( this ).text().replace( /!$/, '' ) : 
                                    ( 'seq' !== inputrule && 'ctc_delete_query_selector' === id ? '' : 
                                        $( this ).val() ) ), // clear values if delete was clicked
                    important   = ( 'seq' === inputrule ? false : 'ctc_' + inputseq + '_child_' + inputrule + '_i_' + qsid + '_' + rulevalid ),
                    parts, subparts;
                //**console.log( inputparts );
                //**console.log( 'value: ' + value );
                if ( 'child' === inputtheme ) {
                    if ( !self.is_empty( $( this ).data( 'color' ) ) ) {
                        value = self.color_text( $( this ).data( 'color' ) );
                        $( this ).data( 'color', null );
                    }
                    postdata[ inputid ]     = value;
                    if ( important ) {
                        postdata[ important ]   = ( $( '#' + important ).is( ':checked' ) ) ? 1 : 0;
                    }
                }
                if ( '' !== value ) {
                    // handle specific inputs
                    if ( !self.is_empty( rulepart ) ) {
                        switch( rulepart ) {
                            case '_border_width':
                                cssrules[ inputtheme ][ inputrule + '-width' ] = ( 'none' === value ? 0 : value );
                                break;
                            case '_border_style':
                                cssrules[ inputtheme ][ inputrule + '-style' ] = value;
                                break;
                            case '_border_color':
                                cssrules[ inputtheme ][ inputrule + '-color' ] = value;
                                break;
                            case '_background_url':
                                cssrules[ inputtheme ][ 'background-image' ] = self.image_url( inputtheme, value );
                                break;
                            case '_background_color':
                                cssrules[ inputtheme ][ 'background-color' ] = value; // was obj.value ???
                                break;
                            case '_background_color1':
                                gradient[ inputtheme ].start   = value;
                                has_gradient[ inputtheme ] = true;
                                break;
                            case '_background_color2':
                                gradient[ inputtheme ].end     = value;
                                has_gradient[ inputtheme ] = true;
                                break;
                            case '_background_origin':
                                gradient[ inputtheme ].origin  = value;
                                has_gradient[ inputtheme ] = true;
                                break;
                        }
                    } else {
                        // handle borders
                        if ( ( parts = inputrule.toString().match( /^border(\-(top|right|bottom|left))?$/ ) && !value.match( /none/ ) ) ) {
                            var borderregx = new RegExp( self.border_regx + self.color_regx, 'i' );
                            subparts = value.toString().match( borderregx );
                            //**console.log( 'border after regex: ');
                            //**console.log( value );
                            //**console.log( borderregx );
                            //**console.log( subparts );
                            if ( !self.is_empty( subparts ) ) {
                                subparts.shift();
                                cssrules[ inputtheme ][ inputrule + '-width' ] = subparts.shift() || '';
                                subparts.shift();
                                cssrules[ inputtheme ][ inputrule + '-style' ] = subparts.shift() || '';
                                cssrules[ inputtheme ][ inputrule + '-color' ] = subparts.shift() || '';
                            }
                        // handle background images
                        } else if ( 'background-image' === inputrule && !value.match( /none/ ) ) {
                            if ( value.toString().match( /url\(/ ) ) {
                                cssrules[ inputtheme ][ 'background-image' ] = self.image_url( inputtheme, value );
                            } else {
                                var gradregex = new RegExp( self.grad_regx + self.color_regx + self.color_regx, 'i' );
                                subparts = value.toString().match( gradregex );
                            //**console.log( 'background-image after regex: ');
                                    //**console.log( value );
                                    //**console.log( gradregex );
                                    //**console.log( subparts );
                                if ( !self.is_empty( subparts ) && subparts.length > 2 ) {
                                    subparts.shift();
                                    gradient[ inputtheme ].origin = subparts.shift() || 'top';
                                    gradient[ inputtheme ].start  = subparts.shift() || 'transparent';
                                    gradient[ inputtheme ].end    = subparts.shift() || 'transparent';
                                    has_gradient[ inputtheme ] = true;
                                } else {
                                    cssrules[ inputtheme ][ 'background-image' ] = value;
                                }
                            }
                        } else if ( 'seq' !== inputrule ) {
                            cssrules[ inputtheme ][ inputrule ] = value;
                        }
                    }
                }
            } );
            // update swatch
            if ( 'undefined' !== typeof swatch && !self.is_empty( swatch.attr( 'id' ) ) ) {
                swatch.removeAttr( 'style' );
                if ( has_gradient.parent ) {
                    swatch.ctcgrad( gradient.parent.origin, [ gradient.parent.start, gradient.parent.end ] );
                }
                //**console.log( 'combined css rules' );
                //**console.log( cssrules );
                swatch.css( cssrules.parent );  
                if ( !( swatch.attr( 'id' ).toString().match( /parent/ ) ) ) {
                    if ( has_gradient.child ) {
                        swatch.ctcgrad( gradient.child.origin, [ gradient.child.start, gradient.child.end ] );
                    }
                    //console.log( cssrules.child );
                    swatch.css( cssrules.child );
                }
                swatch.css( {'z-index':-1} );
            }
            return postdata;
        },
        
        decode_value: function( rule, value ) {
            //**console.log( 'in decode_value ( ' + rule + ' ...' );
            value = ( 'undefined' === typeof value ? '' : value );
            var self = this,
                obj = { 
                    'orig':     value, 
                    'names':    [ '' ],
                    'values':   [ value ]
                },
                params;
            if ( rule.toString().match( /^border(\-(top|right|bottom|left))?$/ ) ) {
                var regex = new RegExp( self.border_regx + '(' + self.color_regx + ')?', 'i' ),
                    orig;
                params = value.toString().match( regex );
                if ( self.is_empty( params ) ) {
                    params = [];
                }
                obj.names = [
                    '_border_width',
                    '_border_style',
                    '_border_color',
                ];
                orig = params.shift();
                //**console.log( value );
                //**console.log( regex );
                //**console.log( params );
                obj.values[ 0 ] = params.shift() || '';
                params.shift();
                obj.values[ 1 ] = params.shift() || '';
                params.shift();
                obj.values[ 2 ] = params.shift() || '';
            } else if ( rule.toString().match( /^background\-image/ ) ) {
                obj.names = [
                    '_background_url',
                    '_background_origin', 
                    '_background_color1', 
                    '_background_color2'
                ];
                obj.values = [ '', '', '', '' ];
                if ( !self.is_empty( value ) && !( value.toString().match( /(url|none)/ ) ) ) {
                    var    stop1, stop2;
                    params = value.toString().split( /:/ );
                //**console.log( value );
                //**console.log( params );
                    obj.values[ 1 ] = params.shift() || '';
                    obj.values[ 2 ] = params.shift() || '';
                    stop1 = params.shift() || '';
                    obj.values[ 3 ] = params.shift() || '';
                    stop2 = params.shift() || '';
                    obj.orig = [ 
                        obj.values[ 1 ],
                        obj.values[ 2 ],
                        obj.values[ 3 ] 
                    ].join( ' ' );
                } else {
                    obj.values[ 0 ] = value;
                }
            }
            //**console.log( obj );
            return obj;
        },
        
        image_url: function( theme, value ) {
            var self = this,
                parts = value.toString().match( /url\(['" ]*(.+?)['" ]*\)/ ),
                path = self.is_empty( parts ) ? null : parts[ 1 ],
                url = window.ctcAjax.theme_uri + '/' + ( 'parent' === theme ? window.ctcAjax.parnt : window.ctcAjax.child ) + '/',
                image_url;
            if ( !path ) { 
                return false; 
            } else if ( path.toString().match( /^(data:|https?:|\/)/ ) ) { 
                image_url = value; 
            } else { 
                image_url = 'url(' + url + path + ')'; 
            }
            return image_url;
        },
    
        setup_menus: function() {
            var self = this;
            //console.log( 'setup_menus' );
            self.setup_query_menu();
            self.setup_selector_menu();
            self.setup_rule_menu();
            self.setup_new_rule_menu();
            self.load_queries();
            self.load_rules();
            // selectors will be loaded after query selected
            self.set_query( self.currquery );
        },
        
        load_queries: function() {
            var self = this;
            //console.log( 'load_queries' );
            // retrieve unique media queries
            self.query_css( 'queries', null );
        },
        
        load_selectors: function() {
            var self = this;
            //console.log( 'load_selectors' );
            // retrieve unique selectors from query value
            self.query_css( 'selectors', self.currquery );
        },
        
        load_rules: function() {
            var self = this;
            //console.log( 'load_rules' );
            // retrieve all unique rules
            self.query_css( 'rules', null );
        },
        
        load_selector_values: function() {
            var self = this;
            //console.log( 'load_selector_values: ' + self.currqsid );
            // retrieve individual values from qsid
            self.query_css( 'qsid', self.currqsid );
        },
        
        get_queries: function( request, response ) {
            //console.log( 'get_queries' );
            //console.log( this );
            var //self = this,
                arr = [], 
                matcher = new RegExp( $.ui.autocomplete.escapeRegex( request.term ), "i" );
            if ( $.chldthmcfg.is_empty( this.element.data( 'menu' ) ) ) {
                arr.push( { 'label': window.ctcAjax.nosels_txt, 'value': null } );
            } else {
                // note: key = ndx, value = query name
                $.each( this.element.data( 'menu' ), function( key, val ) {
                    if ( matcher.test( val ) ) {
                        arr.push( { 'label': val, 'value': val } );
                    }
                } );
            }
            response( arr );
        },
        
        get_selectors: function( request, response ) {
            //console.log( 'get_selectors' );
            var //self = this,
                arr = [], 
                matcher = new RegExp( $.ui.autocomplete.escapeRegex( request.term ), "i" );
            if ( $.chldthmcfg.is_empty( this.element.data( 'menu' ) ) ) {
                arr.push( { 'label': window.ctcAjax.nosels_txt, 'value': null } );
            } else {
                // note: key = selector name, value = qsid
                $.each( this.element.data( 'menu' ), function( key, val ) {
                    if ( matcher.test( key ) ) {
                        arr.push( { 'label': key, 'value': val } );
                    }
                } );
            }
            response( arr );
        },
        
        get_rules: function( request, response ) {
            //console.log( 'get_rules' );
            var //self = this,
                arr = [], 
                matcher = new RegExp( $.ui.autocomplete.escapeRegex( request.term ), "i" );
            if ( $.chldthmcfg.is_empty( this.element.data( 'menu' ) ) ) {
                arr.push( { 'label': window.ctcAjax.nosels_txt, 'value': null } );
            } else {
                // note: key = ruleid, value = rule name
                $.each( this.element.data( 'menu' ), function( key, val ) {
                    if ( matcher.test( key ) ) {
                        arr.push( { 'label': key, 'value': val } );
                    }
                } );
            }
            response( arr );
        },
                
        get_filtered_rules: function( request, response ) {
            //console.log( 'get_filtered_rules' );
            var arr = [],
                matcher = new RegExp( $.ui.autocomplete.escapeRegex( request.term ), "i" ); //,
            $.each( $( '#ctc_rule_menu' ).data( 'menu' ), function( key, val ) {
                //multiple versions of rule ok
                if ( matcher.test( key ) ) {
                    arr.push( { 'label': key, 'value': val } );
                }
            } );
            response( arr );
        },
        
        /**
         * parent and new values are stored in separate arrays
         * this function puts them into parent/child columns by rulevalid
         */
        merge_ruleval_arrays: function( rule, value, isnew ) {
            //**console.log( 'merge_ruleval_arrays' );
            var self = this,
                valarr = {},
                nextval = isnew ? value.child.pop() : null; // if new rule, pop off the top before counting
            //**console.log( value );
            $.each( [ 'parnt', 'child' ], function( ndx, themetype ) {
                // iterate through parent and child val arrays and populate new assoc array with parent/child for each rulevalid
                if ( !self.is_empty( value[ themetype ] ) ) {
                    $.each( value[ themetype ], function( ndx2, val ) {
                        if ( isnew ) {
                            // if new rule, increment new rulevalid but do not add to parent/child assoc array
                            if ( parseInt( val[ 2 ] ) >= parseInt( nextval[ 2 ] ) ) {
                                nextval[ 2 ] = parseInt( val[ 2 ] ) + 1;
                            }
                        } else {
                            // add to parent/child assoc array with rulevalid as key
                            if ( self.is_empty( valarr[ val[ 2 ] ] ) ) {
                                valarr[ val[ 2 ] ] = {};
                            }
                            valarr[ val[ 2 ] ][ themetype ] = val;
                        }
                    } );
                }
            } );
            // if new rule, create new parent child assoc array element with new rulevalid as key
            if ( isnew ) {
                valarr[ nextval[ 2 ] ] = {
                    parnt: [],
                    child: nextval
                };
            }
            return valarr;
        },

        /**
         * input_row
         * render individual row of inputs for a given selector/rule combination
         * qsid     query/selector id
         * rule     css property 
         * seq      panel id from rule/value tab
         * data     contains all rules/values for selector
         * isnew    is passed true when new rule is selected from menu
         */
        input_row: function( qsid, rule, seq, data, isnew ) {
            //console.log( 'in input_row' );
            var self = this,
                html = '';
            if ( !self.is_empty( data ) && !self.is_empty( data.value ) && !self.is_empty( data.value[ rule ] ) ) {
                var value = data.value[ rule ],
                    valarr = self.merge_ruleval_arrays( rule, value, isnew );
                $.each( valarr, function( ndx, val ) {
                    var pval = self.decode_value( rule, self.is_empty( val.parnt ) ? '' : val.parnt[ 0 ] ),
                        pimp = self.is_empty( val.parnt ) || self.is_empty( val.parnt[ 1 ], 1 ) ? 0 : 1,
                        cval = self.decode_value( rule, self.is_empty( val.child ) ? '' : val.child[ 0 ] ),
                        cimp = self.is_empty( val.child ) || self.is_empty( val.child[ 1 ], 1 ) ? 0 : 1;
                    html += '<div class="ctc-' + ( 'ovrd' === seq ? 'input' : 'selector' ) + '-row clearfix"><div class="ctc-input-cell">';
                    if ( 'ovrd' === seq ) {
                        html += rule.replace( /\d+/g, self.frascii );
                    } else {
                        html += data.selector + '<br/><a href="#" class="ctc-selector-edit"' +
                            ' id="ctc_selector_edit_' + qsid + '" >' + self.getxt( 'edit' ) + '</a> ' +
                            ( self.is_empty( pval.orig ) ? self.getxt( 'child_only' ) : '' );
                    }
                    html += '</div><div class="ctc-parent-value ctc-input-cell"' + ( 'ovrd' !== seq ? ' style="display:none"' : '' ) +
                        ' id="ctc_' + seq + '_parent_' + rule + '_' + qsid + '_' + ndx + '">' +
                        ( self.is_empty( pval.orig ) ? '[no value]' : pval.orig + ( pimp ? self.getxt( 'important' ) : '' ) ) +
                        '</div><div class="ctc-input-cell">';
                    if ( !self.is_empty( pval.names ) ) {
                        $.each( pval.names, function( namendx, newname ) {
                            newname = ( self.is_empty( newname ) ? '' : newname );
                            html += '<div class="ctc-child-input-cell ctc-clear">';
                            var id = 'ctc_' + seq + '_child_' + rule + '_' + qsid + '_' + ndx + newname,
                                newval;
                            if ( false === ( newval = cval.values.shift() ) ) {
                                newval = '';
                            }
                                
                            html += ( self.is_empty( newname ) ? '' : self.getxt( newname ) + ':<br/>' ) +
                                '<input type="text" id="' + id + '" name="' + id + '" class="ctc-child-value' +
                                ( ( newname + rule ).toString().match( /color/ ) ? ' color-picker' : '' ) +
                                ( ( newname ).toString().match( /url/ ) ? ' ctc-input-wide' : '' ) +
                                '" value="' + self.escquo( newval ) + '" /></div>';
                        } );
                        var impid = 'ctc_' + seq + '_child_' + rule + '_i_' + qsid + '_' + ndx;
                        html += '<label for="' + impid + '"><input type="checkbox"' +
                            ' id="' + impid + '" name="' + impid + '" value="1" ' +
                            ( cimp ? 'checked' : '' ) + ' />' +
                            self.getxt( 'important' ) + '</label>';
                    }
                    html += '</div>';
                    if ( 'ovrd' !== seq ) {
                        html += '<div class="ctc-swatch ctc-specific"' +
                            ' id="ctc_child_' + rule + '_' + qsid + '_' + ndx + '_swatch">' +
                            self.getxt( 'swatch' ) + '</div>' +
                            '<div class="ctc-child-input-cell ctc-button-cell"' +
                            ' id="ctc_save_' + rule + '_' + qsid + '_' + ndx + '_cell">' +
                            '<input type="button" class="button ctc-save-input"' +
                            ' id="ctc_save_' + rule + '_' + qsid + '_' + ndx + '"' +
                            ' name="ctc_save_' + rule + '_' + qsid + '_' + ndx + '"' +
                            ' value="Save" /></div>';
                    }
                    html += '</div><!-- end input row -->' + "\n";
                } );
            }
            return html;
        },
        
        scrolltop: function() {
            $('html, body, .ctc-option-panel-container').animate( { scrollTop: 0 } );        
        },
        
        css_preview: function( theme ) {
            var self = this;
            //console.log( 'css_preview: ' + theme );
            if ( !( theme = theme.match( /(child|parnt)/ )[ 1 ] ) ) {
                theme = 'child';
            }
            //console.log( 'css_preview: ' + theme );
            // retrieve raw stylesheet ( parent or child )
            self.query_css( 'preview', theme );
        },
        
        /**
         * The "setup" functions initialize jQuery UI widgets
         */
        setup_iris: function( obj ) {
            // deprecated: using spectrum for alpha support
            var self = this;
            self.setup_spectrum( obj );
        },
        
        setup_spectrum: function( obj ) {
            var self        = this,
                //colortxt    = $( obj ).attr( 'id' ) + '_colortxt',
                palette     = !self.is_empty( window.ctcAjax.palette );
            try {
                $( obj ).spectrum( {
                    showInput:              true,
                    allowEmpty:             true,
                    showAlpha:              true,
                    showInitial:            true,
                    preferredFormat:        "hex", // 'name', //
                    clickoutFiresChange:    true,
                    move:                   function( color ) {
                        $( obj ).data( 'color', color );
                        self.coalesce_inputs( obj );
                    },
                    showPalette: palette ? true : false, 
                    showSelectionPalette: palette ? true : false,
                    palette: [ ],
                    maxSelectionSize: 36,
                    localStorageKey: "ctc-palette." + window.ctcAjax.child,
                    hideAfterPaletteSelect: true,
                } ).on( 'change', function( ){
                    //var color = $( this ).spectrum( 'get' );
                    //console.log( 'color change: ' + color );
                    self.coalesce_inputs( this );
                } ).on( 'keyup', function( ) {
                    // update spectrum ui to match text input after half-second delay
                    var $this = this,
                        $val = self.addhash( $( this ).val() );
                        $( $this ).val( $val );
                    clearTimeout( $( this ).data( 'spectrumTimer' ) );
                    $( this ).data( 'spectrumTimer', setTimeout( 
                        function() { 
                            self.coalesce_inputs( $this );                            
                            $( $this ).spectrum( 'set', $val );
                        }, 
                        500  
                    ) );
                } );
                
            } catch ( exn ) {
                self.jquery_exception( exn, 'Spectrum Color Picker' );
            }
        },
        addhash: function( color ) {
            return color.replace( /^#?([a-f0-9]{3,6}.*)/, "#$1" );
        },
        color_text: function( color ) {
            var self = this;
            if ( self.is_empty( color ) ) {
                return '';
            } else if ( color.getAlpha() < 1 ) {
                return color.toRgbString();
            } else {
                return color.toHexString();
            }
        },
        
        setup_query_menu: function() {
            var self = this;
            //console.log( 'setup_query_menu' );
            try {
                $( '#ctc_sel_ovrd_query' ).autocomplete( {
                    source: self.get_queries,
                    minLength: 0,
                    selectFirst: true,
                    autoFocus: true,
                    select: function( e, ui ) {
                        self.set_query( ui.item.value );
                        return false;
                    },
                    focus: function( e ) { 
                        e.preventDefault(); 
                    }
                } ).data( 'menu' , {} );
            } catch ( exn ) {
                self.jquery_exception( exn, 'Query Menu' );
            }
        },
        
        setup_selector_menu: function() {
            var self = this;
            //console.log( 'setup_selector_menu' );
            try {
                $( '#ctc_sel_ovrd_selector' ).autocomplete( {
                    source: self.get_selectors,
                    selectFirst: true,
                    autoFocus: true,
                    select: function( e, ui ) {
                        self.set_selector( ui.item.value, ui.item.label );
                        return false;
                    },
                    focus: function( e ) { 
                        e.preventDefault(); 
                    }
                } ).data( 'menu' , {} );
            } catch ( exn ) {
                self.jquery_exception( exn, 'Selector Menu' );
            }
        },
        
        setup_rule_menu: function() {
            var self = this;
            //console.log( 'setup_rule_menu' );
            try {
            $( '#ctc_rule_menu' ).autocomplete( {
                source: self.get_rules,
                //minLength: 0,
                selectFirst: true,
                autoFocus: true,
                select: function( e, ui ) {
                    self.set_rule( ui.item.value, ui.item.label );
                    return false;
                },
                focus: function( e ) { 
                    e.preventDefault(); 
                }
            } ).data( 'menu' , {} );
            } catch ( exn ) {
                self.jquery_exception( exn, 'Property Menu' );
            }
        },
        
        setup_new_rule_menu: function() {
            var self = this;
            try {
            $( '#ctc_new_rule_menu' ).autocomplete( {
                source: self.get_filtered_rules,
                //minLength: 0,
                selectFirst: true,
                autoFocus: true,
                select: function( e, ui ) {
                    //console.log( 'new rule selected' );
                    e.preventDefault();
                    var newrule = ui.item.label.replace( /[^\w\-]/g, self.toascii ),
                        row,
                        first;
                    //console.log( 'current qsdata before:' );
                    //console.log( self.currdata );
                    if ( self.is_empty( self.currdata.value ) ) {
                        self.currdata.value = {};
                    }
                    if ( self.is_empty( self.currdata.value[ ui.item.label ] ) ) {
                        self.currdata.value[ ui.item.label ] = {};
                    }
                    if ( self.is_empty( self.currdata.value[ ui.item.label ].child ) ) {
                        self.currdata.value[ ui.item.label ].child = [];
                    }
                    //console.log( 'current qsdata after:' );
                    //console.log( self.currdata );
                    // seed current qsdata with new blank value with id 1
                    // this will be modified during input_row function to be next id in order
                    self.currdata.value[ ui.item.label ].child.push( [ '', 0, 1, 1 ] );
                    row = $( self.input_row( self.currqsid, newrule, 'ovrd', self.currdata, true ) );
                    $( '#ctc_sel_ovrd_rule_inputs' ).append( row );
                    $( '#ctc_new_rule_menu' ).val( '' );
                    
                    row.find( 'input[type="text"]' ).each( function( ndx, el ) {
                        if (! first) {
                            first = el;
                        }
                        if ( $( el ).hasClass( 'color-picker' ) ){
                            self.setup_spectrum( el );
                        }
                    } );
                    if ( first ){
                        $( first ).focus();
                    }
//                    if ( self.jqueryerr.length ) {
//                        self.jquery_notice( 'setup_new_rule_menu' );
//                    }
                    return false;
                },
                focus: function( e ) { 
                    e.preventDefault(); 
                }
            } ).data( 'menu' , {} );
            } catch ( exn ) {
                self.jquery_exception( exn, 'New Property Menu' );
            }
        },
        set_theme_params: function( themetype, themedir ) {
            $( '#ctc_child_author' ).val( window.ctcAjax.themes[ themetype ][ themedir ].Author );
            $( '#ctc_child_version' ).val( window.ctcAjax.themes[ themetype ][ themedir ].Version );
            $( '#ctc_child_authoruri' ).val( window.ctcAjax.themes[ themetype ][ themedir ].AuthorURI );
            $( '#ctc_child_themeuri' ).val( window.ctcAjax.themes[ themetype ][ themedir ].ThemeURI );
            $( '#ctc_child_descr' ).val( window.ctcAjax.themes[ themetype ][ themedir ].Descr );
            $( '#ctc_child_tags' ).val( window.ctcAjax.themes[ themetype ][ themedir ].Tags );
        },
        update_form: function() {
            var self        = this,
                themedir;
            $( '#input_row_stylesheet_handling_container,#input_row_parent_handling_container,#ctc_additional_css_files_container,#input_row_new_theme_slug,#input_row_duplicate_theme_slug,#ctc_copy_theme_mods,#ctc_child_header_parameters,#ctc_configure_submit,#input_row_theme_slug' ).slideUp( 'fast' );
            $( '#ctc_configure_submit .ctc-step' ).text( '9' );
            if ( $( '#ctc_theme_child' ).length && !$( '#ctc_child_type_new' ).is( ':checked' ) ) {
                themedir    = $( '#ctc_theme_child' ).val();
                //console.log( 'update_form (existing) ... ' + themedir );
                self.existing = 1;
                self.currparnt = window.ctcAjax.themes.child[ themedir ].Template;
                self.autogen_slugs();
                $( '#ctc_theme_parnt' ).val( self.currparnt );
                $( '#ctc_theme_parnt-button .ui-selectmenu-text' ).text( self.getname( 'parnt' ) );
                self.set_theme_params( 'child', themedir );
                //self.set_child_menu( document.getElementById( 'ctc_theme_child' ) );
                if ( $( '#ctc_child_type_duplicate' ).is( ':checked' ) ) {
                    $( '#ctc_child_template' ).val( self.testslug );
                    $( '#ctc_child_name' ).val( self.testname );
                    $( '.ctc-analyze-theme, .ctc-analyze-howto' ).show();
                    $( '#ctc_load_styles' ).val( 'Duplicate Child Theme' );
                } else if ( $( '#ctc_child_type_reset' ).is( ':checked' ) ) {
                    $( '#ctc_configure_submit .ctc-step' ).text( '3' );
                    $( '#ctc_configure_submit' ).slideDown( 'fast' );
                    $( '#theme_slug_container' ).text( themedir );
                    $( '.ctc-analyze-theme, .ctc-analyze-howto' ).hide();
                    //$( '#input_row_theme_slug' ).slideDown( 'fast' );
                    $( '#ctc_enqueue_none' ).prop( 'checked', true );
                    $( '#ctc_load_styles' ).val( 'Reset Child Theme to Previous State' );
                } else {
                    $( '#ctc_child_template' ).val( '' );
                    $( '#theme_slug_container' ).text( themedir );
                    $( '.ctc-analyze-theme, .ctc-analyze-howto' ).show();
                    $( '#ctc_child_name' ).val( self.getname( 'child' ) );
                    $( '#ctc_load_styles' ).val( 'Configure Child Theme' );
                }
                $( '#input_row_existing_theme_option' ).slideDown( 'fast' );
                $( '#input_row_new_theme_option' ).slideUp( 'fast' );
            } else {
                self.existing = 0;
                self.autogen_slugs();
                //themedir = $( '#ctc_theme_parnt' ).val();
                $( '#ctc_theme_parnt' ).val( self.currparnt );
                $( '#ctc_theme_parnt-button .ui-selectmenu-text' ).text( $.chldthmcfg.getname( 'parnt' ) );
                //console.log( 'update_form (new) ... ' + self.currparnt );
                //self.set_parent_menu( document.getElementById( 'ctc_theme_parnt' ) );
                //console.log( 'setting to new...' + $( '#ctc_theme_parnt' ).val() );
                self.set_theme_params( 'parnt', self.currparnt );
                $( '#input_row_existing_theme_option,#input_row_duplicate_theme_container,#input_row_theme_slug' ).slideUp( 'fast' );
                $( '#input_row_new_theme_option' ).slideDown( 'fast' ); 
                $( '#ctc_child_name' ).val( self.testname );
                $( '#ctc_child_template' ).val( self.testslug );
                $( '.ctc-analyze-theme, .ctc-analyze-howto' ).show();
                $( '#ctc_load_styles' ).val( 'Create New Child Theme' );
            }
        },
        set_notice: function( noticearr ) {
            var self = this,
                errorHtml = '',
                out;
            if ( !self.is_empty( noticearr ) ) {
                $.each( noticearr, function( type, list ) {
                    errorHtml += '<div class="' + type + ' notice is-dismissible dashicons-before"><ul>' + "\n";
                    $( list ).each( function( ndx, el ) {
                        errorHtml += '<li>' + el.toString() + '</li>' + "\n";
                    } );
                    errorHtml += '</ul></div>';        
                } );
            }
            out = $( errorHtml );
            $( '#ctc_error_notice' ).html( out );
            self.bind_dismiss( out );
            $( 'html, body' ).animate( { scrollTop: 0 }, 'slow' );        
        },
        
        set_parent_menu: function( obj ) {
            // refresh page with current parent theme
            var self = this;
            self.currparnt = obj.value;
            self.update_form();
            //self.show_loading();
            //document.location = '?page=' + window.ctcAjax.page + '&ctc_parent=' + obj.value;
        },
        
        set_child_menu: function( obj ) {
            var self = this;
            self.currchild = obj.value;
            self.update_form();
        },
        
        set_query: function( value ) {
            var self = this;
            if ( self.is_empty( value ) ) {
                return false;
            }
            //console.log( 'set_query: ' + value );
            self.currquery = value;
            $( '#ctc_sel_ovrd_query' ).val( '' );
            $( '#ctc_sel_ovrd_query_selected' ).text( value );
            $( '#ctc_sel_ovrd_selector' ).val( '' );
            $( '#ctc_sel_ovrd_selector_selected' ).html( '&nbsp;' );
            self.load_selectors();
            self.scrolltop();
        },
        
        set_selector: function( value, label ) {
            var self = this;
            label = null;
            if ( self.is_empty( value ) ) {
                return false;
            }
            //console.log( 'set_selector: ' + value + ' label: ' + label );
            $( '#ctc_sel_ovrd_selector' ).val( '' );
            self.currqsid = value;
            self.reload = false;
            self.load_selector_values();
            self.scrolltop();
        },
        
        set_rule: function( value, label ) {
            //console.log( 'set_rule: ' + value + ' label: ' + label );
            var self = this;
            if ( self.is_empty( value ) ) {
                return false;
            }
            $( '#ctc_rule_menu' ).val( '' );
            $( '#ctc_rule_menu_selected' ).text( label );
            $( '.ctc-rewrite-toggle' ).text( self.getxt( 'rename' ) );
            $( '#ctc_rule_value_inputs, #ctc_input_row_rule_header' ).show();
            // retrieve unique values by rule
            self.query_css( 'rule_val', value );
            self.scrolltop();
        },
        
        set_qsid: function( obj ) {
            var self = this;
            //console.log( 'set_qsid: ' + $( obj ).attr( 'id' ) );
            self.currqsid = $( obj ).attr( 'id' ).match( /_(\d+)$/ )[ 1 ];
            self.focus_panel( '#query_selector_options' );
            self.reload = true;
            self.load_selector_values();  
        },
        /**
         * Retrieve data from server and execute callback on completion
         */
        query_css: function( obj, key, params ) {
            //console.log( 'query_css: ' + obj + ' key: ' + key );
            var self = this,
                postdata = { 'ctc_query_obj' : obj, 'ctc_query_key': key },
                status_sel = '#ctc_status_' + obj + ( 'val_qry' === obj ? '_' + key : '' );
            
            if ( 'object' === typeof params ) {
                $.each( params, function( key, val ) {
                    postdata[ 'ctc_query_' + key ] = val;
                } );
            }
            $( '.query-icon,.ctc-status-icon' ).remove();
            //console.log( status_sel + ' ' + $( status_sel ).length );
            $( status_sel + ' .ctc-status-icon' ).remove();
            $( status_sel ).append( '<span class="ctc-status-icon spinner is-active query-icon"></span>' );
            // add wp ajax action to array
            //console.log( $( '#ctc_action' ).val() );
            postdata.action = ( !self.is_empty( $( '#ctc_action' ).val() ) &&
                'plugin' === $( '#ctc_action' ).val() ) ? 
                    'ctc_plgqry' : 'ctc_query';
            postdata._wpnonce = $( '#_wpnonce' ).val();
            // ajax post input data
            //console.log( 'query_css postdata:' );
            //console.log( postdata );
            self.ajax_post( obj, postdata );
        },
        /**
         * Post data to server for saving and execute callback on completion
         */
        save: function( obj ) {
            //console.log( 'save: ' + $( obj ).attr( 'id' ) );
            var self = this,
                postdata = {},
                $selector, 
                $query, 
                $imports,
                id = $( obj ).attr( 'id' ), 
                newsel, 
                origsel;
    
            // disable the button until ajax returns
            $( obj ).prop( 'disabled', true );
            // clear previous success/fail icons
            $( '.ctc-query-icon,.ctc-status-icon' ).remove();
            // show spinner
            $( obj ).parent( '.ctc-textarea-button-cell, .ctc-button-cell' )
                .append( '<span class="ctc-status-icon spinner save-icon"></span>' );
            if ( id.match( /ctc_configtype/ ) ) {
                $( obj ).parents( '.ctc-input-row' ).first()
                    .append( '<span class="ctc-status-icon spinner save-icon"></span>' );
                postdata.ctc_configtype = $( obj ).val();
            } else if ( ( $selector = $( '#ctc_new_selectors' ) ) && 
                'ctc_save_new_selectors' === $( obj ).attr( 'id' ) ) {
                postdata.ctc_new_selectors = $selector.val();
                if ( ( $query = $( '#ctc_sel_ovrd_query_selected' ) ) ) {
                    postdata.ctc_sel_ovrd_query = $query.text();
                }
                self.reload = true;
            } else if ( ( $imports = $( '#ctc_child_imports' ) ) &&
                'ctc_save_imports' === id ) {
                postdata.ctc_child_imports = $imports.val();
            } else if ( 'ctc_is_debug' === id ) {
                postdata.ctc_is_debug = $( '#ctc_is_debug' ).is( ':checked' ) ? 1 : 0;
            } else {
                // coalesce inputs
                postdata = self.coalesce_inputs( obj );
            }
            $( '.save-icon' ).addClass( 'is-active' );
            // add rename selector value if it exists
            $( '#ctc_sel_ovrd_selector_selected' )
                .find( '#ctc_rewrite_selector' ).each( function() {
                newsel = $( '#ctc_rewrite_selector' ).val();
                origsel = $( '#ctc_rewrite_selector_orig' ).val();
                if ( self.is_empty( newsel ) || !newsel.toString().match( /\w/ ) ) {
                    newsel = origsel;
                } else {
                    postdata.ctc_rewrite_selector = newsel;
                    self.reload = true;
                }
                $( '.ctc-rewrite-toggle' ).text( self.getxt( 'rename' ) );
                $( '#ctc_sel_ovrd_selector_selected' ).html( newsel );
            } );
            // add wp ajax action to array
            //console.log( $( '#ctc_action' ).val() );
            postdata.action = ( !self.is_empty( $( '#ctc_action' ).val() ) &&
                'plugin' === $( '#ctc_action' ).val() ) ? 
                    'ctc_plugin' : 'ctc_update';
            postdata._wpnonce = $( '#_wpnonce' ).val();
            //console.log( postdata );
            // ajax post input data
            self.ajax_post( 'qsid', postdata );
        },
        
        ajax_post: function( obj, data, datatype ) {
            var self = this;
            //console.log( 'ajax_post: ' + obj );
            //console.log( data );
            //console.log( window.ctcAjax.ajaxurl );
            //console.log( window.ctcAjax.ajaxurl );
            // get ajax url from localized object
            $.ajax( { 
                url:        window.ctcAjax.ajaxurl,  
                data:       data,
                dataType:   
                //'ctc_update' === data.action && 'qsid' === obj ? 'text' : 
                //'ctc_update' == data.action && // 
                //'rule_val' === obj ? 'text' : // 'qsid' == obj ? 'text' : 
                ( self.is_empty( datatype ) ? 'json' : datatype ), 
                type:       'POST'
            } ).done( function( response ) {
                //console.log( response );
                self.handle_success( obj, response );
            } ).fail( function() { // jxr, status, err ) {
                //console.log( status );
                //console.log( err );
                self.handle_failure( obj );
            } ).always( function() {
                if ( self.jqueryerr.length ) {
                    self.jquery_notice();
                }
            } );  
        },
        
        handle_failure: function( obj ) {
            var self = this;
            //console.log( 'handle_failure: ' + obj );
            $( '.query-icon, .save-icon' ).removeClass( 'spinner' ).addClass( 'failure' );
            $( 'input[type=submit], input[type=button], input[type=checkbox],.ctc-delete-input' ).prop( 'disabled', false );
            $( '.ajax-pending' ).removeClass( 'ajax-pending' );
            //FIXME: return fail text in ajax response
            if ( 'preview' === obj ) {
                $( '#view_parnt_options_panel,#view_child_options_panel' )
                    .text( self.getxt( 'css_fail' ) );
            }
        },
        
        handle_success: function( obj, response ) {
            var self = this;
            // query response
            //console.log( 'handle_success: ' + obj );
            //console.log( response );
            // hide spinner
            $( '.query-icon, .save-icon' ).removeClass( 'spinner' );
            $( '.ajax-pending' ).removeClass( 'ajax-pending' );
            // hide spinner
            if ( self.is_empty( response ) ) {
                self.handle_failure( obj );
            } else {
                $( '#ctc_new_selectors' ).val( '' );
                // update data objects   
                // show check mark
                // FIXME: distinction between save and query, update specific status icon
                $( '.query-icon, .save-icon' ).addClass( 'success' );
                $( 'input[type=submit], input[type=button], input[type=checkbox],.ctc-delete-input' ).prop( 'disabled', false );
                // update ui from each response object  
                $( response ).each( function() {
                    if ( 'function' === typeof self.update[ this.obj ] ) {
                        //console.log( 'executing method update.' + this.obj );
                        self.update[ this.obj ].call( self, this );
                    } else {
                        //console.log( 'Fail: no method update.' + this.obj );
                    }
                } );
            }
        },
        
        jquery_exception: function( exn, type ) {
            var self = this,
                ln = self.is_empty( exn.lineNumber ) ? '' : ' line: ' + exn.lineNumber,
                fn = self.is_empty( exn.fileName ) ? '' : ' ' + exn.fileName.split( /\?/ )[ 0 ];
            self.jqueryerr.push( '<code><small>' + type + ': ' + exn.message + fn + ln + '</small></code>' );
            //console.log( 'jquery error detected' );
        },
        
        jquery_notice: function( fn ) {
            //console.log( fn );
            fn = null;
            var self        = this,
                culprits    = [],
                errors      = [];
            if ( self.jqueryerr.length ){
                // disable form submits
                $( 'input[type=submit], input[type=button]' ).prop( 'disabled', true );
                $( 'script' ).each( function(){
                    var url = $( this ).prop( 'src' );
                    if ( !self.is_empty( url ) && url.match( /jquery(\.min|\.js|\-?ui)/i ) &&
                        ! url.match( /load\-scripts.php/ ) ) {
                        culprits.push( '<code><small>' + url.split( /\?/ )[ 0 ] + '</small></code>' );
                    }
                } );
                errors.push( '<strong>' + self.getxt( 'js' ) + '</strong> ' + self.getxt( 'contact' ) );
                //if ( 1 == window.ctcAjax.is_debug ) {
                    errors.push( self.jqueryerr.join( '<br/>' ) );
                //}
                if ( culprits.length ) {
                    errors.push( self.getxt( 'jquery' ) + '<br/>' + culprits.join( '<br/>' ) );
                }
                errors.push( self.getxt( 'plugin' ) );
            }
            //return errors;
            self.set_notice( { 'error': errors } );
        },
        /*
            // test for jquery issues

            $.each( jqueryerr, function( index, err ) {
                notice.hasnotice = 1;
                notice.style = 'error';
                notice.jquery += err;
            } );
        */
        
        
        update: {
            // render individual selector inputs on Query/Selector tab
            qsid: function( res ) {
                //console.log( res );
                var self = this,
                    id, html, val, empty;
                self.currqsid = res.key;
                self.currdata = res.data;
                //console.log( 'update.qsid: ' + self.currqsid );
                $( '#ctc_sel_ovrd_qsid' ).val( self.currqsid );
                if ( self.is_empty( self.currdata.seq ) ) {
                    $( '#ctc_child_load_order_container' ).empty();
                } else {
                    id = 'ctc_ovrd_child_seq_' + self.currqsid;
                    val = parseInt( self.currdata.seq );
                    html = '<input type="text" id="' + id + '" name="' + id + '"' +
                        ' class="ctc-child-value" value="' + val + '" />';
                    $( '#ctc_child_load_order_container' ).html( html );
                }
                if ( self.is_empty( self.currdata.value ) ) {
                    //console.log( 'qsdata is empty' );
                    empty = true;
                    $( '#ctc_sel_ovrd_rule_inputs' ).empty(); 
                } else {
                    //console.log( 'qsdata NOT empty' );
                    empty = false;
                    html = '';
                    $.each( self.currdata.value, function( rule, value ) {
                        value = null;
                        html += self.input_row( self.currqsid, rule, 'ovrd', self.currdata );
                    } );
                    $( '#ctc_sel_ovrd_rule_inputs' ).html( html ).find( '.color-picker' ).each( function() {
                        self.setup_spectrum( this );
                    } );
                    self.coalesce_inputs( '#ctc_child_all_0_swatch' );
                }
//                if ( self.jqueryerr.length ) {
//                    self.jquery_notice( 'update.qsid' );
//                } else {
                    //console.log( 'reload menus: ' + ( self.reload ? 'true' : 'false' ) );
                    if ( self.reload ) {
                        self.load_queries();
                        self.set_query( self.currdata.query );
                        self.load_rules();
                    }
                    $( '#ctc_sel_ovrd_selector_selected' ).text( self.currdata.selector );
                    $( '.ctc-rewrite-toggle' ).text( self.getxt( 'rename' ) );
                    $( '.ctc-rewrite-toggle' ).show();
                    if ( !empty ){
                        $( '#ctc_sel_ovrd_rule_header,' +
                        '#ctc_sel_ovrd_new_rule,' +
                        '#ctc_sel_ovrd_rule_inputs_container,' +
                        '#ctc_sel_ovrd_rule_inputs' ).show();
                    } else {
                        $( '#ctc_sel_ovrd_rule_header,' +
                        '#ctc_sel_ovrd_new_rule,' +
                        '#ctc_sel_ovrd_rule_inputs_container,' +
                        '#ctc_sel_ovrd_rule_inputs' ).hide();
                    }
                    //self.scrolltop();
//                }
            }, 
            // render list of unique values for given rule on Property/Value tab
            rule_val: function( res ) {
                //console.log( 'update.rule_val: ' + res.key );
                //console.log( res.data );
                var self = this,
                    rule = $( '#ctc_rule_menu_selected' ).text(), 
                    html = '<div class="ctc-input-row clearfix" id="ctc_rule_row_' + rule + '">' + "\n";
                //console.log( 'rule: ' + rule );
                if ( !self.is_empty( res.data ) ) {
                    $.each( res.data, function( valid, value ) {
                        var parentObj = self.decode_value( rule, value );
                        html += '<div class="ctc-parent-row clearfix"' +
                            ' id="ctc_rule_row_' + rule + '_' + valid + '">' + "\n" +
                            '<div class="ctc-input-cell ctc-parent-value"' +
                            ' id="ctc_' + valid + '_parent_' + rule + '_' + valid + '">' +
                            parentObj.orig + '</div>' + "\n" +
                            '<div class="ctc-input-cell">' + "\n" +
                            '<div class="ctc-swatch ctc-specific"' +
                            ' id="ctc_' + valid + '_parent_' + rule + '_' + valid + '_swatch">' +
                            self.getxt( 'swatch' ) + '</div></div>' + "\n" +
                            '<div class="ctc-input-cell">' +
                            '<a href="#" class="ctc-selector-handle"' +
                            ' id="ctc_selector_' + rule + '_' + valid + '">' +
                            self.getxt( 'selector' ) + '</a></div>' + "\n" +
                            '<div id="ctc_selector_' + rule + '_' + valid + '_container"' +
                            ' class="ctc-selector-container">' + "\n" +
                            '<a href="#" id="ctc_selector_' + rule + '_' + valid + '_close"' +
                            ' class="ctc-selector-handle ctc-exit" title="' +
                            self.getxt( 'close' ) + '"></a>' +
                            '<div id="ctc_selector_' + rule + '_' + valid + '_inner_container"' +
                            ' class="ctc-selector-inner-container clearfix">' + "\n" +
                            '<div id="ctc_status_val_qry_' + valid + '"></div>' + "\n" +
                            '<div id="ctc_selector_' + rule + '_' + valid + '_rows"></div>' + "\n" +
                            '</div></div></div>' + "\n";
                    } );
                    html += '</div>' + "\n";
                }
                $( '#ctc_rule_value_inputs' ).html( html ).find( '.ctc-swatch' ).each( function() {
                    self.coalesce_inputs( this );
                } );
            },
            // render list of selectors grouped by query for given value on Property/Value Tab
            val_qry: function( res ) {
                //console.log( 'in val_qry' );
                //console.log( res );
                var self = this,
                    html = '',
                    page_rule,
                    selector;
                if ( !self.is_empty( res.data ) ) {
                    $.each( res.data, function( rule, queries ) {
                        page_rule = rule;
                        $.each( queries, function( query, selectors ) {
                            html += '<h4 class="ctc-query-heading">' + query + '</h4>' + "\n";
                            if ( !self.is_empty( selectors ) ) {
                                $.each( selectors, function( qsid, qsdata ) {
                                    html += self.input_row( qsid, rule, res.key, qsdata );
                                } );
                            }
                        } );
                    } );
                }
                selector = '#ctc_selector_' + page_rule + '_' + res.key + '_rows';
                //console.log( selector );
                
                $( selector ).html( html ).find( '.color-picker' ).each( function() {
                    self.setup_spectrum( this );
                } );
                $( selector ).find( '.ctc-swatch' ).each( function() {
                    self.coalesce_inputs( this );
                } );
//                if ( self.jqueryerr.length ) {
//                    self.jquery_notice( 'val_qry' );
//                }
            },
            // populate list of queries and attach to query input element
            queries: function( res ) {
                $( '#ctc_sel_ovrd_query' ).data( 'menu', res.data );
            },
            // populate list of selectors and attach to selector input element
            selectors: function( res ) {
                $( '#ctc_sel_ovrd_selector' ).data( 'menu', res.data );
            },
            // populate list of rules and attach to rule input element
            rules: function( res ) {
                $( '#ctc_rule_menu' ).data( 'menu', res.data );
            },
            // render debug output
            debug: function( res ) {
                $( '#ctc_debug_box' ).val( $( '#ctc_debug_box' ).val() + res.data );
                //console.log( 'debug:' );
                //console.log( res.data );
            },
            // render stylesheet preview on child or parent css tab
            preview: function( res ) {
                $( '#view_' + res.key + '_options_panel' ).text( res.data );
            },
            dismiss: function() { // res ) {
                //console.log( 'dismiss came home!' );
                //console.log( res );
                //var self = this;
                //self.dismiss_notice();
            }
            
        },
        // applies core dismiss behavior to injected elements 
        bind_dismiss: function( el ) {
            //console.log( 'bind_dismiss' );
            var self = this,
                $this = $( el ),
                $button = $( '<button type="button" class="notice-dismiss"><span class="screen-reader-text"></span></button>' ),
                btnText = window.commonL10n.dismiss || '';
    
            // Ensure plain text
            $button.find( '.screen-reader-text' ).text( btnText );
    
            $this.append( $button );
    
            $button.on( 'click.wp-dismiss-notice', function( event ) {
                event.preventDefault();
                self.dismiss_notice( el );
            });
        },
        dismiss_notice: function( el ) {
            $( el ).fadeTo( 100 , 0, function() {
                $( this ).slideUp( 100, function() {
                    $( this ).remove();
                });
            });
        },
        reset_handling: function() {
            //console.log( '----> resetting form...' );
            $( '#parnt_analysis_notice .notice, #child_analysis_notice .notice' ).slideUp();
            $( '#ctc_enqueue_enqueue' ).prop( 'checked', true );
            $( '#ctc_handling_primary' ).prop( 'checked', true );
            $( '#ctc_ignoreparnt' ).prop( 'checked', false );
            $( '#ctc_repairheader' ).prop( 'checked', false );
        },
        // initialize object vars, bind event listeners to elements, load menus and start plugin
        init: function() {
            //console.log( 'initializing...' )
            var self = this;
            //self.jquery_exception( { 'message':'testing' }, 'Testing' );
            // try to initialize theme menus
            if ( !$( '#ctc_theme_parnt' ).is( 'input' ) ) {
                
                //console.log( 'initializing theme select menus...' );
                try {
                    $.widget( 'ctc.themeMenu', $.ui.selectmenu, {
                        _renderItem: function( ul, item ) {
                            var li = $( "<li>" ),
                                sel = item.value.replace( /[^\w\-]/g, '' );
                            $( '#ctc_theme_option_' + sel )
                                .detach().appendTo( li );
                            return li.appendTo( ul );
                        }    
                    } );
                } catch( exn ) {
                    self.jquery_exception( exn, 'Theme Menu' );
                }
                try {
                    $( '#ctc_theme_parnt' ).themeMenu( {
                        select: function( event, ui ) {
                            self.reset_handling();
                            self.set_parent_menu( ui.item );
                        }
                    } );
                } catch( exn ) {
                    if ( 'function' === typeof themeMenu ) {
                        $( '#ctc_theme_parnt' ).themeMenu( 'destroy' );
                    } else {
                        $( '#ctc_theme_parnt-button' ).remove();
                    }
                    self.jquery_exception( exn, 'Parent Theme Menu' );
                }
                if ( self.is_empty( window.ctcAjax.themes.child ) ) {
                    if ( $( '#ctc_child_name' ).length ) {
                        $( '#ctc_child_name' ).val( self.testname );
                        $( '#ctc_child_template' ).val( self.testslug );
                    }
                } else {
                    try {
                        $( '#ctc_theme_child' ).themeMenu( {
                            select: function( event, ui ) {
                                self.reset_handling();
                                self.set_child_menu( ui.item );
                            }
                        } );
                    } catch( exn ) {
                        if ( 'function' === typeof themeMenu ) {
                            $( '#ctc_theme_child' ).themeMenu( 'destroy' );
                        } else {
                            $( '#ctc_theme_child-button' ).remove();
                        }
                        self.jquery_exception( exn, 'Child Theme Menu' );
                    }
                }
            }
            
            // auto populate parent/child tab values
            self.currparnt = $( '#ctc_theme_parnt' ).val();
            self.currchild = $( '#ctc_theme_child' ).length ? $( '#ctc_theme_child' ).val() : '';
            $( '#ctc_main' ).on( 'click', '.ctc-section-toggle', function( e ) {
                e.preventDefault();
                $( this ).parents( '.ctc-input-row, .notice-warning, .updated, .error' ).first().find( '.ctc-section-toggle' )
                    .each( function() { 
                        $( this ).toggleClass( 'open' );
                    } );
                var id = $( this ).attr( 'id' ).replace(/\d$/, '') + '_content';
                $( '#' + id ).stop().slideToggle( 'fast' );
                return false;
            } );
            
            $( '#ctc_main' ).on( 'click', '.ctc-upgrade-notice .notice-dismiss', function() { // e ) {
                //console.log( 'dismiss upgrade clicked!' );
                //e.preventDefault();
                var postdata = {
                    'action': 'ctc_dismiss',
                    '_wpnonce': $( '#_wpnonce' ).val()
                };
                self.ajax_post( 'dismiss', postdata );
            } );
            
            if ( self.is_empty( self.jqueryerr ) ){
                //console.log( 'delegating event bindings...' )
                $( '#ctc_main' ).on( 'click', '.ctc-selector-handle', function( e ) {
                    //'.ctc-option-panel-container'
                    e.preventDefault();
                    if ( $( this ).hasClass( 'ajax-pending' ) ) {
                        return false;
                    }
                    $( this ).addClass( 'ajax-pending' );
                    //set_notice( '' );
                    var id = $( this ).attr( 'id' ).toString().replace( '_close', '' ),
                        parts = id.toString().match( /_([^_]+)_(\d+)$/ ),
                        rule,
                        valid;
                    if ( $( '#' + id + '_container' ).is( ':hidden' ) ) {
                        if ( !self.is_empty( parts[ 1 ] ) && !self.is_empty( parts[ 2 ] ) ) {
                            rule = parts[ 1 ];
                            valid = parts[ 2 ];
                            // retrieve selectors / values for individual value
                            self.query_css( 'val_qry', valid, { 'rule': rule } );
                        }
                    }
                    $( '#' + id + '_container' ).fadeToggle( 'fast' );
                    $( '.ctc-selector-container' ).not( '#' + id + '_container' ).fadeOut( 'fast' );
                } );
                
                $( '#ctc_main' ).on( 'click', '.ctc-save-input[type=button], .ctc-delete-input', function( e ) {
                    e.preventDefault();
                    if ( $( this ).hasClass( 'ajax-pending' ) ) {
                        return false;
                    }
                    $( this ).addClass( 'ajax-pending' );
                    self.save( this ); // refresh menus after updating data
                    return false;
                } );
                
                $( '#ctc_main' ).on( 'keydown', '.ctc-selector-container .ctc-child-value[type=text]', function( e ) {
                    if ( 13 === e.which ) { 
                        //console.log( 'return key pressed' );
                        var $obj = $( this ).parents( '.ctc-selector-row' ).find( '.ctc-save-input[type=button]' ).first();
                        if ( $obj.length ) {
                            e.preventDefault();
                            //console.log( $obj.attr( 'id' ) );
                            if ( $obj.hasClass( 'ajax-pending' ) ) {
                                return false;
                            }
                            $obj.addClass( 'ajax-pending' );
                            self.save( $obj );
                            return false;
                        }
                    }
                } );
                
                $( '#ctc_main' ).on( 'click', '.ctc-selector-edit', function( e ) {
                    e.preventDefault();
                    if ( $( this ).hasClass( 'ajax-pending' ) ) {
                        return false;
                    }
                    $( this ).addClass( 'ajax-pending' );
                    self.set_qsid( this );
                } );
                
                $( '#ctc_main' ).on( 'click', '.ctc-rewrite-toggle', function( e ) {
                    e.preventDefault();
                    self.selector_input_toggle( this );
                } );
                
                $( '#ctc_main' ).on( 'click', '#ctc_copy_selector', function(  ) {
                    var txt = $( '#ctc_sel_ovrd_selector_selected' ).text().trim();
                    if ( !self.is_empty( txt ) ){
                        $( '#ctc_new_selectors' ).val( $( '#ctc_new_selectors' ).val() + "\n" + txt + " {\n\n}" );
                    }
                } );
                // save theme as zip 
                $( '#ctc_main' ).on( 'click', '.ctc-backup-theme', function( e ) {
                    e.preventDefault();
                    // copy selected theme to zip export form
                    if ( self.existing ){
                        $( '#ctc_export_theme' ).val( self.currchild );
                    } else {
                        $( '#ctc_export_theme' ).val( self.currparnt );
                    }
                    //console.log( 'backup clicked - theme: ' + $( '#ctc_export_theme' ).val() );
                    // submit form
                    $( '#ctc_export_theme_form' ).submit();
                    // submit form
                } );
                $( '#ctc_configtype' ).on( 'change', function(  ) {
                    var val = $( this ).val();
                    if ( self.is_empty( val ) || 'theme' === val ) {
                        $( '.ctc-theme-only, .ctc-themeonly-container' ).removeClass( 'ctc-disabled' );
                        $( '.ctc-theme-only, .ctc-themeonly-container input' ).prop( 'disabled', false );
                        try {
                            $( '#ctc_theme_parnt, #ctc_theme_child' ).themeMenu( 'enable' );
                        } catch ( exn ) {
                            self.jquery_exception( exn, 'Theme Menu' );
                        }
                    } else {
                        $( '.ctc-theme-only, .ctc-themeonly-container' ).addClass( 'ctc-disabled' );
                        $( '.ctc-theme-only, .ctc-themeonly-container input' ).prop( 'disabled', true );
                        try {
                            $( '#ctc_theme_parnt, #ctc_theme_child' ).themeMenu( 'disable' );
                        } catch ( exn ) {
                            self.jquery_exception( exn, 'Theme Menu' );
                        }
                    }
                } );   
                 
                // these elements are not replaced so use direct selector events
                $( '.nav-tab' ).on( 'click', function( e ) {
                    e.preventDefault();
                    if ( $( e.target ).hasClass( 'ctc-disabled' ) ) {
                        return false;
                    }
                    // clear the notice box
                    //set_notice( '' );
                    $( '.ctc-query-icon,.ctc-status-icon' ).remove();
                    var id = '#' + $( this ).attr( 'id' );
                    self.focus_panel( id );
                } );
                
                $( '#view_child_options, #view_parnt_options' ).on( 'click', function( e ){ 
                    if ( $( e.target ).hasClass( 'ajax-pending' ) || $( e.target ).hasClass( 'ctc-disabled' ) ) {
                        return false;
                    }
                    $( e.target ).addClass( 'ajax-pending' );
                    self.css_preview( $( this ).attr( 'id' ) ); 
                } );
                
                $( '#ctc_load_form' ).on( 'submit', function() {
                    return ( self.validate() ); 
                } );
                
                $( '#ctc_query_selector_form' ).on( 'submit', function( e ) {
                    e.preventDefault();
                    var $this = $( '#ctc_save_query_selector' );
                    if ( $this.hasClass( 'ajax-pending' ) ) {
                        return false;
                    }
                    $this.addClass( 'ajax-pending' );
                    self.save( $this ); // refresh menus after updating data
                    return false;
                } );
                
                $( '#ctc_rule_value_form' ).on( 'submit', function( e ) {
                    //console.log( 'rule value empty submit' );
                    e.preventDefault();
                    return false;
                } );
                
                // update interface for existing child theme
                $( '#ctc_child_type_new,#ctc_child_type_existing,#ctc_child_type_duplicate,#ctc_child_type_reset' )
                    .on( 'focus click', function() {
                        //console.log( 'child type clicked!' );
                    self.reset_handling();
                    self.update_form();
                } );
                
                $( '#ctc_is_debug' ).on( 'change', function(  ) {
                    if ( $( this ).is( ':checked' ) ){
                        if ( !$( '#ctc_debug_box' ).length ){
                            $( '#ctc_debug_container' ).html( '<textarea id="ctc_debug_box"></textarea>' );
                        }
                    } else {
                        $( '#ctc_debug_box' ).remove();
                    }
                    self.save( this );
                } );
                
                $( '.ctc-live-preview' ).on( 'click', function( e ) {
                    e.stopImmediatePropagation();
                    e.preventDefault();
                    document.location = $( this ).prop( 'href' );
                    return false;
                } );
                //console.log( 'loading autoselect menus...' )
                // initialize autoselect menus
                self.setup_menus();
                
                // turn on submit buttons (disabled until everything is loaded to prevent errors)
                //console.log( 'releasing submit buttons...' )
                $( 'input[type=submit], input[type=button]' ).prop( 'disabled', false );
                self.scrolltop();
                self.update_form();
                //console.log( 'Ready.' );
            }
            if ( self.jqueryerr.length ) {
                self.jquery_notice();
            }
        },
        // object properties
        testslug:       '',
        testname:       '',
        reload:         false,
        currquery:      'base',
        currqsid:       null,
        currdata:       {},
        currparnt:      '',
        currchild:      '',
        existing:       false,
        jqueryerr:      [], // stores jquery exceptions thrown during init
        color_regx:     '\\s+(\\#[a-f0-9]{3,6}|rgba?\\([\\d., ]+?\\)|hsla?\\([\\d%., ]+?\\)|[a-z]+)',
        border_regx:    '(\\w+)(\\s+(\\w+))?',
        grad_regx:      '(\\w+)'

    };
    $.chldthmanalyze = {
        escrgx: function( str ) {
            return str.replace(/([.*+?^${}()|\[\]\/\\])/g, "\\$1");
        },
        
        trmcss: function( str ) {
            //console.log( 'trmcss: ' + str );
            return 'undefined' === typeof str ? '' : str.replace( /\-css$/, '' );
        },
        show_loading: function( resubmit, text ) {
            var themetype    = $.chldthmcfg.existing ? 'child' : 'parnt',
                name = text ? text : $.chldthmcfg.getname( themetype ),
                notice = '<strong class="ctc_analyze_loading"><span class="spinner is-active"></span>' + 
                $.chldthmcfg.getxt( resubmit ? 'anlz1' : 'anlz2' ) + ' ' + name + '...</strong>';
            self.noticediv = ( 'child' === themetype ? '' : '' );
            $( '#' + themetype + '_analysis_notice' ).html( notice );
            //$( 'html, body' ).animate( { scrollTop: 0 }, 'slow' );        
        },
        hide_loading: function() {
            $( '.ctc_analyze_loading' ).fadeTo( 200, 0, function(){ $( this ).slideUp( 200, function() { $( this ).remove(); } ); } );
        },
        setssl: function( url ){
            return url.replace( /^https?/, window.ctcAjax.ssl ? 'https' : 'http' );
        },
        /**
         * Fetch website home page and parse <head> for linked stylesheets
         * Use this to store dependencies and to mark them to be parsed as "default" stylesheets
         * Detects other signals for configuration heuristics during child theme setup.
         * If the initial ajax get requst fails, attempt request via a WordPress ajax call, 
         * which executes an http request on the server side. If both methods fail, notify user.
         */
        analyze_theme: function( themetype ) { 
            //console.log( 'analyze_theme' );
            var self        = this,
                now         = Math.floor( $.now() / 1000 ),
                stylesheet  = ( 'child' === themetype ? $.chldthmcfg.currchild : $.chldthmcfg.currparnt ),
                testparams  = '&template=' + encodeURIComponent( $.chldthmcfg.currparnt ) + '&stylesheet=' + encodeURIComponent( stylesheet ) + '&now=' + now,
                homeurl     = self.setssl( window.ctcAjax.homeurl ), // window.ctcAjax.homeurl, //
                url         = homeurl + testparams;
            
            self.analysis[ themetype ].url = url;

            /**
             * First, try to fetch home page using ajax get
             */
            //console.log( 'Fetching home page: ' + url );
            $.get( url, function( data ) {
                //console.log( data );
                self.parse_page( themetype, data );
                $( document ).trigger( 'analysisdone' );
            } ).fail( function( xhr, status, err ){
                //console.log( status );
                //console.log( err );
                //console.log( xhr );
                /**
                 * if this fails due to cross domain or other issue, 
                 * try fetching using ajax call that requests page on server side.
                 */
                self.analysis[ themetype ].signals.xhrgeterr = err;
                $.ajax( { 
                    url:        window.ctcAjax.ajaxurl,  
                    data:       {
                        action:     'ctc_analyze',
                        stylesheet: stylesheet,
                        template:   $.chldthmcfg.currparnt,
                        _wpnonce:   $( '#_wpnonce' ).val(),
                    },
                    dataType:   'json',
                    type:       'POST'
                } ).done( function( data ) {
                    if ( data.signals.httperr ) {
                        /**
                         * if both methods fail, there is a problem.
                         */
                        self.analysis[ themetype ].signals.failure = 1;
                        self.analysis[ themetype ].signals.httperr = data.signals.httperr;
                    } else {
                        self.parse_page( themetype, data.body );
                    }
                    $( document ).trigger( 'analysisdone' );
                } ).fail( function( xhr, status, err ){
                    /**
                     * if xhr fails both times there is a bigger problem.
                     */
                    //console.log( xhr );
                    self.analysis[ themetype ].signals.failure = 1;
                    self.analysis[ themetype ].signals.xhrajaxerr = err;
                    $( document ).trigger( 'analysisdone' );
                } );
            } );
        },
        parse_page: function( themetype, body ){

            var self        = this,
                themepath   = window.ctcAjax.theme_uri.replace( /^https?:\/\//, '' ),
                stylesheet  = ( 'child' === themetype ? $.chldthmcfg.currchild : $.chldthmcfg.currparnt ),
                escaped     = self.escrgx( $.chldthmcfg.currparnt ) + ( 'child' === themetype ? '|' + self.escrgx( stylesheet ) : '' ),
                regex_link  = new RegExp( "<link( rel=[\"']stylesheet[\"'] id=['\"]([^'\"]+?)['\"])?[^>]+?" +
                    self.escrgx( themepath ) + '/(' + escaped + ')/([^"\']+\\.css)(\\?[^"\']+)?["\'][^>]+>', 'gi' ),
                regex_err   = /<br \/>\n[^\n]+?(fatal|strict|notice|warning|error)[\s\S]+?<br \/>/gi,
                themeloaded = 0, // flag when style.css link is detected
                testloaded  = 0, // flag when test link is detected
                msg,
                queue,
                csslink;

            if ( 'child' === themetype ) {
                //console.log( body );
            }
            // retrieve enqueued stylesheet ids 
            if ( ( queue = body.match( /BEGIN WP QUEUE\n([\s\S]*?)\nEND WP QUEUE/ ) ) ) {
                self.analysis[ themetype ].queue = queue[ 1 ].split(/\n/);
                //console.log( 'QUEUE:' );
                //console.log( self.analysis[ themetype ].queue );
            } else {
                self.analysis[ themetype ].queue = [];
                self.analysis[ themetype ].signals.thm_noqueue = 1;
                //self.analysis[ themetype ].signals.failure = 1;
                //console.log( 'NO QUEUE' );
            }
            if ( ( queue = body.match( /BEGIN CTC IRREGULAR\n([\s\S]*?)\nEND CTC IRREGULAR/ ) ) ) {
                self.analysis[ themetype ].irreg = queue[ 1 ].split(/\n/);
            } else {
                self.analysis[ themetype ].irreg = [];
            }
            if ( body.match( /CHLD_THM_CFG_IGNORE_PARENT/ ) ) {
                self.analysis[ themetype ].signals.thm_ignoreparnt = 1;
                //console.log( 'thm_ignoreparnt' );
            }
            if ( body.match( /IS_CTC_THEME/ ) ) {
                self.analysis[ themetype ].signals.thm_is_ctc = 1;
                //console.log( 'thm_is_ctc' );
            }

            if ( body.match( /NO_CTC_STYLES/ ) ) {
                self.analysis[ themetype ].signals.thm_no_styles = 1;
                //console.log( 'thm_no_styles' );
            }
            if ( body.match( /HAS_CTC_IMPORT/ ) ) {
                self.analysis[ themetype ].signals.thm_has_import = 1;
                //console.log( 'thm_has_import' );
            }

            // remove comments to avoid flagging conditional stylesheets ( IE compatability, etc. )
            body = body.replace( /<!\-\-[\s\S]*?\-\->/g, '' );
            //console.log( 'PARSE:' );
            while ( ( msg = regex_err.exec( body ) ) ) {
                var errstr = msg[ 0 ].replace( /<.*?>/g, '' );
                self.phperr[ themetype ].push( errstr );
                self.analysis[ themetype ].signals.err_php = 1;
                if ( errstr.match( /Fatal error/i ) ) {
                    self.analysis[ themetype ].signals.err_fatal = 1;
                } 
                //else if ( errstr.match( /(FileNotFoundException|Failed opening|failed to open stream)/i ) ) {
                    //analysis.signals.err_fnf = 1;
                //}
            }
            while ( ( csslink = regex_link.exec( body ) ) ) {
                var stylesheetid    = self.trmcss( csslink[ 2 ] ),
                    stylesheettheme = csslink[ 3 ], 
                    stylesheetpath  = csslink[ 4 ],
                    linktheme       = $.chldthmcfg.currparnt === stylesheettheme ? 'parnt' : 'child',
                    noid            = 0;
                    //console.log( 'stylesheetid: ' + stylesheetid + ' stylesheetpath: ' + stylesheetpath );
                    // flag stylesheet links that have no id or are not in wp_styles 
                if ( '' === stylesheetid || -1 === $.inArray( stylesheetid, self.analysis[ themetype ].queue ) ) {
                    noid = 1;
                    //console.log( 'no id for ' + stylesheetpath + '!' );
                } else if ( 0 === stylesheetid.indexOf( 'chld_thm_cfg' ) ) { // handle ctc-generated links
                    // console.log( 'ctc link detected: ' + stylesheetid + ' themeloaded: ' + themeloaded );
                    if ( stylesheetpath.match( /^ctc\-style([\-\.]min)?\.css$/ ) ) {
                        //console.log( 'separate stylesheet detected' );
                        themeloaded = 1;
                        self.analysis[ themetype ].signals.ctc_sep_loaded = 1; // flag that separate stylesheet has been detected
                    } else if ( stylesheetpath.match( /^ctc\-genesis([\-\.]min)?\.css$/ ) ) {
                        //console.log( 'genesis stylesheet detected' );
                        themeloaded = 1;
                        self.analysis[ themetype ].signals.ctc_gen_loaded = 1; // flag that genesis "parent" has been detected
                    } else if ( stylesheetid.match( /$chld_thm_cfg_ext/ ) ) {
                        self.analysis[ themetype ].signals.ctc_ext_loaded = 1; // flag that external stylesheet link detected
                        self.analysis[ themetype ].deps[ themeloaded ].push( [ stylesheetid, stylesheetpath ] );
                    } else if ( 'chld_thm_cfg_child' === stylesheetid ) {
                        self.analysis[ themetype ].signals.ctc_child_loaded = 1; // flag that ctc child stylesheet link detected
                        self.analysis[ themetype ].deps[ themeloaded ].push( [ stylesheetid, stylesheetpath ] );
                    } else if ( 'chld_thm_cfg_parent' === stylesheetid ) {
                        self.analysis[ themetype ].signals.ctc_parnt_loaded = 1; // flag that ctc parent stylesheet link detected
                        self.analysis[ themetype ].deps[ themeloaded ].push( [ stylesheetid, stylesheetpath ] );
                        if ( themeloaded ){
                            //console.log( 'parent link out of sequence' );
                            self.analysis[ themetype ].signals.ctc_parnt_reorder = 1; // flag that ctc parent stylesheet link out of order
                        }
                    }
                    continue;
                }
                // flag main theme stylesheet link
                if ( stylesheetpath.match( /^style([\-\.]min)?\.css$/ ) ) {
                    //console.log( linktheme + ' theme stylesheet detected: ' + stylesheettheme + '/' + stylesheetpath ); 
                    themeloaded = 1; // flag that main theme stylesheet has been detected
                    // if main theme stylesheet link has no id then it is unregistered ( hard-wired )
                    if ( 'parnt' === linktheme ) {
                        if ( noid ) {
                            self.analysis[ themetype ].signals.thm_parnt_loaded = 'thm_unregistered';
                        } else {
                            self.analysis[ themetype ].signals.thm_parnt_loaded = stylesheetid;
                            // check that parent stylesheet is loaded before child stylesheet
                            if ( 'child' === themetype && self.analysis[ themetype ].signals.thm_child_loaded ) {
                                self.analysis[ themetype ].signals.ctc_parnt_reorder = 1;
                            }
                        }
                    } else {
                        self.analysis[ themetype ].signals.thm_child_loaded = noid ? 'thm_unregistered' : stylesheetid;
                    }
                    if ( noid ) {
                        if ( testloaded ) {
                            self.analysis[ themetype ].signals.thm_past_wphead = 1;
                            self.analysis[ themetype ].deps[ themeloaded ].push( [ 'thm_past_wphead', stylesheetpath ] );
                            //console.log( 'Unreachable theme stylesheet detected' );
                        } else {
                            self.analysis[ themetype ].signals.thm_unregistered = 1;
                            self.analysis[ themetype ].deps[ themeloaded ].push( [ 'thm_unregistered', stylesheetpath ] );
                            //console.log( 'Unregistered theme stylesheet detected' );
                        }
                    } else {
                        self.analysis[ themetype ].deps[ themeloaded ].push( [ stylesheetid, stylesheetpath ] );
                        //console.log( 'Theme stylesheet OK!' );
                    }

                } else if ( 'ctc-test.css' === stylesheetpath ) { // flag test stylesheet link
                    //console.log( 'end of queue reached' );
                    testloaded = 1; // flag that test queue has been detected ( end of wp_head )
                } else {
                    var err = null;
                    // if stylesheet link has id and loads before main theme stylesheet, add it as a dependency
                    // otherwise add it as a parse option
                    if ( noid ) {
                        err = 'dep_unregistered';
                    }
                    if ( testloaded ) {
                        if ( themeloaded ) {
                            //console.log( 'Unreachable stylesheet detected!' + stylesheetpath );
                            err = 'css_past_wphead';
                        } else {
                            err = 'dep_past_wphead';
                        }
                    }
                    // Flag stylesheet links that have no id and are loaded after main theme stylesheet. 
                    // This indicates loading outside of wp_head()
                    if ( err ) {
                        self.analysis[ themetype ].signals[ err ] = 1;
                        stylesheetid = err;
                    } else {
                        self.dependencies[ stylesheetid ] = stylesheetpath;
                    }
                    self.analysis[ themetype ].deps[ themeloaded ].push( [ stylesheetid, stylesheetpath ] );
                }
            }
            if ( ! themeloaded ){
                self.analysis[ themetype ].signals.thm_notheme = 1; // flag that no theme stylesheet has been detected
            }
        },

        /**
         * Uses analysis data to auto configure form, pass parameters
         * for child theme setup and display results to user.
         */
        css_notice: function() {
            //console.log( 'in css_notice' );
            var self        = this,
                themetype    = $.chldthmcfg.existing ? 'child' : 'parnt',
                name        = $.chldthmcfg.getname( themetype ),
                hidden      = '',
                notice      = { 
                    notices:    [],
                },
                errnotice   = {
                    style:      'notice-warning',
                    headline:   $.chldthmcfg.getxt( 'anlz3', name ),
                    errlist:    ''
                },
                resubmit    = 0,
                resubmitdata= {},
                anlz,
                debugtxt    = '',
                dep_inputs;

            if ( self.analysis[ themetype ].signals.failure || 
                ( self.analysis[ themetype ].signals.thm_noqueue && !self.phperr[ themetype ].length ) ) {
                //if ( $( '#ctc_is_debug' ).is( ':checked' ) ) {
                    debugtxt = $.chldthmcfg.getxt( 'anlz33' ).replace(/%1/, '<a href="' + self.analysis[ themetype ].url + '" target="_new">' ).replace( /%2/, '</a>' );
                //}
                notice.notices.push( {
                    headline:   $.chldthmcfg.getxt( 'anlz4', name ),
                    msg: $.chldthmcfg.getxt( 'anlz5' ) + debugtxt,
                    style: 'notice-warning'
                } );
            } else {
                // test errors
                if ( self.phperr[ themetype ].length ) {
                    $.each( self.phperr[ themetype ], function( index, err ) {
                        if ( err.match( /Fatal error/i ) ) {
                            errnotice.style    = 'error';
                            errnotice.headline =  $.chldthmcfg.getxt( 'anlz8', name );
                        } 
                        /*
                        if ( $.chldthmcfg.existing && err.match( /(FileNotFoundException|Failed opening|failed to open stream)/i ) ) {
                            //console.log( 'Probably using get_stylesheet_directory()' );
                            notice.subhead = 'A file cannot be found in the Child Theme\'s directory.'; 
                        }
                        */
                        errnotice.errlist += err + "\n"; 
                    } );
                    errnotice.msg = '<div style="background-color:#ffeebb;padding:6px">' +
                        '<div class="ctc-section-toggle" id="ctc_analysis_errs">' + 
                        $.chldthmcfg.getxt( 'anlz6' ) + '</div>' +
                        '<div id="ctc_analysis_errs_content" style="display:none"><textarea>' + 
                        errnotice.errlist + '</textarea></div></div>' +
                        $.chldthmcfg.getxt( 'anlz7' );
                    notice.notices.push( errnotice );
                }
                if ( self.analysis[ themetype ].signals.thm_past_wphead || self.analysis[ themetype ].signals.dep_past_wphead ) { 
                    // || self.analysis[ themetype ].signals.css_past_wphead ){
                    notice.notices.push( {
                        headline: $.chldthmcfg.getxt( 'anlz9' ),
                        style: 'notice-warning',
                        msg: $.chldthmcfg.getxt( 'anlz10' )
                    } );
                    $( '#ctc_repairheader' ).prop( 'checked', true );
                    $( '#ctc_repairheader_container' ).show();
                }
                if ( self.analysis[ themetype ].signals.thm_unregistered ) {
                    if (
                        !self.analysis[ themetype ].signals.ctc_child_loaded &&
                        !self.analysis[ themetype ].signals.ctc_sep_loaded ){
                    // test for stylesheet enqueue issues
                        notice.notices.push( {
                            headline: $.chldthmcfg.getxt( 'anlz11' ),
                            style: 'notice-warning',
                            msg: $.chldthmcfg.getxt( 'anlz12' )
                        } );
                        $( '#ctc_repairheader_container' ).show();
                        $( '#ctc_repairheader' ).prop( 'checked', true );
                    }
                }
                if ( 'child' === themetype ) {
                    if ( self.analysis.child.signals.ctc_parnt_reorder ) {
                        //console.log( 'reorder flag detected, resubmitting.' );
                        resubmit = 1;
                    }
                    if ( !self.analysis.child.signals.ctc_child_loaded &&
                        !self.analysis.child.signals.ctc_sep_loaded &&
                        !self.analysis.child.signals.thm_child_loaded ){
                        notice.notices.push( {
                            headline: $.chldthmcfg.getxt( 'anlz13' ),
                            style: 'notice-warning',
                            msg: $.chldthmcfg.getxt( 'anlz14' )
                        } );
                        resubmit = 1;
                    }
                    if ( self.analysis[ themetype ].signals.ctc_gen_loaded ) {
                        notice.notices.push( {
                            headline: $.chldthmcfg.getxt( 'anlz31' ),
                            msg: $.chldthmcfg.getxt( 'anlz32' ),
                            style: 'notice-warning'
                        } );
                    }
                    if ( !self.analysis.parnt.signals.thm_no_styles &&
                        !self.analysis.child.signals.ctc_gen_loaded &&
                        !self.analysis.child.signals.thm_parnt_loaded &&
                        !self.analysis.child.signals.ctc_parnt_loaded &&
                        !self.analysis.child.signals.thm_ignoreparnt &&
                        !self.analysis.child.signals.thm_has_import ){
                        notice.notices.push( {
                            headline: $.chldthmcfg.getxt( 'anlz15' ),
                            style: 'notice-warning',
                            msg: $.chldthmcfg.getxt( 'anlz16' )
                        } );
                        resubmit = 1;
                    }
                    if ( self.analysis.child.signals.thm_unregistered &&
                        self.analysis.child.signals.thm_child_loaded &&
                        'thm_unregistered' === self.analysis.child.signals.thm_child_loaded &&
                        self.analysis.child.signals.ctc_child_loaded &&
                        self.analysis.child.signals.ctc_parnt_loaded ) {
                        notice.notices.push( {
                            headline: $.chldthmcfg.getxt( 'anlz28' ),
                            style: 'notice-warning',
                            msg: $.chldthmcfg.getxt( 'anlz29' )
                        } );
                        $( '#ctc_repairheader_container' ).show();
                        $( '#ctc_repairheader' ).prop( 'checked', true );
                    }
                    
                    if ( !self.analysis.child.signals.thm_is_ctc &&
                        !$( '#ctc_child_type_duplicate' ).is( ':checked' ) ) {
                        notice.notices.push( {
                            headline: $.chldthmcfg.getxt( 'anlz19' ),
                            msg: $.chldthmcfg.getxt( 'anlz20' ),
                            style: 'notice-warning'
                        } );
                    }
                }
                // automatically set form inputs based on current analysis
                if ( self.analysis[ themetype ].signals.ctc_sep_loaded || self.analysis[ themetype ].signals.ctc_gen_loaded ){
                    //console.log( 'Separate stylesheet detected' );
                    $( '#ctc_handling_separate' ).prop( 'checked', true );
                }
                if ( !notice.notices.length ) {
                    notice.notices.push( { 
                        headline: '' + ( 'child' === themetype ? $.chldthmcfg.getxt( 'anlz17' ) : $.chldthmcfg.getxt( 'anlz18' ) ) + '',
                        style: 'updated',
                        msg: ''
                    } );
                }
                
                if ( 'child' === themetype && self.analysis.child.signals.thm_has_import ) {
                    notice.notices.push( {
                        headline: $.chldthmcfg.getxt( 'anlz21' ),
                        msg: $.chldthmcfg.getxt( 'anlz22' ),
                        style: 'notice-warning'
                    } );
                    //console.log( 'Import parent detected' );
                    $( '#ctc_enqueue_import' ).prop( 'checked', true );
                }
                if ( self.analysis[ themetype ].signals.thm_ignoreparnt || self.analysis[ themetype ].signals.ctc_gen_loaded ){
                    //console.log( 'Ignore parent detected' );
                    $( '#ctc_ignoreparnt' ).prop( 'checked', true );
                    if ( !$( '#ctc_enqueue_none' ).is( ':checked' ) ) {
                        $( '#ctc_enqueue_none' ).prop( 'checked', true );
                        resubmit = 1;
                        resubmitdata.ctc_enqueue = 'none';
                    }
                } else {
                    $( '#ctc_ignoreparnt' ).prop( 'checked', false );
                }
                if ( !self.analysis[ themetype ].signals.ctc_sep_loaded && 
                    !self.analysis[ themetype ].signals.ctc_gen_loaded && 
                    !self.analysis[ themetype ].signals.ctc_child_loaded && 
                    !self.analysis[ themetype ].signals.thm_unregistered && 
                    !self.analysis[ themetype ].signals.thm_past_wphead && 
                    self.analysis[ themetype ].deps[ 1 ].length ) {
                    var sheets = '';
                    $.each( self.analysis[ themetype ].deps[ 1 ], function( ndx, el ) {
                        if ( el[ 1 ].match( /^style([\-\.]min)?\.css$/ ) ) { return; }
                        sheets += '<li>' + el[ 1 ] + "</li>\n";
                    } );
                    if ( '' !== sheets ) {
                    sheets = "<ul class='howto' style='padding-left:1em'>\n" + sheets + "</ul>\n";
                    notice.notices.push( {
                        headline: $.chldthmcfg.getxt( 'anlz23' ),
                        msg: sheets + $.chldthmcfg.getxt( 'anlz24' ),
                        style: 'updated'
                    } );
                    }
                }
                if ( 'child' === themetype && self.analysis[ themetype ].signals.thm_parnt_loaded ) {
                    //if ( !$( '#ctc_enqueue_none' ).is( ':checked' ) ) {
                        notice.notices.push( {
                            headline: $.chldthmcfg.getxt( 'anlz25' ),
                            msg: $.chldthmcfg.getxt( 'anlz26' ),
                            style: 'updated'
                        } );
                    //}
                    $( '#ctc_enqueue_none' ).prop( 'checked', true );
                    resubmit = 1;
                    resubmitdata.ctc_enqueue = 'none';
                }
                // if no parent styles, no need to enqueue
                if ( self.analysis.parnt.signals.thm_no_styles ) {
                    //if ( !$( '#ctc_enqueue_none' ).is( ':checked' ) ) {
                        notice.notices.push( {
                            headline: $.chldthmcfg.getxt( 'anlz27' ),
                            msg: $.chldthmcfg.getxt( 'anlz26' ),
                            style: 'updated'
                        } );
                    //}
                    $( '#ctc_enqueue_none' ).prop( 'checked', true );
                    resubmit = 1;
                    resubmitdata.ctc_enqueue = 'none';
                }
            }
            
            /**
             * Auto-configure parameters
             * Some configuration must be done based on theme-specific signals 
             * These are passed back as hidden inputs
             */
            // parent has styles
            hidden = encodeURIComponent( JSON.stringify( self.analysis ) );
            
            $( 'input[name="ctc_analysis"]' ).val( hidden );
            resubmitdata.ctc_analysis = hidden;
            if ( self.is_success() && resubmit && !self.resubmitting ){
                self.resubmitting = 1;
                self.resubmit( resubmitdata );
                return;
            } else {
                self.resubmitting = 0;
                self.hide_loading();
                $.each( notice.notices, function( ndx, notice ){
                    //console.log( notice );
                    var $out = $( '<div class="' + notice.style + ' notice is-dismissible dashicons-before" >' + 
                    '<h4>' + notice.headline + '</h4>' +
                    notice.msg +
                    '</div>' );
                    $.chldthmcfg.bind_dismiss( $out );
                    $out.hide().appendTo( '#' + themetype + '_analysis_notice' ).slideDown();
                } );
                
                //if ( $( '#ctc_is_debug' ).is( ':checked' ) ) {
                    anlz = '<div style="background-color:#ddd;padding:6px">' +
                        '<div class="ctc-section-toggle" id="ctc_analysis_obj">' + 
                        $.chldthmcfg.getxt( 'anlz30' ) + 
                        '</div>' +
                        '<div id="ctc_analysis_obj_content" style="display:none">' +
                        '<textarea style="font-family:monospace;font-size:10px">' + 
                        JSON.stringify( self.analysis, null, 2 ) + 
                        '</textarea></div></div>';
                
                    $( anlz ).appendTo( '#' + themetype + '_analysis_notice' );

                //}
                
                // v2.1.3 remove stylesheet dependencies
                dep_inputs = '';
                // console.log( self.dependencies );
                $.each( self.dependencies, function( ndx, el ){
                    // console.log( 'setting dependecy: ' + ndx + ' ' + el );
                    if ( el ) {
                        dep_inputs += '<label><input class="ctc_checkbox ctc-themeonly" id="ctc_forcedep_' + ndx +
                        '" name="ctc_forcedep[]" type="checkbox" value="' + ndx + '" autocomplete="off" ' +
                        ( -1 !== $.inArray( ndx, window.ctcAjax.forcedep ) ? 'checked' : '' ) +
                        ' />' + ndx + "</label><br/>\n";
                    }
                });
                // console.log( 'dep_inputs: ' + dep_inputs.length );
                if ( dep_inputs.length ){
                    $( '#ctc_dependencies' ).html( dep_inputs );
                    $( '#ctc_dependencies_container' ).show();
                } else {
                    $( '#ctc_dependencies' ).empty();
                    $( '#ctc_dependencies_container' ).hide();                    
                }

                if ( !$( '#ctc_child_type_reset' ).is( ':checked' ) ) {
                    $( '#input_row_stylesheet_handling_container,#input_row_parent_handling_container,#ctc_child_header_parameters,#ctc_configure_submit' ).slideDown( 'fast' );
                    if ( $( '#ctc_child_type_duplicate' ).is( ':checked' ) ) {
                        $( '#ctc_configure_submit .ctc-step' ).text( '8' );
                        $( '#ctc_copy_theme_mods' ).find( 'input' ).prop( 'checked', false );
                    } else {
                        $( '#ctc_configure_submit .ctc-step' ).text( '9' );
                        $( '#ctc_copy_theme_mods' ).slideDown( 'fast' );
                    }
                    if ( $( '#ctc_child_type_duplicate' ).is( ':checked' ) || $( '#ctc_child_type_new' ).is( ':checked' ) ) {
                        $( '#input_row_theme_slug' ).hide();
                        $( '#input_row_new_theme_slug' ).slideDown( 'fast' );
                    } else {
                        $( '#input_row_new_theme_slug' ).hide();
                        $( '#input_row_theme_slug' ).slideDown( 'fast' );
                    }
                }
            
                //console.log( 'end css_notice' );
            }
            
        },
        resubmit: function( data ) {
            var self = this;
            self.hide_loading();
            self.show_loading( true );
            data.action = 'ctc_update';
            data._wpnonce = $( '#_wpnonce' ).val();
            //console.log( '=====>>> RESUBMIT CALLED! <<<=====' );
            //console.log( data );
            $.ajax( { 
                url:        window.ctcAjax.ajaxurl,  
                data:       data,
                //dataType:   'json',
                type:       'POST'
            } ).done( function() { // response ) {
                //console.log( 'resubmit done:' );
                //console.log( response );
                self.hide_loading();
                self.do_analysis();
            } ).fail( function() { // xhr, status, err ) {
                //self.do_analysis();
                self.hide_loading();
                //console.log( status + ' ' + err );
                // FIXME: handle failure
            } );  
        },
        do_analysis: function() {
            var self            = this;
            self.analysis    = {
                parnt: {
                    deps: [[],[]],
                    signals: {
                        failure: 0
                    },
                    queue: [],
                    irreg: []
                },
                child: {
                    deps: [[],[]],
                    signals: {
                        failure: 0
                    },
                    queue: [],
                    irreg: []
                }
            };
            self.phperr         = { parnt: [], child: [] };
            self.dependencies   = {};
            self.done           = 0;
            self.show_loading( false );
            self.analyze_theme( 'parnt' );
            if ( $.chldthmcfg.existing ) {
                self.analyze_theme( 'child' );
            }
            //$( '#ctc_enqueue_enqueue' ).prop( 'checked', true );
            //$( '#ctc_handling_primary' ).prop( 'checked', true );
            //$( '#ctc_ignoreparent' ).prop( 'checked', false );
        },
        // initialize object vars, bind event listeners to elements, load menus and start plugin
        init: function() {
            //console.log( 'initializing...' )
            var self = this;
            // ajax request done
            $( document ).on( 'analysisdone', function(){
                self.done++;
                //console.log( 'analysis came home ' + self.done );
                //console.log( 'existing: ' + $.chldthmcfg.existing );
                //console.log( 'parent: ' + $( '#ctc_theme_parnt' ).val() );
                // all ajax requests done
                if ( self.done > $.chldthmcfg.existing ){
                    //console.log( 'analysis complete!' );
                    self.done = 0;
                    self.css_notice();
                }
            } );
            // run analyzer on demand
            $( '#ctc_main' ).on( 'click', '.ctc-analyze-theme', function() {
                if ( self.is_success() ) {
                    $.chldthmcfg.dismiss_notice( $( '.ctc-success-response' ).parent( '.notice' ) );
                }
                self.do_analysis();
            } );
            // if page is success response run the analyzer on load
            if ( self.is_success() && !window.ctcAjax.pluginmode ) {
                self.do_analysis();
            }
        },
        analysis: {}, // analysis signals object
        done: 0, // analysis semphore
        resubmitting: 0, // resubmit semaphore
        dependencies: {}, // addl stylesheets that may require dependencies
        is_success: function(){
            return $( '.ctc-success-response' ).length;
        }
    };
    // don't initialize if this is FTP request
    if (!$( '#request-filesystem-credentials-form' ).length ){
        $.chldthmcfg.init();
        $.chldthmanalyze.init();
    }
} ( jQuery ) );

