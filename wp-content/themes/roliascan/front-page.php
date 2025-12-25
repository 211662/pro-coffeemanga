<?php get_header(); ?>

<main id="main" class="site-main front-page">
    
    <!-- Manga Updates Section -->
    <section class="manga-updates">
        <div class="container">
            <h2 class="section-title">Manga Updates!</h2>
            
            <div class="manga-grid">
                <?php
                $latest_manga = roliascan_get_latest_manga(8);
                
                if ($latest_manga->have_posts()) :
                    while ($latest_manga->have_posts()) : $latest_manga->the_post();
                        ?>
                        <div class="manga-card">
                            <a href="<?php the_permalink(); ?>" class="manga-link">
                                <?php if (has_post_thumbnail()) : ?>
                                    <div class="manga-thumbnail">
                                        <?php the_post_thumbnail('medium'); ?>
                                    </div>
                                <?php endif; ?>
                                <h3 class="manga-title"><?php the_title(); ?></h3>
                            </a>
                        </div>
                        <?php
                    endwhile;
                    wp_reset_postdata();
                else :
                    ?>
                    <p><?php _e('No manga updates available yet.', 'roliascan'); ?></p>
                    <?php
                endif;
                ?>
            </div>
        </div>
    </section>

    <!-- About Section -->
    <section class="about-section">
        <div class="container">
            <div class="about-content">
                <h1>RoliaScan – An Online Comic Library for Every Reader</h1>
                
                <div class="intro-text">
                    <p>RoliaScan brings you a fast, smooth, and friendly online reading experience. Whether you enjoy dramatic manhwa, classic manhua, iconic manga, or emotional romance comics, RoliaScan always has something that fits your mood and lets you "chill" anytime.</p>
                    
                    <p>With a modern interface, optimized loading speed, and a rich comic library, the platform has become a familiar destination for comic lovers.</p>
                </div>

                <div class="feature-image">
                    <img src="<?php echo get_template_directory_uri(); ?>/assets/images/roliascan-hero.jpg" alt="RoliaScan Platform">
                </div>

                <h2>Why do readers love RoliaScan?</h2>

                <div class="features-grid">
                    <div class="feature-item">
                        <h3>A rich library updated daily</h3>
                        <p>RoliaScan offers a diverse collection of manhwa, manhua, and manga, featuring thousands of popular titles loved by the community. New chapters are added every day, ensuring you never miss an update from your favorite series.</p>
                    </div>

                    <div class="feature-item">
                        <h3>Seamless reading from the first chapter to the last</h3>
                        <p>Each chapter page is optimized for smooth scrolling and fast chapter transitions. With crisp, full-HD image quality, you can enjoy every panel without interruptions or distractions.</p>
                    </div>

                    <div class="feature-item">
                        <h3>A responsive interface for every screen size</h3>
                        <p>Whether you're reading on a phone, tablet, or laptop, RoliaScan automatically adjusts the layout for the best display. No broken frames, no manual zooming — everything is designed to be visually clear and easy to use.</p>
                    </div>

                    <div class="feature-item">
                        <h3>A lively community for trends & discussion</h3>
                        <p>RoliaScan is more than a reading platform — it's a space to share emotions. You can comment, discuss, and catch trends with other readers, making the reading experience more engaging and connected.</p>
                    </div>
                </div>

                <h2>Most popular comic genres on RoliaScan</h2>
                
                <div class="genres-content">
                    <p>RoliaScan caters to many preferences, especially Gen Z and readers who enjoy light yet engaging entertainment.</p>
                    
                    <p>Some of the most-read genres include:</p>
                    
                    <ul class="genre-list">
                        <li><strong>Korean Manhwa:</strong> Vibrant art, gripping drama, modern storytelling.</li>
                        <li><strong>Chinese Manhua:</strong> Historical, xianxia, palace intrigue, and rich Asian-inspired worlds.</li>
                        <li><strong>Japanese Manga:</strong> Classics with depth, variety, and timeless appeal.</li>
                        <li><strong>Romance:</strong> Sweet, healing, emotional stories.</li>
                        <li><strong>Isekai & Fantasy:</strong> Constant plot twists and captivating journeys of transformation.</li>
                    </ul>
                    
                    <p>Each genre includes a large collection of titles, updated frequently for endless exploration.</p>
                </div>

                <div class="feature-image">
                    <img src="<?php echo get_template_directory_uri(); ?>/assets/images/roliascan-genres.jpg" alt="RoliaScan Genres">
                </div>

                <h3>Exclusive Experiences Only on RoliaScan</h3>
                
                <div class="exclusive-features">
                    <p>RoliaScan aims to create a "just open and read" feeling by removing barriers that disrupt enjoyment.</p>
                    
                    <p>You get:</p>
                    
                    <ul class="benefits-list">
                        <li>Fast loading speed, even with weak internet</li>
                        <li>Sharp full-HD visuals with no image distortion</li>
                        <li>Smart recommendations based on your preferences</li>
                        <li>Follow lists and instant notifications for new chapters</li>
                    </ul>
                    
                    <p>These features make RoliaScan a go-to choice for readers who value convenience, smooth performance, and personalization.</p>
                </div>

                <h2>How RoliaScan Stands Out from Other Comic Websites</h2>
                
                <div class="standout-content">
                    <p>RoliaScan prioritizes user experience with fast loading and a smooth interface, allowing you to read continuously without interruptions. Content displays clearly with a tidy layout optimized for mobile users — something many platforms struggle with.</p>
                    
                    <p>The platform also minimizes intrusive ads. No banners covering panels, no annoying pop-ups — just pure reading. This clean experience helps you stay focused and relaxed while enjoying your favorite stories.</p>
                    
                    <p>Lastly, RoliaScan fosters a lively comment community where readers can catch trends, discuss chapters, and interact with others. Its personalized recommendation system helps you discover new titles that match your taste, making the experience feel natural and friendly.</p>
                </div>

                <div class="feature-image">
                    <img src="<?php echo get_template_directory_uri(); ?>/assets/images/roliascan-online.jpg" alt="RoliaScan Online">
                </div>

                <h2>RoliaScan – The Ideal Destination for Comic Lovers</h2>
                
                <div class="conclusion">
                    <p>With a vast collection, smooth interface, and active community, RoliaScan is not just a reading site — it's an emotional space where you can unwind and get lost in new stories every day.</p>
                    
                    <p>If you're looking for a comic platform that's fast, clean, easy to use, and always updated, RoliaScan is the perfect choice.</p>
                </div>

                <h2>FAQs – RoliaScan</h2>
                
                <div class="faq-section">
                    <div class="faq-item">
                        <h3>Is RoliaScan free to use?</h3>
                        <p>Yes, RoliaScan is completely free to use. You can read all manga, manhwa, and manhua without any subscription fees.</p>
                    </div>
                    
                    <div class="faq-item">
                        <h3>Are new chapters updated regularly?</h3>
                        <p>Absolutely! We update new chapters daily to ensure you never miss out on your favorite series.</p>
                    </div>
                    
                    <div class="faq-item">
                        <h3>What genres are available on RoliaScan?</h3>
                        <p>RoliaScan offers a wide variety of genres including Romance, Fantasy, Action, Drama, Comedy, Isekai, Historical, and many more.</p>
                    </div>
                    
                    <div class="faq-item">
                        <h3>Does RoliaScan offer personalized recommendations?</h3>
                        <p>Yes! Our smart recommendation system suggests manga based on your reading history and preferences.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

</main>

<?php get_footer(); ?>
