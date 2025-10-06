# 🎨 Visual Design Preview

This document describes what your portfolio will look like when deployed.

## 🌈 Color Palette

### Light Mode
```
Background:     #FFFFFF (Pure White)
Surface:        #F9FAFB (Gray-50)
Text Primary:   #111827 (Gray-900)
Text Secondary: #6B7280 (Gray-600)
Primary Blue:   #0EA5E9 (Sky-500)
Accent Purple:  #8B5CF6 (Violet-500)
```

### Dark Mode
```
Background:     #030712 (Gray-950)
Surface:        #111827 (Gray-900)
Text Primary:   #F9FAFB (Gray-100)
Text Secondary: #9CA3AF (Gray-400)
Primary Blue:   #38BDF8 (Sky-400)
Accent Purple:  #A78BFA (Violet-400)
```

## 📱 Section-by-Section Visual Description

### 1. Hero Section (Landing)

**Visual Effect:**
- Full-height section filling the entire viewport
- Animated gradient background (blue → purple) that slowly shifts
- Floating white particles drifting across the screen
- Semi-transparent frosted glass overlay

**Content Layout (Center-aligned):**
```
        ╔════════════════════╗
        ║  Circular Avatar   ║
        ║   with gradient    ║
        ║   border & "TS"    ║
        ║   (floating up     ║
        ║    and down)       ║
        ╚════════════════════╝

     Hi, I'm Tomás Sasovsky
   (Large, bold, white text)

    Full-Stack Developer
   (Medium, white text)

  Building Seamless Mobile Apps &
     Scalable Backend Systems
   (Larger, semi-transparent white)

┌──────────────────────────────────┐
│  Flutter  │  Swift  │  Kotlin │
│  Node.js  │  Python  │  Docker    │
└──────────────────────────────────┘
   (Frosted glass pills)

 ┌──────────────────┐  ┌──────────────┐
 │ Explore Projects │  │ Download CV  │
 │  (gradient btn)  │  │ (glass btn)  │
 └──────────────────┘  └──────────────┘

            ↓ Scroll Down
         (bouncing arrow)
```

**Animation Details:**
- Background gradient slowly animates (8s loop)
- Avatar floats up and down (6s ease-in-out)
- Particles drift diagonally
- Buttons scale up on hover
- Scroll arrow bounces continuously

---

### 2. About Section

**Background:** Light gray (light mode) / Dark gray (dark mode)

**Layout:**
```
         ╔═══════════════════╗
         ║    About Me       ║
         ║   ─────────       ║
         ╚═══════════════════╝

┌────────────────────────────────────────┐
│                                        │
│  Professional summary text in a        │
│  large frosted glass card with         │
│  slight shadow and rounded corners     │
│                                        │
└────────────────────────────────────────┘

         Technical Skills
         ─────────────

┌──────────────┐ ┌──────────────┐ ┌──────────────┐
│  📱 Mobile   │ │  🖥️ Backend  │ │  ⚙️ DevOps   │
│              │ │              │ │              │
│ Flutter │ │ Node.js      │ │ Docker       │
│ Swift (iOS)  │ │ Python       │ │ Kubernetes   │
│ Kotlin       │ │ REST APIs    │ │ MongoDB      │
│ Flutter      │ │ GraphQL      │ │ PostgreSQL   │
│ Mobile UI/UX │ │ Microservice │ │ CI/CD        │
└──────────────┘ └──────────────┘ └──────────────┘
  (glass cards that scale up on hover)

         Work Experience
         ───────────────

    ● ─────────────────────────────
    │  ┌──────────────────────────┐
    │  │ Senior Mobile Developer  │
    │  │ Tech Company Inc.        │
    │  │ 2022 - Present           │
    │  │                          │
    │  │ Description...           │
    │  └──────────────────────────┘
    │
    ● ─────────────────────────────
    │  ┌──────────────────────────┐
    │  │ Backend Developer        │
    │  │ StartUp Solutions        │
    │  │ 2020 - 2022              │
    │  │                          │
    │  │ Description...           │
    │  └──────────────────────────┘
    │
    ● ─────────────────────────────
       ┌──────────────────────────┐
       │ Full Stack Developer     │
       │ Digital Agency           │
       │ 2018 - 2020              │
       │                          │
       │ Description...           │
       └──────────────────────────┘

  (Vertical timeline with alternating cards)
  (Gradient line connecting the dots)
```

