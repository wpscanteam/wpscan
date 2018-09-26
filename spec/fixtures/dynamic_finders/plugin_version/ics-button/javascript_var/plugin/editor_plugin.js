(function() {
	tinymce.create('tinymce.plugins.icsButtonPlugin', {		
		init : function(ed, url) {			
			ed.addCommand('eventDialog', function() {
				ed.windowManager.open({
					file : ajaxurl + '?action=ics_button_tinymce',
					width : 415,
					height : 280,
					inline : 1
				}, {
					plugin_url : url // Plugin absolute URL
				});
			});
			ed.addButton('icsbutton', {
				title : 'Add Event',
				cmd : 'eventDialog',
				image : url + '/img/calendar_button.gif'
			});			
			ed.onNodeChange.add(function(ed, cm, n) { 
				cm.setActive('icsbutton', (tinymce.DOM.hasClass(n.parentNode.parentNode,'vevent')||tinymce.DOM.hasClass(n.parentNode,'vevent')||tinymce.DOM.hasClass(n,'vevent')));
			});
		},		
		createControl : function(n, cm) {
			return null;
		},		
		getInfo : function() {
			return {
				longname : '.ICS Button Plugin',
				author : 'Joe Motacek',
				authorurl : 'http://www.joemotacek.edu',
				infourl : 'http://www.joemotacek.edu',
				version : "0.6"
			};
		}
	});
	tinymce.PluginManager.add('icsbutton', tinymce.plugins.icsButtonPlugin);
})();