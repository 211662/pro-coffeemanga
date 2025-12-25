<?php
/**
 * Template Name: Contact Us
 */

get_header(); ?>

<main id="main" class="site-main page-contact">
    <div class="container">
        <article class="page-content">
            <header class="page-header">
                <h1>Contact Us</h1>
            </header>

            <div class="contact-page-content">
                <section class="contact-intro">
                    <p>We'd love to hear from you! Whether you have questions, feedback, or suggestions, feel free to reach out to us.</p>
                </section>

                <div class="contact-wrapper">
                    <section class="contact-form-section">
                        <h2>Send us a Message</h2>
                        <form class="contact-form" method="post" action="<?php echo esc_url(admin_url('admin-post.php')); ?>">
                            <input type="hidden" name="action" value="roliascan_contact_form">
                            <?php wp_nonce_field('roliascan_contact_nonce', 'contact_nonce'); ?>
                            
                            <div class="form-group">
                                <label for="contact-name">Your Name *</label>
                                <input type="text" id="contact-name" name="contact_name" required>
                            </div>

                            <div class="form-group">
                                <label for="contact-email">Your Email *</label>
                                <input type="email" id="contact-email" name="contact_email" required>
                            </div>

                            <div class="form-group">
                                <label for="contact-subject">Subject *</label>
                                <input type="text" id="contact-subject" name="contact_subject" required>
                            </div>

                            <div class="form-group">
                                <label for="contact-message">Message *</label>
                                <textarea id="contact-message" name="contact_message" rows="6" required></textarea>
                            </div>

                            <button type="submit" class="submit-button">Send Message</button>
                        </form>
                    </section>

                    <section class="contact-info-section">
                        <h2>Contact Information</h2>
                        
                        <div class="contact-info-item">
                            <h3>Email</h3>
                            <p><a href="mailto:contact@roliascan.com">contact@roliascan.com</a></p>
                        </div>

                        <div class="contact-info-item">
                            <h3>Follow Us</h3>
                            <div class="social-links-contact">
                                <a href="#" class="social-link">Facebook</a>
                                <a href="#" class="social-link">Instagram</a>
                                <a href="#" class="social-link">Twitter</a>
                            </div>
                        </div>

                        <div class="contact-info-item">
                            <h3>Business Hours</h3>
                            <p>We respond to inquiries within 24-48 hours</p>
                        </div>
                    </section>
                </div>
            </div>
        </article>
    </div>
</main>

<?php get_footer(); ?>
