(() => {
  const KEY   = 'theme';
  const TOTAL = 30; // total lottie frames

  let anim        = null;
  let animReady   = false;
  let isAnimating = false;

  // ── Theme flip (instant, no transitions) ──────────────────────────────────
  function applyTheme(next) {
    document.documentElement.style.setProperty('--t', '0s');
    document.documentElement.setAttribute('data-theme', next);
    localStorage.setItem(KEY, next);
    requestAnimationFrame(() => requestAnimationFrame(() => {
      document.documentElement.style.removeProperty('--t');
    }));
  }

  // ── Lottie init ───────────────────────────────────────────────────────────
  function initLottie() {
    const container = document.getElementById('theme-lottie');
    if (!container || !window.lottie || anim) return;

    anim = lottie.loadAnimation({
      container : container,
      renderer  : 'svg',
      loop      : false,
      autoplay  : false,
      path      : '/assets/theme-switch.json',
    });

    anim.addEventListener('DOMLoaded', () => {
      const theme = document.documentElement.getAttribute('data-theme') || 'dark';
      // Frame 0 = moon (dark), frame TOTAL = sun (light)
      anim.goToAndStop(theme === 'dark' ? 0 : TOTAL, true);
      animReady = true;
    });
  }

  // ── Public toggle ─────────────────────────────────────────────────────────
  window.toggleTheme = function (btn) {
    if (isAnimating) return;

    const current = document.documentElement.getAttribute('data-theme') || 'dark';
    const next    = current === 'light' ? 'dark' : 'light';

    // Click origin for the expanding circle
    let x = window.innerWidth - 40, y = 29;
    if (btn) {
      const r = btn.getBoundingClientRect();
      x = Math.round(r.left + r.width  / 2);
      y = Math.round(r.top  + r.height / 2);
    }

    // Play lottie icon transition (independent of the page animation)
    if (anim && animReady) {
      anim.setDirection(next === 'light' ? 1 : -1);
      anim.play();
    }

    // ── View Transitions API (Chrome 111+, Safari 18+) ──────────────────────
    if (document.startViewTransition) {
      isAnimating = true;
      const transition = document.startViewTransition(() => applyTheme(next));

      transition.ready.then(() => {
        // Clip the INCOMING (new-theme) snapshot from a tiny circle to full screen
        document.documentElement.animate(
          { clipPath: [`circle(0px at ${x}px ${y}px)`, `circle(200vmax at ${x}px ${y}px)`] },
          { duration: 550, easing: 'cubic-bezier(0.4,0,0.2,1)', pseudoElement: '::view-transition-new(root)' }
        );
      });

      transition.finished.then(() => { isAnimating = false; });
      return;
    }

    // ── Fallback: instant flip, no animation ────────────────────────────────
    applyTheme(next);
  };

  // ── Boot ──────────────────────────────────────────────────────────────────
  document.addEventListener('DOMContentLoaded', () => {
    const theme = localStorage.getItem(KEY) || 'dark';
    document.documentElement.setAttribute('data-theme', theme);
    initLottie();
  });
})();
