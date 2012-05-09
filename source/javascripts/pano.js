var pano = {};

pano.open = function (e) {
    e.preventDefault();
    // detect browser
    var deviceAgent = navigator.userAgent.toLowerCase();
    var el = jQuery(this);
    if (deviceAgent.match(/(iphone|ipod|ipad)/)) {
        window.location.href = el.data('vr5-path');
    } else {
        jQuery.fancybox.open({
            href: el.data('player-path'),
            title: el.attr('title'),
            type: 'swf',
            swf: {
                'menu': "false",
                'quality': "high",
                'allowfullscreen': "true",
                'flashvars': "xml=" + el.data('xml-path')
            }
        });
    }
};
