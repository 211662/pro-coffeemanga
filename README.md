# RoliaScan - WordPress Theme

A modern, responsive WordPress theme for manga, manhwa, and manhua reading platform. This theme is designed to provide a fast, clean, and user-friendly experience for comic readers.

## Features

- 📚 **Custom Post Type for Manga** - Dedicated manga content management
- 🎨 **Modern & Clean Design** - Beautiful, minimalist interface
- 📱 **Fully Responsive** - Optimized for all devices (mobile, tablet, desktop)
- ⚡ **Fast Loading** - Optimized performance with minimal load times
- 🎯 **SEO Friendly** - Built with SEO best practices
- 🔖 **Genre Taxonomy** - Easy content categorization
- 💬 **Community Features** - Comments and discussion support
- 🌐 **Translation Ready** - i18n support for multiple languages

## Requirements

- WordPress 5.0 or higher
- PHP 7.4 or higher
- MySQL 5.6 or higher

## Installation

### Method 1: Upload via WordPress Admin

1. Download the theme as a ZIP file
2. Log in to your WordPress admin panel
3. Navigate to **Appearance > Themes**
4. Click **Add New** > **Upload Theme**
5. Choose the downloaded ZIP file and click **Install Now**
6. Once installed, click **Activate**

### Method 2: Manual Installation

1. Download the theme files
2. Extract the ZIP file
3. Upload the `roliascan` folder to `/wp-content/themes/` directory via FTP
4. Log in to your WordPress admin panel
5. Navigate to **Appearance > Themes**
6. Find **RoliaScan** and click **Activate**

## Setup Guide

### Step 1: Basic Configuration

After activating the theme:

1. Go to **Settings > Permalinks** and select **Post name** structure
2. Go to **Appearance > Customize** to set up:
   - Site Logo
   - Site Title and Tagline
   - Colors (optional)

### Step 2: Create Menus

1. Navigate to **Appearance > Menus**
2. Create a new menu called "Primary Menu"
3. Add pages/links to the menu
4. Assign it to the "Primary Menu" location
5. Create another menu called "Footer Menu" for footer links
6. Assign it to the "Footer Menu" location

### Step 3: Create Pages

Create the following pages using the appropriate templates:

#### About Us Page
1. Go to **Pages > Add New**
2. Title: "About Us"
3. Select Template: **About Us** from the Page Attributes
4. Publish

#### Contact Us Page
1. Go to **Pages > Add New**
2. Title: "Contact Us"
3. Select Template: **Contact Us**
4. Publish

#### Privacy Policy Page
1. Go to **Pages > Add New**
2. Title: "Privacy Policy"
3. Select Template: **Privacy Policy**
4. Publish

#### Terms and Conditions Page
1. Go to **Pages > Add New**
2. Title: "Terms and Conditions"
3. Select Template: **Terms and Conditions**
4. Publish

### Step 4: Add Manga Content

1. Go to **Manga > Add New** in your admin panel
2. Add manga title, description, and featured image
3. Assign genres from the Genre taxonomy
4. Add custom fields:
   - `manga_author` - Author name
   - `manga_status` - Status (Ongoing/Completed)
5. Publish

### Step 5: Add Genres

1. Navigate to **Manga > Genres**
2. Add popular genres like:
   - Romance
   - Fantasy
   - Action
   - Drama
   - Comedy
   - Isekai
   - Historical
   - Slice of Life

## Theme Structure

```
roliascan/
├── assets/
│   ├── css/
│   │   └── main.css          # Main stylesheet
│   ├── js/
│   │   └── main.js           # JavaScript functionality
│   └── images/               # Theme images
├── functions.php             # Theme functions
├── style.css                 # Theme info and CSS import
├── header.php                # Header template
├── footer.php                # Footer template
├── index.php                 # Default template
├── front-page.php            # Homepage template
├── page.php                  # Page template
├── single-manga.php          # Single manga template
├── template-about.php        # About Us template
├── template-contact.php      # Contact Us template
├── template-privacy.php      # Privacy Policy template
├── template-terms.php        # Terms & Conditions template
└── README.md                 # This file
```

## Customization

### Colors

The theme uses CSS variables for easy color customization. Edit `/assets/css/main.css`:

```css
:root {
    --primary-color: #1a1a2e;      /* Main dark color */
    --secondary-color: #16213e;     /* Secondary dark color */
    --accent-color: #0f3460;        /* Accent color */
    --highlight-color: #e94560;     /* Highlight/CTA color */
    --text-color: #eaeaea;          /* Light text color */
    --text-dark: #333;              /* Dark text color */
}
```

### Adding Custom Features

To add custom functionality, edit `functions.php`. The theme already includes:

- Custom post type (Manga)
- Custom taxonomy (Genre)
- Widget areas
- Navigation menus
- Theme support features

## Recommended Plugins

For enhanced functionality, consider installing:

- **Contact Form 7** - For advanced contact forms
- **Yoast SEO** - For better SEO optimization
- **WP Super Cache** - For caching and faster loading
- **Advanced Custom Fields** - For additional manga metadata
- **Akismet** - For spam protection

## Support

For support, questions, or feature requests:

- Email: support@roliascan.com
- Website: https://www.roliascan.com/

## Changelog

### Version 1.0.0 (December 2025)
- Initial release
- Custom manga post type
- Genre taxonomy
- Responsive design
- Homepage with manga updates
- Static page templates
- Mobile-optimized interface

## Credits

- Developed by: RoliaScan Team
- License: GPL v2 or later
- License URI: http://www.gnu.org/licenses/gpl-2.0.html

## License

This theme is licensed under the GPL v2 or later.

Copyright (C) 2025 RoliaScan Inc. All rights reserved.

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

---

**Note:** This theme is a clone inspired by CoffeeManga, customized with the RoliaScan branding. All "CoffeeManga" references have been replaced with "RoliaScan" throughout the theme.
