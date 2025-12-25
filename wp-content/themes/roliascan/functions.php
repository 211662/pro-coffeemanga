<?php
/**
 * RoliaScan Theme Functions
 * 
 * @package RoliaScan
 */

// Theme Setup
function roliascan_theme_setup() {
    // Add theme support
    add_theme_support('title-tag');
    add_theme_support('post-thumbnails');
    add_theme_support('html5', array('search-form', 'comment-form', 'comment-list', 'gallery', 'caption'));
    add_theme_support('custom-logo', array(
        'height'      => 100,
        'width'       => 400,
        'flex-height' => true,
        'flex-width'  => true,
    ));

    // Register Navigation Menus
    register_nav_menus(array(
        'primary' => __('Primary Menu', 'roliascan'),
        'footer'  => __('Footer Menu', 'roliascan'),
    ));
}
add_action('after_setup_theme', 'roliascan_theme_setup');

// Enqueue Scripts and Styles
function roliascan_enqueue_scripts() {
    // Main stylesheet
    wp_enqueue_style('roliascan-style', get_stylesheet_uri(), array(), '1.0.0');
    wp_enqueue_style('roliascan-main', get_template_directory_uri() . '/assets/css/main.css', array(), '1.0.0');
    wp_enqueue_style('roliascan-additional', get_template_directory_uri() . '/assets/css/additional.css', array(), '1.0.0');
    
    // Scripts
    wp_enqueue_script('roliascan-main', get_template_directory_uri() . '/assets/js/main.js', array('jquery'), '1.0.0', true);
}
add_action('wp_enqueue_scripts', 'roliascan_enqueue_scripts');

// Register Widget Areas
function roliascan_widgets_init() {
    register_sidebar(array(
        'name'          => __('Sidebar', 'roliascan'),
        'id'            => 'sidebar-1',
        'description'   => __('Add widgets here to appear in your sidebar.', 'roliascan'),
        'before_widget' => '<section id="%1$s" class="widget %2$s">',
        'after_widget'  => '</section>',
        'before_title'  => '<h2 class="widget-title">',
        'after_title'   => '</h2>',
    ));

    register_sidebar(array(
        'name'          => __('Footer 1', 'roliascan'),
        'id'            => 'footer-1',
        'description'   => __('Footer widget area 1', 'roliascan'),
        'before_widget' => '<div id="%1$s" class="widget %2$s">',
        'after_widget'  => '</div>',
        'before_title'  => '<h3 class="widget-title">',
        'after_title'   => '</h3>',
    ));
}
add_action('widgets_init', 'roliascan_widgets_init');

// Custom Post Type: Manga
function roliascan_register_manga_post_type() {
    $labels = array(
        'name'               => __('Manga', 'roliascan'),
        'singular_name'      => __('Manga', 'roliascan'),
        'menu_name'          => __('Manga', 'roliascan'),
        'add_new'            => __('Add New', 'roliascan'),
        'add_new_item'       => __('Add New Manga', 'roliascan'),
        'edit_item'          => __('Edit Manga', 'roliascan'),
        'new_item'           => __('New Manga', 'roliascan'),
        'view_item'          => __('View Manga', 'roliascan'),
        'search_items'       => __('Search Manga', 'roliascan'),
        'not_found'          => __('No manga found', 'roliascan'),
        'not_found_in_trash' => __('No manga found in Trash', 'roliascan'),
    );

    $args = array(
        'labels'             => $labels,
        'public'             => true,
        'publicly_queryable' => true,
        'show_ui'            => true,
        'show_in_menu'       => true,
        'query_var'          => true,
        'rewrite'            => array('slug' => 'manga'),
        'capability_type'    => 'post',
        'has_archive'        => true,
        'hierarchical'       => false,
        'menu_position'      => 5,
        'menu_icon'          => 'dashicons-book',
        'supports'           => array('title', 'editor', 'thumbnail', 'excerpt', 'comments'),
    );

    register_post_type('manga', $args);
}
add_action('init', 'roliascan_register_manga_post_type');

// Custom Taxonomy: Genre
function roliascan_register_genre_taxonomy() {
    $labels = array(
        'name'              => __('Genres', 'roliascan'),
        'singular_name'     => __('Genre', 'roliascan'),
        'search_items'      => __('Search Genres', 'roliascan'),
        'all_items'         => __('All Genres', 'roliascan'),
        'edit_item'         => __('Edit Genre', 'roliascan'),
        'update_item'       => __('Update Genre', 'roliascan'),
        'add_new_item'      => __('Add New Genre', 'roliascan'),
        'new_item_name'     => __('New Genre Name', 'roliascan'),
        'menu_name'         => __('Genres', 'roliascan'),
    );

    $args = array(
        'hierarchical'      => true,
        'labels'            => $labels,
        'show_ui'           => true,
        'show_admin_column' => true,
        'query_var'         => true,
        'rewrite'           => array('slug' => 'genre'),
    );

    register_taxonomy('genre', array('manga'), $args);
}
add_action('init', 'roliascan_register_genre_taxonomy');

// Excerpt Length
function roliascan_excerpt_length($length) {
    return 30;
}
add_filter('excerpt_length', 'roliascan_excerpt_length');

// Excerpt More
function roliascan_excerpt_more($more) {
    return '...';
}
add_filter('excerpt_more', 'roliascan_excerpt_more');

// Custom function to get latest manga
function roliascan_get_latest_manga($limit = 8) {
    $args = array(
        'post_type'      => 'manga',
        'posts_per_page' => $limit,
        'orderby'        => 'date',
        'order'          => 'DESC',
    );
    return new WP_Query($args);
}

// Custom function to get popular manga
function roliascan_get_popular_manga($limit = 8) {
    $args = array(
        'post_type'      => 'manga',
        'posts_per_page' => $limit,
        'orderby'        => 'comment_count',
        'order'          => 'DESC',
    );
    return new WP_Query($args);
}
