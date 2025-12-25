<!DOCTYPE html>
<html <?php language_attributes(); ?>>
<head>
    <meta charset="<?php bloginfo('charset'); ?>">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <?php wp_head(); ?>
</head>
<body <?php body_class(); ?>>
<?php wp_body_open(); ?>

<header class="site-header">
    <div class="container">
        <div class="header-wrapper">
            <div class="site-branding">
                <?php if (has_custom_logo()) : ?>
                    <?php the_custom_logo(); ?>
                <?php else : ?>
                    <a href="<?php echo esc_url(home_url('/')); ?>" class="site-logo">
                        <img src="<?php echo get_template_directory_uri(); ?>/assets/images/roliascan-logo.png" alt="<?php bloginfo('name'); ?>">
                    </a>
                <?php endif; ?>
            </div>

            <nav class="main-navigation">
                <button class="menu-toggle" aria-controls="primary-menu" aria-expanded="false">
                    <span class="menu-icon"></span>
                </button>
                <?php
                wp_nav_menu(array(
                    'theme_location' => 'primary',
                    'menu_id'        => 'primary-menu',
                    'menu_class'     => 'nav-menu',
                    'fallback_cb'    => false,
                ));
                ?>
            </nav>
        </div>
    </div>
</header>

<div class="site-banner">
    <div class="container">
        <div class="banner-content">
            <h1>RoliaScan current domain name 👇</h1>
            <div class="domain-box">
                <a href="<?php echo esc_url(home_url('/')); ?>" class="access-button">
                    <?php echo esc_url(home_url('/')); ?>
                </a>
                <span class="access-text">Access</span>
            </div>
            <p class="update-text">✅ Update: <?php echo date('d/m/Y'); ?></p>
            
            <div class="social-links">
                <p>Follow RoliaScan channel to get notified about the latest changes and features.</p>
                <div class="social-buttons">
                    <a href="#" class="social-btn facebook">Follow on Facebook</a>
                    <a href="#" class="social-btn instagram">Follow on Instagram</a>
                    <a href="#" class="social-btn twitter">Follow on Twitter</a>
                    <a href="mailto:contact@roliascan.com" class="social-btn email">Send us an email</a>
                </div>
            </div>
        </div>
    </div>
</div>
