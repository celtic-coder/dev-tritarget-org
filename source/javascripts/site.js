var site = {};

// Function: initCollapsibleDivs() {{{1
site.initCollapsibleDivs = function () {
    jQuery(".box_top").each(function() {
        jQuery(this).click(function() {
            jQuery(this).siblings(".box_text").slideToggle("fast", function() {
                jQuery(this).siblings(".box_bottom").toggle();
            });
            jQuery(this).toggleClass("collapsed");
        });
    });
};

// Function: initDialogBoxes() {{{1
site.initDialogBoxes = function () {
    // Set div to correct location in layout
    jQuery("#dialog-boxes").appendTo("body");

    //if close button is clicked
    jQuery('.window .close').click(function (e) {
        //Cancel the link behavior
        e.preventDefault();
        jQuery('#mask, .window').hide();
    });

    //if mask is clicked
    jQuery('#mask').click(function () {
        jQuery(this).hide();
        jQuery('.window').hide();
    });
};

// Function: keyed() {{{1
site.keyed = function (e) {
    site.kkeys.push( e.keyCode );
    if ( site.kkeys.toString().indexOf( site.konami ) >= 0 ){
        site.openDialog("#game");

        if ( typeof SKI != "undefined" )
        {
            SKI.run(jQuery("#game"));
        }
        else
        {
            jQuery.getScript("http://github.com/sukima/skiQuery/raw/master/skiQuery.js", function() {
                SKI.run(jQuery("#game"))
            });
        }

        site.kkeys = [];
        return false;
    }
    // Prevent an ever growing array
    if ( site.kkeys.length > 10 )
        site.kkeys.shift();
    return true;
};

// Function: initKonamiCode() {{{1
site.initKonamiCode = function () {
    site.kkeys = [];
    site.konami = "38,38,40,40,37,39,37,39,66,65";
    if (jQuery.browser.mozilla) {
        jQuery(document).keypress (site.keyed);
    } else {
        jQuery(document).keydown (site.keyed);
    }
};

// Function: collapseDivs() {{{1
site.collapseDivs = function () {
    jQuery(".box_top.collapsed").each(function() {
        jQuery(this).siblings(".box_text").hide();
        jQuery(this).siblings(".box_bottom").hide();
    });
};

// Function: openDialog() {{{1
site.openDialog = function (id) {
    //Get the screen height and width
    var maskHeight = jQuery(document).height();
    var maskWidth = jQuery(window).width();

    //Set height and width to mask to fill up the whole screen
    jQuery('#mask').css({'width':maskWidth,'height':maskHeight});
    //Set the position to the top of the page
    jQuery('#mask').css({'top':0,'left':0});

    //transition effect
    jQuery('#mask').fadeIn(1000);
    jQuery('#mask').fadeTo("slow",0.8);

    //Get the window height and width
    var winH = jQuery(window).height();
    var winW = jQuery(window).width();

    //Set the popup window to center
    jQuery(id).css('top', winH/2-jQuery(id).height()/2);
    jQuery(id).css('left', winW/2-jQuery(id).width()/2);

    //transition effect
    jQuery(id).fadeIn(2000);
}

/* vim:set sw=4 ts=4 et fdm=marker: */