**Visual Effects:**
- Skill cards lift up and grow on hover
- Timeline items have staggered entrance
- Glass morphism on all cards
- Smooth color transitions

---

### 3. Projects Section

**Background:** White (light mode) / Very dark (dark mode)

**Layout:**
```
       ╔════════════════════════╗
       ║  Featured Projects     ║
       ║  ──────────────        ║
       ╚════════════════════════╝

   A showcase of mobile apps and
   backend systems I've built...

Grid Layout (3 columns on desktop, 1 on mobile):

┌────────────┐ ┌────────────┐ ┌────────────┐
│  📱        │ │  📱        │ │  📱        │
│  [Image]   │ │  [Image]   │ │  [Image]   │
│            │ │            │ │            │
├────────────┤ ├────────────┤ ├────────────┤
│ Project 1  │ │ Project 2  │ │ Project 3  │
│            │ │            │ │            │
│ Description│ │ Description│ │ Description│
│            │ │            │ │            │
│ ● ● ●      │ │ ● ● ●      │ │ ● ● ●      │
│ Highlights │ │ Highlights │ │ Highlights │
│            │ │            │ │            │
│ [Tag] [Tag]│ │ [Tag] [Tag]│ │ [Tag] [Tag]│
└────────────┘ └────────────┘ └────────────┘

┌────────────┐ ┌────────────┐ ┌────────────┐
│ Project 4  │ │ Project 5  │ │ Project 6  │
│ ...        │ │ ...        │ │ ...        │
└────────────┘ └────────────┘ └────────────┘

         ┌────────────────────┐
         │ View More on GitHub│
         └────────────────────┘
```

**Hover Effects:**
- Card scales up (105%)
- Shadow intensifies
- Image overlay appears with action buttons
  - 🔗 View Live (if available)
  - 💻 View Code (GitHub)
- Smooth 300ms transition

**Visual Details:**
- Gradient placeholder for images
- Glassmorphic cards
- Tech stack badges with rounded corners
- Highlight pills with accent colors

---

### 4. Contact Section

**Background:** Light gray (light mode) / Dark gray (dark mode)

**Layout (Two columns on desktop):**
```
       ╔════════════════════════╗
       ║   Get In Touch         ║
       ║   ──────────           ║
       ╚════════════════════════╝

   Have a project in mind or
   want to collaborate?

┌─────────────────────┐  ┌───────────────────┐
│  Contact Form       │  │  Contact Info     │
│  ───────────        │  │  ────────────     │
│                     │  │                   │
│  Name *             │  │  ┌──────────────┐ │
│  [____________]     │  │  │  📧 Email    │ │
│                     │  │  │  your@email  │ │
│  Email *            │  │  └──────────────┘ │
│  [____________]     │  │                   │
│                     │  │  ┌──────────────┐ │
│  Subject            │  │  │  📍 Location │ │
│  [____________]     │  │  │  City, State │ │
│                     │  │  └──────────────┘ │
│  Message *          │  │                   │
│  [____________]     │  │  Connect With Me  │
│  [____________]     │  │  ──────────────   │
│  [____________]     │  │                   │
│  [____________]     │  │  ┌───┐ ┌───┐ ┌───┐│
│                     │  │  │ G │ │ L │ │ T ││
│  ┌────────────┐    │  │  └───┘ └───┘ └───┘│
│  │ Send Msg   │    │  │  (GitHub, LinkedIn,│
│  │ (gradient) │    │  │   Twitter icons)   │
│  └────────────┘    │  │                   │
│                     │  │  ┌──────────────┐ │
│                     │  │  │ Download CV  │ │
│                     │  │  └──────────────┘ │
└─────────────────────┘  └───────────────────┘
       (glass cards)
```

**Interactive Elements:**
- Form fields have focus glow effect
- Contact info cards lift on hover
- Social icons rotate and change color on hover
- Submit button has ripple effect

