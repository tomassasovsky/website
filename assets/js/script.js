'use strict';



// element toggle function
const elementToggleFunc = function (elem) { elem.classList.toggle("active"); }



// sidebar variables
const sidebar = document.querySelector("[data-sidebar]");
const sidebarBtn = document.querySelector("[data-sidebar-btn]");

// sidebar toggle functionality for mobile
sidebarBtn.addEventListener("click", function () { elementToggleFunc(sidebar); });



// testimonials variables
const testimonialsItem = document.querySelectorAll("[data-testimonials-item]");
const modalContainer = document.querySelector("[data-modal-container]");
const modalCloseBtn = document.querySelector("[data-modal-close-btn]");
const overlay = document.querySelector("[data-overlay]");

// modal variable
// avatar removed from modal
const modalTitle = document.querySelector("[data-modal-title]");
const modalText = document.querySelector("[data-modal-text]");

// modal toggle function
const testimonialsModalFunc = function () {
  modalContainer.classList.toggle("active");
  overlay.classList.toggle("active");
}

// add click event to all modal items
for (let i = 0; i < testimonialsItem.length; i++) {

  testimonialsItem[i].addEventListener("click", function () {

    // avatars removed; only set title/text and date
    modalTitle.innerHTML = this.querySelector("[data-testimonials-title]").innerHTML;
    modalText.innerHTML = this.querySelector("[data-testimonials-text]").innerHTML;
    var dateAttr = this.getAttribute('data-testimonials-date');
    var dateLabel = this.getAttribute('data-testimonials-date-label');
    var timeEl = modalContainer.querySelector('.testimonials-modal time');
    if (timeEl) {
      if (dateAttr) { timeEl.setAttribute('datetime', dateAttr); }
      if (dateLabel) { timeEl.textContent = dateLabel; }
    }

    testimonialsModalFunc();

  });

}

// add click event to modal close button
modalCloseBtn.addEventListener("click", testimonialsModalFunc);
overlay.addEventListener("click", testimonialsModalFunc);



// custom select variables
const select = document.querySelector("[data-select]");
const selectItems = document.querySelectorAll("[data-select-item]");
const selectValue = document.querySelector("[data-selecct-value]");
const filterBtn = document.querySelectorAll("[data-filter-btn]");

select.addEventListener("click", function () { elementToggleFunc(this); });

// add event in all select items
for (let i = 0; i < selectItems.length; i++) {
  selectItems[i].addEventListener("click", function () {

    let selectedValue = this.innerText.toLowerCase();
    selectValue.innerText = this.innerText;
    elementToggleFunc(select);
    filterFunc(selectedValue);

  });
}

// filter variables (refreshed after dynamic render)
let filterItems = document.querySelectorAll("[data-filter-item]");

const filterFunc = function (selectedValue) {
  // Always re-query to include dynamically added items
  filterItems = document.querySelectorAll("[data-filter-item]");

  for (let i = 0; i < filterItems.length; i++) {
    if (selectedValue === "all") {
      filterItems[i].classList.add("active");
    } else if (selectedValue === filterItems[i].dataset.category) {
      filterItems[i].classList.add("active");
    } else {
      filterItems[i].classList.remove("active");
    }
  }
}

// add event in all filter button items for large screen
let lastClickedBtn = filterBtn[0];

for (let i = 0; i < filterBtn.length; i++) {

  filterBtn[i].addEventListener("click", function () {

    let selectedValue = this.innerText.toLowerCase();
    selectValue.innerText = this.innerText;
    filterFunc(selectedValue);

    lastClickedBtn.classList.remove("active");
    this.classList.add("active");
    lastClickedBtn = this;

  });

}



// contact form variables
const form = document.querySelector("[data-form]");
const formInputs = document.querySelectorAll("[data-form-input]");
const formBtn = document.querySelector("[data-form-btn]");

// add event to all form input field
for (let i = 0; i < formInputs.length; i++) {
  formInputs[i].addEventListener("input", function () {

    // check form validation
    if (form.checkValidity()) {
      formBtn.removeAttribute("disabled");
    } else {
      formBtn.setAttribute("disabled", "");
    }

  });
}


