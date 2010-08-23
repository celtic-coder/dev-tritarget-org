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

// Function: collapseDivs() {{{1
site.collapseDivs = function () {
    $(".box_top.collapsed").each(function() {
        $(this).siblings(".box_text").hide();
        $(this).siblings(".box_bottom").hide();
    });
};

/* vim:set sw=4 ts=4 et fdm=marker: */