---

### 5. Header (Fixed, Top)

**Appearance:**
```
┌─────────────────────────────────────────────┐
│  TS  │  Home  About  Projects  Contact  │ 🌙 │
│      │                                   │ ☀️ │
└─────────────────────────────────────────────┘
```

**States:**
- **Transparent** when at top of page
- **Frosted glass** when scrolled
- **Mobile**: Hamburger menu appears

**Theme Toggle:**
- Moon icon in dark mode
- Sun icon in light mode
- Smooth transition between themes

---

### 6. Footer

**Background:** Very dark gray (#111827)
**Text:** White/gray

**Layout (3 columns):**
```
┌────────────────────────────────────────────────┐
│                                                │
│  TS                    Quick Links             │
│  Tomás Sasovsky        • Home                  │
│  Mobile & Backend      • About                 │
│  Developer...          • Projects              │
│                        • Contact               │
│  [G] [L] [T]                                   │
│                        Get In Touch            │
│                        📧 email@example.com    │
│                        📍 City, Country        │
│                                                │
├────────────────────────────────────────────────┤
│  © 2025 Tomás Sasovsky. All rights reserved.  │
│                                                │
│  Built with ❤️ using Astro                     │
└────────────────────────────────────────────────┘
```

---

## 🎭 Animation Summary

### On Page Load
1. Hero section fades in
2. Avatar floats into view
3. Text appears with slight delay
4. Buttons slide up

### On Scroll
1. Sections fade in when 50% visible
2. Timeline items appear sequentially
3. Project cards stagger in
4. Smooth transitions throughout

### On Hover
1. **Buttons**: Scale up, shadow increases
2. **Cards**: Lift (translateY) and scale
3. **Links**: Color change, underline animation
4. **Images**: Overlay appears with buttons
5. **Social Icons**: Rotate and color shift

### Continuous
1. Background gradient animation
2. Particle floating
3. Avatar floating
4. Scroll indicator bouncing

---

## 📐 Responsive Breakpoints

### Mobile (< 768px)
- Single column layout
- Stacked sections
- Larger touch targets
- Simplified animations
- Hamburger menu

### Tablet (768px - 1024px)
- Two-column grids
- Adjusted spacing
- Full animations

### Desktop (> 1024px)
- Three-column grids
- Maximum width container
- Full feature set
- Optimal spacing

---

## 🎨 Design Philosophy

**Modern & Professional**
- Clean lines and clear hierarchy
- Generous white space
- Consistent spacing (Tailwind scale)

**Engaging but Not Distracting**
- Subtle animations
- Smooth transitions
- Purpose-driven motion

**Accessible & Inclusive**
- High contrast ratios
- Clear focus indicators
- Keyboard navigable
- Screen reader friendly

**Performance First**
- CSS animations (GPU accelerated)
- Lazy loading ready
- Optimized images
- Minimal JavaScript

---

## 🌟 Unique Visual Elements

1. **Animated Gradient Background** - Not static, always subtle movement
2. **Floating Particles** - Creates depth and interest
3. **Glassmorphism** - Modern frosted glass effect throughout
4. **Timeline Visualization** - Professional experience timeline
5. **Hover Overlays** - Project cards reveal actions on hover
6. **Smooth Theme Toggle** - Seamless dark/light mode transition
7. **Staggered Animations** - Elements don't all appear at once
8. **Gradient Text** - Eye-catching headings with gradients

---

## 💡 First Impression

When someone lands on your portfolio:

1. **Immediate wow factor** - Animated gradient catches the eye
2. **Professional appearance** - Clean, modern design
3. **Clear purpose** - Instantly know you're a developer
4. **Easy navigation** - Clear sections and CTAs
5. **Modern tech** - Shows you're up-to-date with trends
6. **Attention to detail** - Polish in every interaction
7. **Personal branding** - Unique, not templated
8. **Memorable** - Stands out from typical portfolios

**Result:** Hiring managers will be impressed! 🎉

---

This design combines modern aesthetics with excellent UX to create a portfolio that truly showcases your skills as a mobile and backend developer.