// contact form submit handler with spam protection and feedback
if (form) {
  const formStatus = document.querySelector('[data-form-status]');
  const honeypotInput = form.querySelector('input[name="company"]');
  const cooldownSeconds = Number(form.getAttribute('data-cooldown-seconds') || '0');
  const cooldownStorageKey = 'contactFormLastSubmittedAt';

  const getCooldownRemainingMs = function () {
    if (!cooldownSeconds) { return 0; }
    let last = 0;
    try { last = Number(localStorage.getItem(cooldownStorageKey) || '0'); } catch (e) { last = 0; }
    if (!last) { return 0; }
    const elapsed = Date.now() - last;
    const remaining = (cooldownSeconds * 1000) - elapsed;
    return Math.max(0, remaining);
  };

  const startCooldownNow = function () {
    try { localStorage.setItem(cooldownStorageKey, String(Date.now())); } catch (e) { /* ignore */ }
  };

  const showStatus = function (text) {
    if (formStatus) { formStatus.textContent = text; }
  };

  // Initialize cooldown state on load
  (function initCooldown() {
    const remaining = getCooldownRemainingMs();
    if (remaining > 0 && formBtn) {
      formBtn.setAttribute('disabled', '');
      const seconds = Math.ceil(remaining / 1000);
      showStatus('Please wait ' + seconds + 's before sending again.');
    }
  })();

  form.addEventListener('submit', function (e) {
    e.preventDefault();

    if (!form.checkValidity()) { return; }

    // Honeypot check: if filled, pretend success but do nothing
    if (honeypotInput && honeypotInput.value && honeypotInput.value.trim() !== '') {
      showStatus('Thanks! Your message has been sent.');
      form.reset();
      if (formBtn) { formBtn.setAttribute('disabled', ''); }
      return;
    }

    // Cooldown check
    const remaining = getCooldownRemainingMs();
    if (remaining > 0) {
      const seconds = Math.ceil(remaining / 1000);
      showStatus('Please wait ' + seconds + 's before sending again.');
      return;
    }

    const endpoint = (form.getAttribute('data-endpoint') || '').trim();
    if (!endpoint) {
      showStatus('Form endpoint not configured. Set data-endpoint on the form.');
      return;
    }

    const nameEl = form.querySelector('input[name="fullname"]');
    const emailEl = form.querySelector('input[name="email"]');
    const messageEl = form.querySelector('textarea[name="message"]');

    const payload = {
      fullname: nameEl ? String(nameEl.value || '').trim() : '',
      email: emailEl ? String(emailEl.value || '').trim() : '',
      message: messageEl ? String(messageEl.value || '').trim() : ''
    };

    // UI: set loading state
    let originalBtnText = '';
    const btnTextSpan = formBtn ? formBtn.querySelector('span') : null;
    if (btnTextSpan) { originalBtnText = btnTextSpan.textContent || ''; }
    if (formBtn) {
      formBtn.setAttribute('disabled', '');
      if (btnTextSpan) { btnTextSpan.textContent = 'Sending...'; }
    }
    showStatus('');

    fetch(endpoint, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: JSON.stringify(payload)
    })
      .then(function (res) {
        if (!res.ok) { throw new Error('Request failed with status ' + res.status); }
        // Some providers return empty body; ignore JSON parse errors
        return res.json().catch(function () { return {}; });
      })
      .then(function () {
        showStatus('Message sent! I will get back to you soon.');
        form.reset();
        if (formBtn) { formBtn.setAttribute('disabled', ''); }
        if (cooldownSeconds > 0) { startCooldownNow(); }
      })
      .catch(function () {
        showStatus('There was a problem sending your message. Please try again, or email tomas@aquiles.dev.');
        // Re-enable button if inputs are still valid and no cooldown
        if (formBtn && form.checkValidity() && getCooldownRemainingMs() <= 0) {
          formBtn.removeAttribute('disabled');
        }
      })
      .finally(function () {
        if (btnTextSpan) { btnTextSpan.textContent = originalBtnText || 'Send Message'; }
      });
  });
}



// page navigation with History API (deep links like /portfolio)
const navigationLinks = document.querySelectorAll('[data-nav-link]');
const pages = document.querySelectorAll('[data-page]');

// Build set of valid page names from the DOM
const validPages = Array.prototype.map.call(pages, function (p) { return String(p.dataset.page || '').toLowerCase(); });

function normalizePageName(name) {
  return String(name || '').trim().toLowerCase();
}

function getBasePath() {
  // Remove a trailing "/{page}" segment if present to keep base path intact for subfolder hosting
  var path = window.location.pathname || '/';
  var re = new RegExp('/(?:' + validPages.join('|') + ')/?$', 'i');
  return path.replace(re, '');
}

