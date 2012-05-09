var pano = {};

pano.vr5_path_for = function (href) {
    return href.replace(/salado\.html/, "vr5.html");
};

pano.open = function (e) {
    e.preventDefault();
    // detect browser
    var deviceAgent = navigator.userAgent.toLowerCase();
    var el = $(this);
    if (deviceAgent.match(/(iphone|ipod|ipad)/)) {
        window.location.href = pano.vr5_path_for(el.attr('href'));
    } else {
        jQuery.fancybox.open({
            href: el.attr('href'),
            title: el.attr('title')
        }, { type: 'ajax' });
    }
};
