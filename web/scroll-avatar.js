(() => {
  var HERO_KEY = 'nav_hero_visible';   // hero was in view (not docked) when we left
  var AVATAR_KEY = 'nav_avatar_visible'; // avatar was docked when we left
  var observer = null;
  var debounce = null;
  var heroVisible = false;

  // ── Persist state before any navigation ───────────────────────────────────

  function saveState() {
    var hero = document.getElementById('hero-avatar');
    if (hero && hero.getBoundingClientRect().bottom > 0) {
      sessionStorage.setItem(HERO_KEY, '1');
    } else {
      sessionStorage.removeItem(HERO_KEY);
    }

    var av = document.querySelector('.navbar__avatar');
    var avW = av ? (parseFloat(getComputedStyle(av).width) || 0) : 0;
    if (avW > 0) {
      sessionStorage.setItem(AVATAR_KEY, '1');
    } else {
      sessionStorage.removeItem(AVATAR_KEY);
    }
  }

  document.addEventListener('click', (e) => {
    if (e.target.closest('a[href]')) saveState();
  }, true);
  window.addEventListener('pagehide', saveState);

  // ── Core sync ─────────────────────────────────────────────────────────────

  function syncNow() {
    var nav = document.querySelector('.navbar');
    if (!nav) return;
    var hero = document.getElementById('hero-avatar');

    if (observer) { observer.disconnect(); observer = null; }

    if (hero) {
      const av = nav.querySelector('.navbar__avatar');
      const avatarWasDocked = sessionStorage.getItem(AVATAR_KEY) === '1';
      sessionStorage.removeItem(AVATAR_KEY);
      sessionStorage.removeItem(HERO_KEY); // stale once we're on home

      const r = hero.getBoundingClientRect();
      heroVisible = r.bottom > 0;
      nav.classList.toggle('navbar--scrolled', r.bottom <= 0);

      if (avatarWasDocked && heroVisible) {
        slideOut(av, nav); // handles its own style reset internally
      } else {
        if (av) av.style.cssText = '';
      }

      observer = new IntersectionObserver((entries) => {
        const e = entries[0];
        heroVisible = e.isIntersecting;
        nav.classList.toggle('navbar--scrolled', !e.isIntersecting);
      }, { threshold: 0 });
      observer.observe(hero);
      return;
    }

    // ── Non-home page ─────────────────────────────────────────────────────

    if (heroVisible) {
      // SPA navigation: Dart already toggled navbar--scrolled, CSS transition
      // fired automatically. Just clean up storage.
      sessionStorage.removeItem(HERO_KEY);
      heroVisible = false;
      return;
    }

    // Full-page reload to non-home: slide in if hero was visible before.
    if (sessionStorage.getItem(HERO_KEY) === '1') {
      sessionStorage.removeItem(HERO_KEY);
      slideIn(nav);
    }
  }

  // ── Slide in: avatar appears (mirrors scroll-down docking) ────────────────
  function slideIn(nav) {
    var av = nav.querySelector('.navbar__avatar');
    if (!av) return;
    av.style.transition = 'none';
    av.style.width = '0px';
    av.style.opacity = '0';
    av.style.marginRight = '0px';
    requestAnimationFrame(() => {
      requestAnimationFrame(() => {
        av.style.transition = '';
        av.style.width = '';
        av.style.opacity = '';
        av.style.marginRight = '';
        // .navbar--scrolled .navbar__avatar rules take over → CSS transition fires.
      });
    });
  }

  // ── Slide out: avatar disappears (mirrors scroll-up undocking) ────────────
  function slideOut(av, nav) {
    if (!av) return;
    av.style.cssText = ''; // clear any leftover inline styles

    var currentW = parseFloat(getComputedStyle(av).width) || 0;

    // SPA case: Dart already removed navbar--scrolled, CSS transition is already
    // running downward → don't interrupt it.
    if (currentW > 0 && !nav.classList.contains('navbar--scrolled')) return;

    // Full-reload case: avatar starts at 0. Force to visible, then release so
    // the CSS transition fires from 26 px → 0.
    av.style.transition = 'none';
    av.style.width = '26px';
    av.style.opacity = '1';
    av.style.marginRight = '0.5rem';
    requestAnimationFrame(() => {
      requestAnimationFrame(() => {
        av.style.transition = '';
        av.style.width = '';
        av.style.opacity = '';
        av.style.marginRight = '';
      });
    });
  }

  // ── Debounced MutationObserver (SPA / live DOM changes) ───────────────────

  function debouncedSync() {
    clearTimeout(debounce);
    debounce = setTimeout(syncNow, 20);
  }

  window.addEventListener('scroll', () => {
    const hero = document.getElementById('hero-avatar');
    if (hero) heroVisible = hero.getBoundingClientRect().bottom > 0;
  }, { passive: true });

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', syncNow);
  } else {
    syncNow();
  }

  new MutationObserver(debouncedSync).observe(document.documentElement, {
    childList: true,
    subtree: true,
  });
})();
