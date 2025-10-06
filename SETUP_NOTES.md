# Setup Notes

## Resume PDF

**Important**: Your resume PDF needs to be copied to the `public/` folder.

### Manual Step Required:

1. Copy your file `Tomás Sasovsky - Resume.pdf` to the `public/` folder
2. Or rename it to something simpler like `resume.pdf`
3. Update the references in the code:
   - `src/components/Hero.astro` (line with Download Resume button)
   - `src/components/Contact.astro` (line with Download Resume button)

### Why?

The filename contains special characters (á) that need to be handled carefully. You can either:

**Option A**: Keep the original name
- Just copy/move it to `public/` folder manually
- The references in the code already use the correct name

**Option B**: Rename to simpler filename
- Rename to `resume.pdf` or `YourName-Resume.pdf`
- Update both Hero.astro and Contact.astro files to match the new filename

## What's Next?

1. ✅ Project structure is created
2. ✅ All components are built
3. ✅ Styling is configured
4. ⏳ Copy resume to public/ folder (manual step)
5. ⏳ Install dependencies: `npm install`
6. ⏳ Start dev server: `npm run dev`
7. ⏳ Customize content with your information

See `QUICKSTART.md` for step-by-step instructions!

## File Structure Created

```
portfolio/
├── .vscode/                  # VS Code settings
├── public/                   # Static assets
│   ├── favicon.svg          # Site icon (with TS logo)
│   └── [YOUR RESUME].pdf    # Add your resume here
├── src/
│   ├── components/          # Reusable components
│   │   ├── Header.astro     # Navigation header
│   │   ├── Hero.astro       # Landing section
│   │   ├── About.astro      # About & skills section
│   │   ├── Projects.astro   # Projects showcase
│   │   ├── Contact.astro    # Contact form
│   │   └── Footer.astro     # Footer
│   ├── layouts/
│   │   └── Layout.astro     # Base layout
│   ├── pages/
│   │   └── index.astro      # Main page
│   └── styles/
│       └── global.css       # Global styles & animations
├── astro.config.mjs         # Astro configuration
├── tailwind.config.mjs      # Tailwind configuration
├── package.json             # Dependencies
├── README.md                # Full documentation
├── CUSTOMIZATION.md         # Detailed customization guide
├── QUICKSTART.md            # Quick start guide
├── LICENSE                  # MIT License
└── netlify.toml            # Netlify deployment config
└── vercel.json             # Vercel deployment config
```

## Features Included

✅ Glassmorphism design with gradient effects
✅ Dark/Light mode toggle with localStorage persistence
✅ Fully responsive (mobile, tablet, desktop)
✅ Smooth animations and transitions
✅ SEO optimized with meta tags
✅ WCAG accessibility compliant
✅ Contact form with Netlify Forms integration
✅ Project showcase with hover effects
✅ Skills timeline visualization
✅ Social media integration
✅ Fast loading with Astro optimization

## Ready to Deploy

Your site is ready to deploy to:
- ✅ Vercel (vercel.json configured)
- ✅ Netlify (netlify.toml configured)
- ✅ Any static hosting (just upload the dist/ folder after building)

---

**Happy Building! 🚀**
