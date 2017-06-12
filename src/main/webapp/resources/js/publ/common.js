// //preloading
// $(window).load( function(){
//  $(".preload-wrap").fadeOut(100);
//  $('body').removeClass('ov-h');
// });

$(document).ready(function() {

    //gnb
    $('.gnb > li').mouseenter(function() {
        $('.gnb > li > a').removeClass('on');
        $('.gnb ul').hide();
        $(this).find('ul').show();
        $(this).children('a:first').addClass('on');
    });
    $('.gnb > li').mouseleave(function() {
        $(this).find('ul').hide();
        $(this).children('a:first').removeClass('on');
    });
    /*
    $('.gnb > li > a').click(function() {
      if($(this).next('ul').is(':visible')) {
        $(this).next('ul').hide();
        $(this).removeClass('on');
        $(this).parents('.menu-wrap').find('.bg-gnb').removeClass('on');
      } else {
        $('.gnb > li > a').removeClass('on');
        $('.gnb ul').hide();
        $(this).next('ul').show();
        $(this).addClass('on');
        $(this).parents('.menu-wrap').find('.bg-gnb').addClass('on');
      }
    });
    */
    //header search
    $('.btn-search').click(function() {
        $(this).parent('.search-box').toggleClass('show');
    });

    //lnb
 /*   $('.lnb .depth2').click(function() {
        var $this = $(this);
        var $parent = $(this).parent();

        if($parent.hasClass('on')){
            $parent.removeClass('on');
        } else {
            $('.lnb .node2').removeClass('on');
            $('.lnb .depth2').next('ul').hide();
            $parent.addClass('on');
            $this.next('ul').show();
        }
    });*/

    //tab
    $('.tab-menu a').click(function() {
        var href = $(this).attr('href')
        $(this).addClass('on').siblings().removeClass('on')
        $('.tab-con').hide();
        $(href).show();
    });

    //radio
    $('.radio-w label').on('click', function() {
        if ($(this).children('input').is(':checked')) {
            $(this).parent().children().removeClass('on');
            $(this).addClass('on');
        } else {
            $(this).removeClass('on');
        }
    });

    //checkbox
    $('.checkbox-w label').on('click', function() {
        if ($(this).children('input').is(':checked')) {
            $(this).addClass('on');
        } else {
            $(this).removeClass('on');
        }
    });
    
    $(document).on('click', '#checkbox-w label', function() {
    	if ($(this).children('input').is(':checked')) {
    		$(this).addClass('on');
    	} else {
    		$(this).removeClass('on');
    	}

    });
    

    //sort button
    $('.btn-sort').click(function() {
        $(this).toggleClass('on');
    });

    // table toggle btn
    $('.toggle-wrap').click(function() {
        $(this).find('.btn-show').toggleClass('on')
    });


    // check element initialize
    $('input:checkbox, input:radio').each(function() {
        if ($(this).is(':checked') == true) {
            $(this).parent().addClass('on');
        }
    });

    //file input
    var fileElm = $('.input-file-wrap');
    if (fileElm.length > 0) {
        $(fileElm).each(function() {
            var parentElm = $(this);
            $(this).find('input[type=file]').change(function() {
                var thisVal = $(this).val();
                thisVal = thisVal.substr(thisVal.lastIndexOf('\\') + 1);
                parentElm.find('input[type=text]').attr('value', thisVal);
                //parentElm.find('button').focus();
            });
            $(this).find('button').click(function() {
                parentElm.find('input[type=file]').focus();
            });
        });
    }

    //datepicker
    $('.datepicker-wrap').datepicker({
        format: "yyyy/mm/dd",
        orientation: "bottom left",
        autoclose: true
    });

});

//browser check
;
(function($) {
    $.browserTest = function(a, z) {
        var u = 'unknown',
            x = 'X',
            m = function(r, h) {
                for (var i = 0; i < h.length; i = i + 1) {
                    r = r.replace(h[i][0], h[i][1]);
                }
                return r;
            },
            c = function(i, a, b, c) {
                var r = {
                    name: m((a.exec(i) || [u, u])[1], b)
                };
                r[r.name] = true;
                r.version = (c.exec(i) || [x, x, x, x])[3];
                if (r.name.match(/safari/) && r.version > 400) {
                    r.version = '2.0';
                }
                if (r.name === 'presto') {
                    r.version = ($.browser.version > 9.27) ? 'futhark' : 'linear_b';
                }
                r.versionNumber = parseFloat(r.version, 10) || 0;
                r.versionX = (r.version !== x) ? (r.version + '').substr(0, 1) : x;
                r.className = r.name + r.versionX;
                return r;
            };
        a = (a.match(/Opera|Navigator|Minefield|KHTML|Chrome/) ? m(a, [
            [/(Firefox|MSIE|KHTML,\slike\sGecko|Konqueror)/, ''],
            ['Chrome Safari', 'Chrome'],
            ['KHTML', 'Konqueror'],
            ['Minefield', 'Firefox'],
            ['Navigator', 'Netscape']
        ]) : a).toLowerCase();
        $.browser = $.extend((!z) ? $.browser : {}, c(a, /(camino|chrome|firefox|netscape|konqueror|lynx|msie|opera|safari)/, [], /(camino|chrome|firefox|netscape|netscape6|opera|version|konqueror|lynx|msie|safari)(\/|\s)([a-z0-9\.\+]*?)(\;|dev|rel|\s|$)/));
        $.layout = c(a, /(gecko|konqueror|msie|opera|webkit)/, [
            ['konqueror', 'khtml'],
            ['msie', 'trident'],
            ['opera', 'presto']
        ], /(applewebkit|rv|konqueror|msie)(\:|\/|\s)([a-z0-9\.]*?)(\;|\)|\s)/);
        $.os = {
            name: (/(win|mac|linux|sunos|solaris|iphone)/.exec(navigator.platform.toLowerCase()) || [u])[0].replace('sunos', 'solaris')
        };
        if (!z) {
            $('html').addClass([$.os.name, $.browser.name, $.browser.className, $.layout.name, $.layout.className].join(' '));
        }
    };
    $.browserTest(navigator.userAgent);
})(jQuery);
//http://jquery.thewikies.com/browser/
$(function() {
    if ($.browser.name == 'msie') {
        $('body').addClass($.browser.className);
    } else {
        $('body').addClass($.browser.name);
    }
});
