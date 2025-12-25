<?php
/**
 * Template Name: About Us
 */

get_header(); ?>

<main id="main" class="site-main page-about">
    <div class="container">
        <article class="page-content">
            <header class="page-header">
                <h1>About RoliaScan</h1>
            </header>

            <div class="about-page-content">
                <section class="about-intro">
                    <h2>Welcome to RoliaScan</h2>
                    <p>RoliaScan is your premier destination for reading manga, manhwa, and manhua online. We are dedicated to providing readers with a fast, smooth, and enjoyable reading experience.</p>
                    <p>Our platform was created by manga enthusiasts, for manga enthusiasts. We understand what readers need and continuously work to improve our service.</p>
                </section>

                <section class="our-mission">
                    <h2>Our Mission</h2>
                    <p>Our mission is to make quality manga accessible to everyone, anywhere, anytime. We believe that everyone deserves access to great stories, and we work tirelessly to bring you the best content from around the world.</p>
                </section>

                <section class="our-values">
                    <h2>Our Values</h2>
                    <div class="values-grid">
                        <div class="value-item">
                            <h3>Quality First</h3>
                            <p>We prioritize high-quality images and translations to ensure the best reading experience.</p>
                        </div>
                        <div class="value-item">
                            <h3>User Experience</h3>
                            <p>Fast loading, clean interface, and mobile-optimized design are at the core of what we do.</p>
                        </div>
                        <div class="value-item">
                            <h3>Community</h3>
                            <p>We foster a welcoming community where readers can discuss and share their passion for manga.</p>
                        </div>
                        <div class="value-item">
                            <h3>Innovation</h3>
                            <p>We constantly innovate to bring new features and improvements to our platform.</p>
                        </div>
                    </div>
                </section>

                <section class="our-team">
                    <h2>Our Team</h2>
                    <p>RoliaScan is maintained by a passionate team of developers, designers, and manga enthusiasts who work around the clock to bring you the best manga reading experience.</p>
                </section>

                <section class="contact-info">
                    <h2>Get in Touch</h2>
                    <p>Have questions or suggestions? We'd love to hear from you! Feel free to <a href="<?php echo esc_url(home_url('/contact-us/')); ?>">contact us</a>.</p>
                </section>
            </div>
        </article>
    </div>
</main>

<?php get_footer(); ?>
