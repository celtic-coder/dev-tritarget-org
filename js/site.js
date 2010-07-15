var site = function() {

    return {
        initCollapsibleDivs : function () {
            var titleDiv;
            var contentDiv;
            $('#column-right > div').each(function() {
                titleDiv = $('.column-right-title', this);
                contentDiv = $('.column-right-content', this);
                console.log(this);
                titleDiv.click(function(){
                    contentDiv.slideToggle();
                    contentDiv.toggleClass("content-visible");
                    if (contentDiv.hasClass("content-visible"))
                    {
                        $('.headerLine', this).html("-------------");
                    }
                    else
                    {
                        $('.headerLine', this).html("+++++++++++++");
                    }
                });
            });
        },

        collapseAll : function () {
            $('.column-right-content').hide();
        }
    };

}();