function getPageFromLocation() {
  // 1) Try pathname segments
  var segments = (window.location.pathname || '/').toLowerCase().split('/').filter(Boolean);
  for (var i = segments.length - 1; i >= 0; i--) {
    if (validPages.indexOf(segments[i]) !== -1) { return segments[i]; }
  }
  // 2) Try hash (#portfolio or #/portfolio)
  var hash = (window.location.hash || '').toLowerCase().replace(/^#\/?/, '');
  if (validPages.indexOf(hash) !== -1) { return hash; }
  // 3) Default
  return validPages.indexOf('about') !== -1 ? 'about' : (validPages[0] || 'about');
}

function hasExplicitPageInLocation() {
  var segments = (window.location.pathname || '/').toLowerCase().split('/').filter(Boolean);
  for (var i = segments.length - 1; i >= 0; i--) {
    if (validPages.indexOf(segments[i]) !== -1) { return true; }
  }
  var hash = (window.location.hash || '').toLowerCase().replace(/^#\/?/, '');
  return validPages.indexOf(hash) !== -1;
}

function activatePage(pageName) {
  var target = normalizePageName(pageName);
  // Toggle article visibility
  for (var i = 0; i < pages.length; i++) {
    var isActive = normalizePageName(pages[i].dataset.page) === target;
    if (isActive) {
      pages[i].classList.add('active');
    } else {
      pages[i].classList.remove('active');
    }
  }
  // Toggle navbar link active state
  for (var j = 0; j < navigationLinks.length; j++) {
    var linkName = normalizePageName(navigationLinks[j].textContent || navigationLinks[j].innerText);
    if (linkName === target) {
      navigationLinks[j].classList.add('active');
    } else {
      navigationLinks[j].classList.remove('active');
    }
  }
  window.scrollTo(0, 0);
}

function setUrlForPage(pageName, replace) {
  var base = getBasePath();
  var newPath = base + '/' + normalizePageName(pageName);
  var newUrl = newPath + window.location.search; // keep query params
  try {
    if (replace) {
      window.history.replaceState({ page: pageName }, '', newUrl);
    } else {
      window.history.pushState({ page: pageName }, '', newUrl);
    }
  } catch (e) {
    // History API might be blocked; fall back to hash
    window.location.hash = '/' + normalizePageName(pageName);
  }
}

function navigateTo(pageName, replace) {
  activatePage(pageName);
  setUrlForPage(pageName, !!replace);
}

// Initialize current page based on URL
(function initRouting() {
  var initial = getPageFromLocation();
  if (hasExplicitPageInLocation()) {
    // If URL already specifies a section, sync URL and view
    navigateTo(initial, true);
  } else {
    // No section specified: default to About without changing the URL
    activatePage(initial);
  }
})();

// Handle clicks on navbar items
for (let i = 0; i < navigationLinks.length; i++) {
  const idx = i; // bind index to this handler
  navigationLinks[i].addEventListener('click', function (ev) {
    if (ev && typeof ev.preventDefault === 'function') { ev.preventDefault(); }
    var pageName = (pages[idx] && pages[idx].dataset && pages[idx].dataset.page)
      ? pages[idx].dataset.page
      : normalizePageName(this.textContent || this.innerText);
    if (validPages.indexOf(normalizePageName(pageName)) === -1) { return; }
    navigateTo(pageName, false);
  });
}

// Back/forward navigation
window.addEventListener('popstate', function () {
  var current = getPageFromLocation();
  activatePage(current);
});


// Dynamically load GitHub repositories into the portfolio
(function loadGithubProjects() {
  const list = document.querySelector('.project-list');
  if (!list) return;

  const username = 'tomassasovsky';
  fetch(`https://api.github.com/users/${username}/repos?per_page=100&sort=updated`)
    .then(function (res) { return res.json(); })
    .then(function (repos) {
      if (!Array.isArray(repos)) return;
      // Clear existing static items
      list.innerHTML = '';

      for (let i = 0; i < repos.length; i++) {
        const repo = repos[i];
        const li = document.createElement('li');
        li.className = 'project-item  active';
        li.setAttribute('data-filter-item', '');
        li.setAttribute('data-category', 'web development');

        const repoName = (repo && repo.name) ? repo.name : 'Repository';
        const repoUrl = (repo && repo.html_url) ? repo.html_url : '#';
        const lang = (repo && repo.language) ? repo.language : 'Web development';

        li.innerHTML =
          '<a href="' + repoUrl + '" target="_blank" rel="noopener">' +
          '<figure class="project-img">' +
          '<div class="project-item-icon-box">' +
          '<ion-icon name="eye-outline"></ion-icon>' +
          '</div>' +
          '<img src="./assets/images/project-2.png" alt="' + repoName.replace(/"/g, '&quot;') + '" loading="lazy">' +
          '</figure>' +
          '<h3 class="project-title">' + repoName + '</h3>' +
          '<p class="project-category">' + lang + '</p>' +
          '</a>';

        list.appendChild(li);
      }

      // Refresh filter items after render
      filterItems = document.querySelectorAll('[data-filter-item]');
    })
    .catch(function () { /* ignore */ });
})();

// Removed dominant color feature; images now stretch with object-fit: cover