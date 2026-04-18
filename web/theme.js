(() => {
    const KEY = 'theme';
    const TOTAL = 30; // total lottie frames

    let anim = null;
    let animReady = false;
    let isAnimating = false;

    // ── Theme flip ────────────────────────────────────────────────────────────
    // suppressTransitions=true is only needed for the no-VT fallback path,
    // where there is no frozen snapshot and colour transitions would be visible.
    function applyTheme(next, suppressTransitions) {
        if (suppressTransitions) {
            document.documentElement.style.setProperty('--t', '0s');
        }
        document.documentElement.setAttribute('data-theme', next);
        localStorage.setItem(KEY, next);
        if (suppressTransitions) {
            // Restore transitions after two frames so hover effects still work
            requestAnimationFrame(() => requestAnimationFrame(() => {
                document.documentElement.style.removeProperty('--t');
            }));
        }
    }

    // ── Lottie init ───────────────────────────────────────────────────────────
    function initLottie() {
        const container = document.getElementById('theme-lottie');
        if (!container || !window.lottie || anim) return;

        anim = lottie.loadAnimation({
            container: container,
            renderer: 'svg',
            loop: false,
            autoplay: false,
            path: '/assets/theme-switch.json',
        });

        anim.addEventListener('DOMLoaded', () => {
            const theme = document.documentElement.getAttribute('data-theme') || 'dark';
            // Frame 0 = moon (dark), frame TOTAL = sun (light)
            anim.goToAndStop(theme === 'dark' ? 0 : TOTAL, true);
            animReady = true;
        });
    }

    // ── Public toggle ─────────────────────────────────────────────────────────
    window.toggleTheme = (btn) => {
        if (isAnimating) return;

        const current = document.documentElement.getAttribute('data-theme') || 'dark';
        const next = current === 'light' ? 'dark' : 'light';

        // Click origin for the expanding circle
        let x = window.innerWidth - 40, y = 29;
        if (btn) {
            const r = btn.getBoundingClientRect();
            x = Math.round(r.left + r.width / 2);
            y = Math.round(r.top + r.height / 2);
        }

        // Play lottie icon transition (independent of the page animation)
        if (anim && animReady) {
            anim.setDirection(next === 'light' ? 1 : -1);
            anim.play();
        }

        // ── View Transitions API (Chrome 111+, Safari 18+) ──────────────────────
        if (document.startViewTransition) {
            isAnimating = true;

            // Inject a @keyframes rule with the actual pixel coordinates baked in.
            // CSS custom properties are not inherited by ::view-transition pseudo-
            // elements (they live outside the DOM), so we must write the values
            // directly into the keyframe. The rule is applied before the transition
            // starts, so clip-path is circle(0px) on the very first rendered frame.
            const kfStyle = document.createElement('style');
            kfStyle.id = '__vt-kf';
            kfStyle.textContent = `@keyframes vt-circle-reveal {
  from { clip-path: circle(0px at ${x}px ${y}px); }
  to   { clip-path: circle(200vmax at ${x}px ${y}px); }
}`;
            document.head.appendChild(kfStyle);

            const transition = document.startViewTransition(() => applyTheme(next, false));

            transition.finished.then(() => {
                kfStyle.remove();
                isAnimating = false;
            });
            return;
        }

        // ── Fallback: instant flip, suppress colour transitions ──────────────────
        applyTheme(next, true);
    };

    // ── Boot ──────────────────────────────────────────────────────────────────
    document.addEventListener('DOMContentLoaded', () => {
        const theme = localStorage.getItem(KEY) || 'dark';
        document.documentElement.setAttribute('data-theme', theme);
        initLottie();
    });
})();
