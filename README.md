# Portfolio Website - Tomás Sasovsky

A modern, high-performance portfolio website built with Astro, Tailwind CSS, and featuring glassmorphism design. Showcasing mobile and backend development expertise.

## ✨ Features

- 🎨 **Modern Glassmorphism Design** - Stunning frosted glass effects with vibrant gradients
- 🌓 **Dark/Light Mode** - Theme toggle with localStorage persistence
- 📱 **Fully Responsive** - Optimized for all devices and screen sizes
- ⚡ **Lightning Fast** - Built with Astro for optimal performance
- ♿ **WCAG Compliant** - Accessible design with proper ARIA labels
- 🎭 **Smooth Animations** - Engaging hover effects and scroll-triggered transitions
- 📧 **Contact Form** - Netlify Forms integration for easy contact
- 🎯 **SEO Optimized** - Meta tags and semantic HTML for better search rankings

## 🚀 Project Structure

```
/
├── public/
│   ├── favicon.svg
│   └── Tomás Sasovsky - Resume.pdf
├── src/
│   ├── components/
│   │   ├── Header.astro
│   │   ├── Hero.astro
│   │   ├── About.astro
│   │   ├── Projects.astro
│   │   ├── Contact.astro
│   │   └── Footer.astro
│   ├── layouts/
│   │   └── Layout.astro
│   ├── pages/
│   │   └── index.astro
│   └── styles/
│       └── global.css
├── astro.config.mjs
├── tailwind.config.mjs
├── package.json
└── README.md
```

## 🛠️ Tech Stack

- **Framework**: [Astro](https://astro.build) - Modern static site generator
- **Styling**: [Tailwind CSS](https://tailwindcss.com) - Utility-first CSS framework
- **Content**: [MDX](https://mdxjs.com) - Markdown with JSX support
- **Deployment**: Vercel / Netlify ready

## 📋 Prerequisites

- Node.js 18.x or higher
- npm or yarn package manager

## 🏃‍♂️ Getting Started

### 1. Install Dependencies

```bash
npm install
```

### 2. Start Development Server

```bash
npm run dev
```

The site will be available at `http://localhost:4321`

### 3. Build for Production

```bash
npm run build
```

### 4. Preview Production Build

```bash
npm run preview
```

## 🎨 Customization Guide

### Update Personal Information

1. **Header & Hero Section** (`src/components/Hero.astro`)
   - Replace "Tomás Sasovsky" with your name
   - Update the tagline and description
   - Modify tech stack pills to match your skills

2. **About Section** (`src/components/About.astro`)
   - Update the professional summary
   - Customize skills in the three categories (Mobile, Backend, DevOps)
   - Edit work experience timeline with your jobs
   - Dates, company names, and descriptions

3. **Projects Section** (`src/components/Projects.astro`)
   - Update the `projects` array with your actual projects
   - Add project screenshots to `/public/projects/` folder
   - Include live URLs and GitHub links
   - Customize tech stack tags and highlights

4. **Contact Section** (`src/components/Contact.astro`)
   - Update email address in multiple places
   - Change location information
   - Update social media links (GitHub, LinkedIn, Twitter)

5. **Footer** (`src/components/Footer.astro`)
   - Update social links
   - Modify contact information

### Color Theme

Edit `tailwind.config.mjs` to customize the color palette:

```javascript
colors: {
  primary: {
    // Your custom primary colors
  },
  accent: {
    // Your custom accent colors
  }
}
```

### Add Project Images

1. Create a `projects` folder in the `public` directory
2. Add your project screenshots/images
3. Reference them in the projects array: `image: "/projects/your-image.jpg"`

### Resume PDF

1. Replace `public/Tomás Sasovsky - Resume.pdf` with your resume
2. Update the filename references in:
   - `src/components/Hero.astro`
   - `src/components/Contact.astro`

## 📧 Contact Form Setup

### For Netlify Deployment:

The contact form is pre-configured for Netlify Forms. Just deploy to Netlify and it will work automatically!

### For Other Platforms:

Replace the form implementation in `src/components/Contact.astro` with:
- [Formspree](https://formspree.io)
- [Form-Data](https://www.form-data.com)
- Or your preferred form service

## 🚀 Deployment

### Deploy to Vercel

1. Push your code to GitHub
2. Go to [Vercel](https://vercel.com)
3. Import your repository
4. Deploy!

Vercel will auto-detect Astro and configure everything.

### Deploy to Netlify

1. Push your code to GitHub
2. Go to [Netlify](https://netlify.com)
3. Click "New site from Git"
4. Select your repository
5. Build settings:
   - Build command: `npm run build`
   - Publish directory: `dist`
6. Deploy!

### Manual Deployment

Build the site and deploy the `dist` folder to any static hosting:

```bash
npm run build
# Upload the 'dist' folder to your hosting
```

## 📱 Browser Support

- Chrome (latest)
- Firefox (latest)
- Safari (latest)
- Edge (latest)
- Mobile browsers (iOS Safari, Chrome Mobile)

## ♿ Accessibility

This portfolio follows WCAG 2.1 AA standards:
- Semantic HTML structure
- ARIA labels for interactive elements
- Keyboard navigation support
- Sufficient color contrast ratios
- Screen reader friendly

## 📝 License

This project is open source and available under the [MIT License](LICENSE).

## 🤝 Contributing

Feel free to fork this project and customize it for your own portfolio!

## 📞 Support

If you have any questions or need help customizing, feel free to reach out:
- Email: your.email@example.com
- GitHub: [@yourusername](https://github.com/tomassasovsky)

## 🌟 Show Your Support

Give a ⭐️ if you like this project!

---

**Built with ❤️ using Astro and Tailwind CSS**
