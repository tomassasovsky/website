# Quick Start Guide 🚀

Get your portfolio up and running in 5 minutes!

## Prerequisites

- Node.js 18+ installed ([Download](https://nodejs.org/))
- A code editor (VS Code recommended)
- Your resume information ready

## Step 1: Install Dependencies ⚡

```bash
npm install
```

Wait for all packages to install (~2 minutes).

## Step 2: Start Development Server 🖥️

```bash
npm run dev
```

Your site will be live at: **http://localhost:4321**

## Step 3: Customize Your Content ✏️

### Quick Edits (5 minutes)

Open these files and replace placeholder text:

1. **`src/components/Hero.astro`**
   - Replace "Tomás Sasovsky" with YOUR NAME
   - Change tech stack pills to your technologies

2. **`src/components/Contact.astro`**
   - Replace "your.email@example.com" with YOUR EMAIL

3. **`src/components/Footer.astro`**
   - Update social links (GitHub, LinkedIn, Twitter)

### See Your Changes

Save the files and your browser will auto-refresh! ✨

## Step 4: Add Your Resume 📄

1. Put your resume PDF in the `public/` folder
2. Update the filename in:
   - `src/components/Hero.astro`
   - `src/components/Contact.astro`

## Step 5: Deploy 🌍

### Option A: Vercel (Recommended - Easiest)

1. Push code to GitHub
2. Go to [vercel.com](https://vercel.com)
3. Click "Import Project"
4. Select your repo
5. Click "Deploy" ✅

Done in 2 minutes!

### Option B: Netlify

1. Push code to GitHub
2. Go to [netlify.com](https://netlify.com)
3. Click "New site from Git"
4. Select your repo
5. Click "Deploy" ✅

## Next Steps

### Full Customization

For complete customization, see:
- **`CUSTOMIZATION.md`** - Detailed customization guide
- **`README.md`** - Full documentation

### What to Customize

- [ ] Work experience timeline
- [ ] Projects section with your projects
- [ ] Skills and technologies
- [ ] About section text
- [ ] Add project images
- [ ] Customize colors (tailwind.config.mjs)

## Common Commands

```bash
npm run dev      # Start development server
npm run build    # Build for production
npm run preview  # Preview production build
```

## Troubleshooting

### Port already in use
```bash
# Kill process on port 4321
# Windows:
netstat -ano | findstr :4321
taskkill /PID <PID> /F

# Mac/Linux:
lsof -ti:4321 | xargs kill -9
```

### Dependencies won't install
```bash
# Clear cache and reinstall
rm -rf node_modules package-lock.json
npm install
```

### Site won't build
```bash
# Check for errors
npm run build

# Common fixes:
# 1. Update Node.js to v18+
# 2. Delete .astro folder: rm -rf .astro
# 3. Reinstall dependencies
```

## Need Help?

1. Check the error message in terminal
2. Review `CUSTOMIZATION.md` for guidance
3. Check [Astro Docs](https://docs.astro.build)
4. Open an issue on GitHub

## Pro Tips 💡

1. **Save Often**: Changes auto-reload in dev mode
2. **Dark Mode**: Toggle theme in top-right corner
3. **Mobile View**: Test on mobile using browser dev tools (F12)
4. **Lighthouse**: Run Chrome Lighthouse for performance tips
5. **Git Commits**: Commit changes frequently as you customize

---

**You're all set! Now make it yours! 🎉**

Happy coding! 👨‍💻👩‍💻
