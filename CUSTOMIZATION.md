# Portfolio Customization Guide

This guide will help you customize your portfolio with your personal information from your resume.

## 📝 Step-by-Step Customization

### 1. Personal Information & Branding

#### Update Your Name & Initials
- **File**: `src/components/Hero.astro`
  - Line with `<span class="text-yellow-300">Tomás Sasovsky</span>` → Replace with your name
  - The `TS` initials in the profile circle → Replace with your initials

- **File**: `src/components/Header.astro`
  - The logo `TS` → Replace with your initials

- **File**: `src/components/Footer.astro`
  - `Tomás Sasovsky` → Replace with your name

- **File**: `src/pages/index.astro`
  - Page title → Update with your name

- **File**: `src/layouts/Layout.astro`
  - Meta author tag → Update with your name

### 2. Professional Summary & Tagline

#### Update Your Tagline
- **File**: `src/components/Hero.astro`
  - `"Building Seamless Mobile Apps & Scalable Backend Systems"` → Replace with your unique value proposition

#### Update Professional Summary
- **File**: `src/components/About.astro`
  - The paragraph in the glass-card → Replace with your professional summary from your resume

### 3. Skills & Technologies

#### Update Tech Stack Pills (Hero)
- **File**: `src/components/Hero.astro`
  - Update the tech stack pills with your primary skills:
    ```astro
    <span class="glass-card px-4 py-2 text-sm font-medium text-white">Your Tech</span>
    ```

#### Update Skills Categories (About)
- **File**: `src/components/About.astro`
  - **Mobile Development** section: Add/remove your mobile skills
  - **Backend Development** section: Add/remove your backend skills  
  - **DevOps & Database** section: Add/remove your DevOps/Database skills

### 4. Work Experience

#### Update Timeline
- **File**: `src/components/About.astro`
  - Find the "Experience Timeline" section
  - Replace the three experience items with your actual work history:
    ```astro
    <h4 class="text-xl font-bold mb-2">Your Job Title</h4>
    <p class="text-primary-600 dark:text-primary-400 font-semibold mb-3">Company Name</p>
    <p class="text-sm text-gray-600 dark:text-gray-400 mb-4">Start Year - End Year</p>
    <p class="text-gray-700 dark:text-gray-300">
      Your job description and achievements
    </p>
    ```

### 5. Projects

#### Add Your Projects
- **File**: `src/components/Projects.astro`
  - Update the `projects` array with your actual projects from your resume
  - Each project should include:
    ```javascript
    {
      id: 1,
      title: "Your Project Name",
      description: "Detailed description of the project",
      image: "/projects/project-image.jpg", // Add images to public/projects/
      tags: ["Tech1", "Tech2", "Tech3"],
      liveUrl: "https://your-live-project.com", // Optional
      githubUrl: "https://github.com/you/project", // Optional
      highlights: ["Key Achievement 1", "Key Achievement 2"]
    }
    ```

#### Add Project Images
1. Create folder: `public/projects/`
2. Add your project screenshots
3. Reference them in the projects array

### 6. Contact Information

#### Update Email
- **File**: `src/components/Contact.astro`
  - Find `your.email@example.com` (appears multiple times)
  - Replace with your actual email

- **File**: `src/components/Footer.astro`
  - Also update email here

#### Update Location
- **File**: `src/components/Contact.astro`
  - Find `Your City, Country`
  - Replace with your location

- **File**: `src/components/Footer.astro`
  - Also update location here

### 7. Social Media Links

Update these in **multiple files**:

#### Files to Update:
- `src/components/Contact.astro`
- `src/components/Footer.astro`
- `src/components/Projects.astro`

#### Links to Replace:
```astro
<!-- GitHub -->
https://github.com/tomassasovsky → https://github.com/YOUR_GITHUB

<!-- LinkedIn -->
https://linkedin.com/in/yourusername → https://linkedin.com/in/YOUR_LINKEDIN

<!-- Twitter/X -->
https://twitter.com/yourusername → https://twitter.com/YOUR_TWITTER
```

### 8. Resume PDF

1. **Replace the PDF**:
   - Remove: `public/Tomás Sasovsky - Resume.pdf`
   - Add your resume PDF to `public/` folder

2. **Update references** in these files:
   - `src/components/Hero.astro`
   - `src/components/Contact.astro`
   
   Change:
   ```astro
   href="/Tomás Sasovsky - Resume.pdf"
   ```
   To:
   ```astro
   href="/Your-Name-Resume.pdf"
   ```

### 9. SEO & Meta Tags

#### Update Meta Description
- **File**: `src/layouts/Layout.astro`
  - Update the default description with your own

#### Update Site URL
- **File**: `astro.config.mjs`
  - Change `site: 'https://yourdomain.com'` to your actual domain

### 10. Favicon

#### Option 1: Keep Current Gradient Design
- No changes needed! The `TS` will update when you change initials in the SVG

#### Option 2: Use Custom Favicon
1. Replace `public/favicon.svg` with your own favicon
2. Or add `public/favicon.ico` or `public/favicon.png`

## 🎨 Design Customization

### Change Color Scheme

**File**: `tailwind.config.mjs`

Update the color values:
```javascript
colors: {
  primary: {
    500: '#YOUR_COLOR', // Main brand color
    600: '#YOUR_COLOR',
    // ... other shades
  },
  accent: {
    500: '#YOUR_COLOR', // Accent color
    // ... other shades
  }
}
```

### Adjust Animations

**File**: `src/styles/global.css`
- Modify animation durations and effects
- Customize glass-card styles
- Adjust gradient animations

## ✅ Customization Checklist

Use this checklist to ensure you've personalized everything:

- [ ] Name in Hero section
- [ ] Initials in logo and profile
- [ ] Professional tagline
- [ ] Professional summary
- [ ] Tech stack pills
- [ ] Skills categories (all three)
- [ ] Work experience timeline
- [ ] Projects array with your projects
- [ ] Project images added to public/projects/
- [ ] Email address (all locations)
- [ ] Location (all locations)
- [ ] GitHub URL (all locations)
- [ ] LinkedIn URL (all locations)
- [ ] Twitter URL (all locations)
- [ ] Resume PDF file
- [ ] Resume PDF references in code
- [ ] Page title and meta tags
- [ ] Site URL in config
- [ ] Favicon (if custom)
- [ ] README with your info

## 🆘 Need Help?

If you get stuck:
1. Check the main README.md for setup instructions
2. Review the file structure in the project
3. Look for `TODO` or `UPDATE` comments in the code
4. Reach out for support

## 💡 Pro Tips

1. **Start Small**: Begin with just name, email, and one project
2. **Test Often**: Run `npm run dev` frequently to see changes
3. **Mobile First**: Always check mobile view
4. **Dark Mode**: Test both light and dark themes
5. **Performance**: Optimize images before adding them

---

**Happy Customizing! 🎉**
