(function() {
	tinymce.PluginManager.requireLangPack('bk');
	
	tinymce.create('tinymce.plugins.bk', {
		init : function(ed, url) {
			ed.addCommand('bk', function() {
				var inst = tinyMCE.getInstanceById('content');
				var html = inst.selection.getContent();
				if(html!=''){
					window.tinyMCE.execInstanceCommand('content', 'mceInsertContent', false, '&nbsp;&nbsp;<strong>'+html+'</strong> （ <a href="http://www.hudong.com/wiki/'+encodeURI(html)+'" target="_blank">互动百科</a>  |  <a href="http://zh.wikipedia.org/wiki/'+encodeURI(html)+'" target="_blank">维基百科</a> ）');}
				return;
			});

			ed.addButton('bk', {
				title : '百科链接',
				cmd : 'bk',
				image : url + '/hudong.png'
			});
			ed.onNodeChange.add(function(ed, cm, n) {
				cm.setActive('bk', n.nodeName == 'IMG');
			});
		},
		createControl : function(n, cm) {
			return null;
		},
		getInfo : function() {
			return {
					longname  : '百科链接',
					author 	  : '互动百科',
					authorurl : 'http://www.hudong.com',
					infourl   : 'http://www.hudong.com',
					version   : "1.0"
			};
		}
	});

	tinymce.PluginManager.add('bk', tinymce.plugins.bk);
})();


