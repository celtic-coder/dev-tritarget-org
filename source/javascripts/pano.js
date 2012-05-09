var pano = {};

pano.isIOS = function () {
    // detect browser
    return navigator.userAgent.
        toLowerCase().
        match(/(iphone|ipod|ipad)/);
};

pano.openPano = function (e) {
    e.preventDefault();
    var el = jQuery(this);
    if (pano.isIOS()) {
        window.location.href = el.data('vr5-path');
    } else {
        jQuery.fancybox.open({
            href: el.attr('href'),
            title: el.attr('title'),
            type: 'iframe'
        });
    }
};
