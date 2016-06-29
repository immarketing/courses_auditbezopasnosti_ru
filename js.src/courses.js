/**
 * Created by AVGorbunov on 25.02.2016.
 */

$(document).ready(function () {
    $('.agImagePopup').magnificPopup({
        type: 'image'
        // other options
    });

    $('body').each(function () {
        var $spy = $(this).scrollspy('refresh')
    });

    $( window ).scroll(function(eo) {
        //$( "span" ).css( "display", "inline" ).fadeOut( "slow" );
        //console.log("scroll(function(" + eo);

        if ( $(document).scrollTop() > $("#about").offset().top-30) {
            $("a.navbar-brand").show(400);
            //$("a.navbar-brand").removeClass("ag-no-display animated slideOutUp");
            //$("a.navbar-brand").addClass('ag-display animated slideInUp');
        } else {
            $("a.navbar-brand").hide(400);
            //$("a.navbar-brand").removeClass("animated slideInUp");
            //$("a.navbar-brand").addClass('animated slideOutDown');

        }
    });

    // Add smooth scrolling to all links in navbar + footer link
    $(".navbar a, footer a[href='#myPage']").on('click', function (event) {

        // Prevent default anchor click behavior
        event.preventDefault();

        // Store hash
        var hash = this.hash;

        // Using jQuery's animate() method to add smooth page scroll
        // The optional number (900) specifies the number of milliseconds it takes to scroll to the specified area
        $('html, body').animate({
            scrollTop: $(hash).offset().top
        }, 400, function () {

            // Add hash (#) to URL when done scrolling (default click behavior)
            window.location.hash = hash;
        });
    });

    $('body>div.container.ag-slideUp').addClass("ag-hidden").viewportChecker({
        classToAdd: 'ag-visible animated fadeIn-- flipInX-- slideInUp',
        offset: 150
    });

    $(".navbar").on("activate.bs.scrollspy", function () {
        //var x = $(".nav li.active > a");
        //$("#demo").empty().html("You are currently viewing: " + x);
        //console.log(x.text());
        //console.log(x.length);

        //$("a.navbar-brand").css("display", "block");
        //$("a.navbar-brand").css("visibility", "visible");
        //$("a.navbar-brand").show(800);
    })
});
