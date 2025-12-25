<footer class="site-footer">
    <div class="container">
        <nav class="footer-navigation">
            <?php
            wp_nav_menu(array(
                'theme_location' => 'footer',
                'menu_class'     => 'footer-menu',
                'fallback_cb'    => 'roliascan_footer_menu_fallback',
            ));
            ?>
        </nav>
        
        <div class="footer-copyright">
            <p>&copy; <?php echo date('Y'); ?> ROLIASCAN Inc. All rights reserved</p>
        </div>
    </div>
</footer>

<?php wp_footer(); ?>
</body>
</html>

<?php
function roliascan_footer_menu_fallback() {
    echo '<ul class="footer-menu">';
    echo '<li><a href="' . esc_url(home_url('/')) . '">HOME</a></li>';
    echo '<li><a href="' . esc_url(home_url('/about-us/')) . '">ABOUT US</a></li>';
    echo '<li><a href="' . esc_url(home_url('/privacy-policy/')) . '">PRIVACY POLICY</a></li>';
    echo '<li><a href="' . esc_url(home_url('/terms-conditions/')) . '">TERMS CONDITIONS</a></li>';
    echo '<li><a href="' . esc_url(home_url('/contact-us/')) . '">CONTACT US</a></li>';
    echo '<li><a href="' . esc_url(home_url('/html-sitemap/')) . '">SITEMAP</a></li>';
    echo '</ul>';
}
?>
