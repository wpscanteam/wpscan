/*!  - v4.1.1
 * https://github.com/lukaspawlik/windows-azure-storage#readme
 * Copyright (c) 2018; */
(function ( $, window, undefined ) {
  'use strict';
  $( document ).ready( function () {
    $( '#windows-azure-storage-media-button' ).on( 'click', function ( event ) {
      event.preventDefault();
      var elem = $( event.currentTarget ),
        editor = elem.data( 'editor' ) + '-azure',
        options = {
          frame: 'post',
          state: 'iframe:browse',
          title: wp.media.view.l10n.addMedia,
          multiple: false
        };

      elem.blur();
      wp.azureFrame = wp.media.editor.open( editor, options );
      wp.azureFrame.on( 'azure:selected', function ( selectedImage ) {
        var imgContent = '<img src="' + selectedImage.url + '" />';
        if ( !selectedImage.isImage ) {
          imgContent = '<a href="' + selectedImage.url + '">' + selectedImage.url + '</a>';
        }
        wp.media.editor.activeEditor = 'content';
        wp.media.editor.insert( imgContent );
        wp.azureFrame.close();
      } );
      wp.azureFrame.on( 'close', function () {
        wp.azureFrame.off( 'azure:selected' );
        wp.media.editor.activeEditor = 'content';
      } );
    } );
    $( '.azure-container-selector' ).on( 'change', function ( event ) {
      event.preventDefault();
      var htmlForm = document.getElementById( 'azure-settings-form' );
      var divCreateContainer = document.getElementById( 'div-create-container' );
      if ( '__newContainer__' === htmlForm.elements.default_azure_storage_account_container_name.value ) {
        divCreateContainer.style.display = 'block';
        htmlForm.elements[ 'azure-submit-button' ].disabled = true;

      } else {
        divCreateContainer.style.display = 'none';
        htmlForm.elements[ 'azure-submit-button' ].disabled = false;
      }
    } );
    $( '.azure-create-container-button' ).on( 'click', function ( event ) {
      event.preventDefault();
      var htmlForm = document.getElementById( 'azure-settings-form' );
      var action = document.getElementsByName( 'action' )[ 0 ];
      if ( typeof action !== 'undefined' ) {
        action.name = 'action2';
      }

      htmlForm.action = $( this ).data( 'containerUrl' );
      htmlForm.submit();
    } );

    function get_upload_progress( item_id, item ) {
      $.post( window.ajaxurl, {
        action: 'get-azure-progress',
        data: {
          item_id: item_id
        }
      } ).done( function ( response ) {
        var progressText = azureStorageConfig.l10n.uploadingToAzure + '...';
        if ( response.data.total > 0 && response.data.current > -1 ) {
          progressText += ' (' + response.data.current + ' / ' + response.data.total + ')';
        }
        if ( response.data.progress >= 0 ) {
          $( '.percent', item ).html( progressText );
          $( '.bar', item ).width( 2 * response.data.progress );
          $( 'div.media-modal-content' ).find( 'div.media-uploader-status.uploading > *' ).first().text( progressText );
          $( 'div.media-modal-content' ).find( 'div.media-uploader-status.uploading' ).find( 'div.media-progress-bar > div' ).css( 'width', response.data.progress + '%' );
          $( 'div.media-modal-content' ).find( 'ul.attachments' ).find( 'div.media-progress-bar:last > div' ).css( 'width', response.data.progress + '%' );
          $( 'div.media-frame' ).find( 'ul.attachments' ).find( 'div.media-progress-bar:last > div' ).css( 'width', response.data.progress + '%' );
          $( 'div.media-frame-content' ).find( 'div.attachment-media-view.landscape' ).find( 'div.media-progress-bar > div' ).css( 'width', response.data.progress + '%' );
          $( 'div.media-modal.wp-core-ui' ).find( 'div.media-frame-title > h1' ).text( progressText );
        }
        if ( response.data.progress < 100 ) {
          window.setTimeout( function () {
            get_upload_progress( item_id, item );
          }, 1000 );
        }
      } ).fail( function () {
        window.setTimeout( function () {
          get_upload_progress( item_id, item );
        }, 1000 );
      } );
    }

    window.before_upload = function ( up, file ) {
      up.settings.multipart_params.item_id = file.id;
    };

    window.upload_progess = function ( up, file ) {
      if ( file.percent === 100 ) {
        var item = $( '#media-item-' + file.id );
        $( '.percent', item ).html( azureStorageConfig.l10n.uploadingToAzure );
        $( 'div.media-uploader-status.uploading > *' ).first().text( azureStorageConfig.l10n.uploadingToAzure );
        window.setTimeout( function () {
          get_upload_progress( file.id, item );
        }, 2000 );
      }
    };

    if ( typeof uploader !== 'undefined' ) {
      uploader.bind( 'UploadProgress', function ( up, file ) {
        window.upload_progess( up, file );
      } );
      uploader.bind( 'BeforeUpload', function ( up, file ) {
        window.before_upload( up, file );
      } );
    }

    if ( wp && wp.media && wp.media.view && wp.media.view.UploaderWindow ) {
      var curUploaderWindow = wp.media.view.UploaderWindow;
      wp.media.view.UploaderWindow = wp.media.view.UploaderWindow.extend( {
        ready: function () {
          curUploaderWindow.prototype.ready.apply( this, arguments );
          this.uploader.uploader.bind( 'BeforeUpload', function ( up, file ) {
            window.before_upload( up, file );
          } );
          this.uploader.uploader.bind( 'UploadProgress', function ( up, file ) {
            window.upload_progess( up, file );
          } );
        }
      } );
    }
  } );

})( jQuery, this );

