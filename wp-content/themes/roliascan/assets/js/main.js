/**
 * RoliaScan Theme - Main JavaScript
 */

(function($) {
    'use strict';

    // Mobile Menu Toggle
    $('.menu-toggle').on('click', function() {
        $('.nav-menu').toggleClass('active');
        $(this).attr('aria-expanded', function(index, attr) {
            return attr === 'true' ? 'false' : 'true';
        });
    });

    // Smooth Scrolling
    $('a[href*="#"]').not('[href="#"]').not('[href="#0"]').on('click', function(event) {
        if (location.pathname.replace(/^\//, '') === this.pathname.replace(/^\//, '') && 
            location.hostname === this.hostname) {
            var target = $(this.hash);
            target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
            
            if (target.length) {
                event.preventDefault();
                $('html, body').animate({
                    scrollTop: target.offset().top - 80
                }, 1000);
            }
        }
    });

    // FAQ Toggle
    $('.faq-item h3').on('click', function() {
        $(this).next('p').slideToggle(300);
        $(this).parent().toggleClass('active');
    });

    // Lazy Loading Images
    if ('IntersectionObserver' in window) {
        const imageObserver = new IntersectionObserver(function(entries, observer) {
            entries.forEach(function(entry) {
                if (entry.isIntersecting) {
                    const img = entry.target;
                    img.src = img.dataset.src;
                    img.classList.remove('lazy');
                    imageObserver.unobserve(img);
                }
            });
        });

        const images = document.querySelectorAll('img.lazy');
        images.forEach(function(img) {
            imageObserver.observe(img);
        });
    }

    // Scroll to Top Button
    var scrollButton = $('<button class="scroll-to-top" aria-label="Scroll to top">↑</button>');
    $('body').append(scrollButton);

    $(window).on('scroll', function() {
        if ($(this).scrollTop() > 300) {
            scrollButton.fadeIn();
        } else {
            scrollButton.fadeOut();
        }
    });

    scrollButton.on('click', function() {
        $('html, body').animate({scrollTop: 0}, 600);
        return false;
    });

    // Add loading animation
    $(window).on('load', function() {
        $('body').addClass('loaded');
    });

})(jQuery);
