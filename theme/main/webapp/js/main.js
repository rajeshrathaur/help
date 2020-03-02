
// Back to Top

$(window).scroll(function() {
    var height = $(window).scrollTop();
    if (height > 150) {
        $('#back2Top').fadeIn();
    } else {
        $('#back2Top').fadeOut();
    }
});
$(document).ready(function() {
    $("#back2Top").click(function(event) {
        event.preventDefault();
        $("html, body").animate({ scrollTop: 0 }, "slow");
        return false;
    });

});




$("#home-banner").owlCarousel({
    nav: false,
    margin: 10,
    loop: true,
    dots: true,
    center: false,
    autoplay: 1000,
    autoplayTimeout: 7000,
    smartSpeed: 1500,
    autoplayHoverPause: true,
    responsive: {
        0: {
            items: 1,
        },
        600: {
            items: 1,
        },
        1000: {
            items: 1,
        }
    }
});


$("#logo-slider").owlCarousel({
    nav: true,
    margin: 50,
    loop: true,
    dots: false,
    center: false,
    autoplay: 1000,
    autoplayTimeout: 7000,
    smartSpeed: 1500,
    autoplayHoverPause: true,
    responsive: {
        0: {
            items: 1,
        },
        600: {
            items: 4,
        },
        1000: {
            items: 6,
        }
    }
});




