<?php
/**
 * Template for displaying single manga posts
 */

get_header(); ?>

<main id="main" class="site-main single-manga">
    <div class="container">
        <?php
        while (have_posts()) :
            the_post();
            ?>
            <article id="post-<?php the_ID(); ?>" <?php post_class(); ?>>
                
                <div class="manga-detail-wrapper">
                    <div class="manga-thumbnail-large">
                        <?php if (has_post_thumbnail()) : ?>
                            <?php the_post_thumbnail('large'); ?>
                        <?php endif; ?>
                    </div>

                    <div class="manga-info">
                        <header class="manga-header">
                            <h1 class="manga-title"><?php the_title(); ?></h1>
                            
                            <?php
                            $genres = get_the_terms(get_the_ID(), 'genre');
                            if ($genres && !is_wp_error($genres)) :
                                ?>
                                <div class="manga-genres">
                                    <?php foreach ($genres as $genre) : ?>
                                        <a href="<?php echo esc_url(get_term_link($genre)); ?>" class="genre-tag">
                                            <?php echo esc_html($genre->name); ?>
                                        </a>
                                    <?php endforeach; ?>
                                </div>
                                <?php
                            endif;
                            ?>
                        </header>

                        <div class="manga-meta">
                            <span class="meta-item">
                                <strong>Author:</strong> <?php echo get_post_meta(get_the_ID(), 'manga_author', true) ?: 'Unknown'; ?>
                            </span>
                            <span class="meta-item">
                                <strong>Status:</strong> <?php echo get_post_meta(get_the_ID(), 'manga_status', true) ?: 'Ongoing'; ?>
                            </span>
                            <span class="meta-item">
                                <strong>Updated:</strong> <?php echo get_the_date(); ?>
                            </span>
                        </div>

                        <div class="manga-excerpt">
                            <?php the_excerpt(); ?>
                        </div>

                        <div class="manga-actions">
                            <button class="btn btn-primary">Start Reading</button>
                            <button class="btn btn-secondary">Add to Bookmark</button>
                        </div>
                    </div>
                </div>

                <div class="manga-description">
                    <h2>Description</h2>
                    <?php the_content(); ?>
                </div>

                <div class="manga-chapters">
                    <h2>Chapters</h2>
                    <div class="chapters-list">
                        <!-- Chapters will be listed here - can be populated via custom post type or plugin -->
                        <p>Chapter list will be displayed here when chapters are added.</p>
                    </div>
                </div>

                <?php
                if (comments_open() || get_comments_number()) :
                    comments_template();
                endif;
                ?>

            </article>
            <?php
        endwhile;
        ?>
    </div>
</main>

<?php get_footer(); ?>
