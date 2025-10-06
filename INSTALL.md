# 📦 Installation & Setup Instructions

Complete guide to get your portfolio running locally.

## ✅ System Requirements

Before starting, ensure you have:
- **Node.js** version 18.x or higher ([Download](https://nodejs.org/))
- **npm** (comes with Node.js) or **yarn**
- **Git** (optional, for version control)
- A modern web browser (Chrome, Firefox, Safari, Edge)
- Code editor (VS Code recommended)

### Check Your Node Version

```bash
node --version
# Should show v18.0.0 or higher

npm --version
# Should show 8.0.0 or higher
```

If your Node version is too old, download the latest LTS version from [nodejs.org](https://nodejs.org/).

---

## 🚀 Installation Steps

### Step 1: Navigate to Project Directory

```bash
cd portfolio
```

### Step 2: Install Dependencies

This will download all required packages (Astro, Tailwind CSS, etc.):

```bash
npm install
```

**Expected output:**
```
added 250 packages, and audited 251 packages in 45s

50 packages are looking for funding
  run `npm fund` for details

found 0 vulnerabilities
```

**Installation time:** ~1-2 minutes (depending on internet speed)

### Step 3: Verify Installation

Check that everything installed correctly:

```bash
npm list --depth=0
```

You should see:
- `astro@4.3.2` (or similar)
- `tailwindcss@3.4.1`
- `@astrojs/mdx`
- `@astrojs/tailwind`

---

## 🏃 Running the Development Server

### Start the Dev Server

```bash
npm run dev
```

**Expected output:**
```
🚀 astro dev

  Local:    http://localhost:4321/
  Network:  use --host to expose

watching for file changes...
```

### Open Your Browser

Navigate to: **http://localhost:4321**

You should see your portfolio homepage with:
- Animated gradient background
- Your name and title
- Navigation header
- All sections

### Hot Reload

As you edit files, changes will automatically refresh in your browser! ✨

---

## 🛠️ Development Commands

### Start Development Server
```bash
npm run dev
```
- Starts local server at `http://localhost:4321`
- Hot module replacement enabled
- Best for development

### Build for Production
```bash
npm run build
```
- Creates optimized production build
- Output folder: `dist/`
- Minifies CSS and JavaScript
- Optimizes images

### Preview Production Build
```bash
npm run preview
```
- Previews production build locally
- Serves the `dist/` folder
- Use before deploying

### Type Check
```bash
npm run astro check
```
- Checks TypeScript errors
- Validates Astro components
- Run before deployment

---

## 🔧 Troubleshooting

### Problem: Port 4321 is already in use

**Solution:**

**Windows:**
```bash
# Find process using port 4321
netstat -ano | findstr :4321

# Kill the process (replace <PID> with actual number)
taskkill /PID <PID> /F
```

**Mac/Linux:**
```bash
# Find and kill process
lsof -ti:4321 | xargs kill -9
```

**Alternative:** Use a different port
```bash
npm run dev -- --port 3000
```

---

### Problem: Dependencies won't install

**Solution 1:** Clear npm cache
```bash
npm cache clean --force
rm -rf node_modules package-lock.json
npm install
```

**Solution 2:** Use specific Node version
```bash
# Install nvm (Node Version Manager)
# Then use Node 18
nvm install 18
nvm use 18
npm install
```

---

### Problem: "Cannot find module" errors

**Solution:**
```bash
# Reinstall dependencies
rm -rf node_modules
npm install

# Clear Astro cache
rm -rf .astro
npm run dev
```

---

### Problem: Build fails with TypeScript errors

**Solution:**
```bash
# Check for errors
npm run astro check

# If errors are in Astro files, check syntax
# If errors persist, try:
rm -rf .astro dist
npm run build
```

---

### Problem: Styles not loading

**Solution:**
```bash
# Restart dev server
# Ctrl+C to stop, then:
npm run dev

# If still not working:
rm -rf .astro
npm run dev
```

---

## 📝 VS Code Setup (Recommended)

### Install Recommended Extensions

Open VS Code in the project folder:
```bash
code .
```

VS Code will prompt to install recommended extensions:
1. **Astro** - Syntax highlighting and IntelliSense
2. **Tailwind CSS IntelliSense** - Autocomplete for Tailwind classes
3. **Prettier** - Code formatting

Or install manually:
- Press `Ctrl+Shift+X` (Windows/Linux) or `Cmd+Shift+X` (Mac)
- Search for: "Astro", "Tailwind CSS IntelliSense", "Prettier"
- Click "Install"

### Format on Save

Settings are already configured in `.vscode/settings.json`!
- Files auto-format when you save
- Consistent code style

---

## 🎯 First Time Setup Checklist

After installation, verify everything works:

- [ ] Node.js 18+ installed
- [ ] Dependencies installed (`npm install`)
- [ ] Dev server starts (`npm run dev`)
- [ ] Site loads at `http://localhost:4321`
- [ ] Hot reload works (edit a file, see changes)
- [ ] Dark/light mode toggle works
- [ ] Navigation links work
- [ ] Mobile menu works (resize browser)
- [ ] Contact form displays correctly
- [ ] VS Code extensions installed (optional)

---

## 📊 Expected File Sizes

After installation:
```
node_modules/     ~150 MB
.astro/           ~10 MB (generated on first run)
dist/             ~2 MB (after build)
```

---

## 🌐 Network Access

To access from other devices on your network:

```bash
npm run dev -- --host
```

Then visit `http://YOUR_IP:4321` from another device.

**Find your IP:**
- **Windows:** `ipconfig`
- **Mac/Linux:** `ifconfig` or `ip addr`

---

## 🔐 Environment Variables (Optional)

If you want to use environment variables:

1. Copy `.env.example` to `.env`:
   ```bash
   cp .env.example .env
   ```

2. Edit `.env` with your values:
   ```
   PUBLIC_SITE_URL=https://yourdomain.com
   PUBLIC_EMAIL=your@email.com
   ```

3. Access in code:
   ```javascript
   import.meta.env.PUBLIC_SITE_URL
   ```

---

## 🎨 Customization Start Points

After installation, start customizing:

1. **Update personal info** in `src/components/Hero.astro`
2. **Update projects** in `src/components/Projects.astro`
3. **Update experience** in `src/components/About.astro`
4. **Update contact info** in `src/components/Contact.astro`

See `CUSTOMIZATION.md` for detailed guide!

---

## 📞 Need Help?

If you encounter issues:

1. **Check this guide** - Most issues covered here
2. **Read error messages** - They often tell you what's wrong
3. **Check Node version** - Must be 18+
4. **Try clean install** - Delete `node_modules` and reinstall
5. **Check Astro docs** - [docs.astro.build](https://docs.astro.build)
6. **Check Tailwind docs** - [tailwindcss.com](https://tailwindcss.com)

---

## ✅ Installation Complete!

Your portfolio is now ready for development! 🎉

**Next Steps:**
1. Read `QUICKSTART.md` for 5-minute customization
2. Read `CUSTOMIZATION.md` for detailed customization
3. Read `README.md` for deployment instructions

**Happy coding!** 👨‍💻👩‍💻
