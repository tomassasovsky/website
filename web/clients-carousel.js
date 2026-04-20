(() => {
    function init() {
        var carousel = document.querySelector('.clients-carousel');
        var track = carousel?.querySelector('.clients-track');
        if (!carousel || !track) return;

        // Only activate on touch / stylus devices.
        if (!window.matchMedia('(pointer: coarse)').matches) return;

        var dragging = false;
        var startX = 0;
        var baseOffset = 0;
        var duration = 28;

        // Read the live animated translateX from the computed matrix.
        function getCurrentX() {
            return new DOMMatrix(window.getComputedStyle(track).transform).m41;
        }

        track.addEventListener('pointerdown', (e) => {
            if (!e.isPrimary) return;

            // Read both values while the animation is still running.
            duration = parseFloat(window.getComputedStyle(track).animationDuration) || 28;
            baseOffset = getCurrentX();
            dragging = true;
            startX = e.clientX;

            // Kill the animation entirely — CSS animations sit above the author
            // origin in the cascade, so animationPlayState:paused still overrides
            // inline transform. Setting animation:none gives us full control.
            track.style.animation = 'none';
            track.style.transform = `translateX(${baseOffset}px)`;
            track.setPointerCapture(e.pointerId);
            e.preventDefault();
        }, { passive: false });

        track.addEventListener('pointermove', (e) => {
            if (!dragging || !e.isPrimary) return;
            var newX = baseOffset + (e.clientX - startX);
            var w = track.scrollWidth / 2; // one full logo set = loop distance
            // Wrap into [-w, 0) so the loop stays seamless.
            newX = -(((-newX) % w + w) % w);
            if (newX === 0) newX = -w; // avoid flicker at exact 0
            track.style.transform = `translateX(${newX}px)`;
        });

        function endDrag(e) {
            if (!dragging || !e.isPrimary) return;
            dragging = false;

            var currentX = new DOMMatrix(track.style.transform).m41;
            var w = track.scrollWidth / 2;
            // currentX is in (-w, 0]. progress=0 means start, progress=1 means end.
            // Negate so progress increases as we scroll left.
            var progress = Math.abs(currentX) / w;
            progress = progress - Math.floor(progress); // clamp to [0, 1)
            var delay = -(progress * duration);

            // Re-enable CSS animation from the dragged position.
            track.style.transform = '';
            track.style.animation = '';
            track.style.animationDelay = `${delay}s`;
        }

        track.addEventListener('pointerup', endDrag);
        track.addEventListener('pointercancel', endDrag);
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }
})();
