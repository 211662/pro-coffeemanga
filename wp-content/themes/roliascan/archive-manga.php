<?php
/**
 * Template for displaying manga archive (all manga)
 */

get_header(); ?>

<main id="main" class="site-main manga-archive">
    <div class="container">
        <header class="archive-header">
            <h1 class="archive-title">
                <?php
                if (is_tax('genre')) {
                    single_term_title('Genre: ');
                } else {
                    echo 'All Manga';
                }
                ?>
            </h1>
            
            <?php
            if (is_tax('genre')) {
                $term_description = term_description();
                if (!empty($term_description)) {
                    echo '<div class="archive-description">' . $term_description . '</div>';
                }
            }
            ?>
        </header>

        <div class="manga-archive-grid">
            <?php
            if (have_posts()) :
                while (have_posts()) :
                    the_post();
                    ?>
                    <div class="manga-card">
                        <a href="<?php the_permalink(); ?>" class="manga-link">
                            <?php if (has_post_thumbnail()) : ?>
                                <div class="manga-thumbnail">
                                    <?php the_post_thumbnail('medium'); ?>
                                </div>
                            <?php endif; ?>
                            
                            <div class="manga-card-content">
                                <h3 class="manga-title"><?php the_title(); ?></h3>
                                
                                <?php
                                $genres = get_the_terms(get_the_ID(), 'genre');
                                if ($genres && !is_wp_error($genres)) :
                                    ?>
                                    <div class="manga-genres-small">
                                        <?php
                                        $genre_count = 0;
                                        foreach ($genres as $genre) :
                                            if ($genre_count >= 3) break;
                                            ?>
                                            <span class="genre-tag-small"><?php echo esc_html($genre->name); ?></span>
                                            <?php
                                            $genre_count++;
                                        endforeach;
                                        ?>
                                    </div>
                                    <?php
                                endif;
                                ?>
                                
                                <div class="manga-meta-small">
                                    <span class="meta-date"><?php echo get_the_date(); ?></span>
                                </div>
                            </div>
                        </a>
                    </div>
                    <?php
                endwhile;

                // Pagination
                the_posts_pagination(array(
                    'mid_size' => 2,
                    'prev_text' => __('← Previous', 'roliascan'),
                    'next_text' => __('Next →', 'roliascan'),
                ));

            else :
                ?>
                <div class="no-results">
                    <h2><?php _e('No manga found', 'roliascan'); ?></h2>
                    <p><?php _e('Sorry, no manga were found. Please check back later!', 'roliascan'); ?></p>
                </div>
                <?php
            endif;
            ?>
        </div>
    </div>
</main>

<?php get_footer(); ?>
