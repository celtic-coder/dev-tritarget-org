var pano = {};

pano.vr5_path_for = function (el) {
    el = jQuery(el);
    var href = el.attr('href');
    href = href.replace(/\/salado\//, "/vr5/");
    return href;
};

pano.open = function (e) {
    e.preventDefault();
    // detect browser
    var deviceAgent = navigator.userAgent.toLowerCase();
    if (deviceAgent.match(/(iphone|ipod|ipad)/)) {
        window.location.href = pano.vr5_path_for(this.attr('href'));
    } else {
        jQuery.fancybox.open({
            href: this.attr('href'),
            title: this.attr('title')
        }, { type: 'ajax' });
    }
};
