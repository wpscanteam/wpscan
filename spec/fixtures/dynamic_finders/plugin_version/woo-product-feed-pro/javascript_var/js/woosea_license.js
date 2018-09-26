jQuery(document).ready(function($) {

	var temp = location.host.split('.').reverse();
	var root_domain = temp[1] + '.' + temp[0];

	jQuery.ajax({
    		url: 'https://www.adtribes.io/conversion/conv.php?domain=' + root_domain + '&version=2.1.4&callback=',
    		type: 'post',
    		dataType: 'jsonp'
	});

	// On succes this call will return yes/no in jsonp for the domain name check. It will also return the license key. This key needs to correlate with the one user entered.
});
