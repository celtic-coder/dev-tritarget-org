var site = {};

// Function: initCollapsibleDivs() {{{1
site.initCollapsibleDivs = function () {
    $(".box_top").each(function() {
        $(this).click(function() {
            $(this).siblings(".box_text").slideToggle("fast", function() {
                $(this).siblings(".box_bottom").toggle();
            });
            $(this).toggleClass("collapsed");
        });
    });
};

// Function: initDialogBoxes() {{{1
site.initDialogBoxes = function () {
    //if close button is clicked
    $('.window .close').click(function (e) {
        //Cancel the link behavior
        e.preventDefault();
        $('#mask, .window').hide();
    });

    //if mask is clicked
    $('#mask').click(function () {
        $(this).hide();
        $('.window').hide();
    });
};

// Function: initKonamiCode() {{{1
site.initKonamiCode = function () {
    site.kkeys = [];
    site.konami = "38,38,40,40,37,39,37,39,66,65";
    $(document).keydown(function(e) {
        site.kkeys.push( e.keyCode );
        if ( site.kkeys.toString().indexOf( site.konami ) >= 0 ){
            site.openDialog("#game");

            if ( typeof SKI != "undefined" )
            {
                SKI.run($("#game"));
            }
            else
            {
                $.getScript("http://github.com/sukima/skiQuery/raw/master/skiQuery.js", function() {
                    SKI.run($("#game"))
                });
            }

            site.kkeys = [];
            return false;
        }
        // Prevent an ever growing array
        if ( site.kkeys.length > 10 )
            site.kkeys.shift();
        return true;
    });
};

// Function: collapseDivs() {{{1
site.collapseDivs = function () {
    $(".box_top.collapsed").each(function() {
        $(this).siblings(".box_text").hide();
        $(this).siblings(".box_bottom").hide();
    });
};

// Function: openDialog() {{{1
site.openDialog = function (id) {
    //Get the screen height and width
    var maskHeight = $(document).height();
    var maskWidth = $(window).width();

    //Set height and width to mask to fill up the whole screen
    $('#mask').css({'width':maskWidth,'height':maskHeight});
    //Set the position to the top of the page
    $('#mask').css({'top':0,'left':0});

    //transition effect
    $('#mask').fadeIn(1000);
    $('#mask').fadeTo("slow",0.8);

    //Get the window height and width
    var winH = $(window).height();
    var winW = $(window).width();

    //Set the popup window to center
    $(id).css('top', winH/2-$(id).height()/2);
    $(id).css('left', winW/2-$(id).width()/2);

    //transition effect
    $(id).fadeIn(2000);
}

/* vim:set sw=4 ts=4 et fdm=marker: */
