///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'strings.g.dart';

// Path: <root>
typedef AppLocalizationsEn = AppLocalizations; // ignore: unused_element

class AppLocalizations with BaseTranslations<AppLocale, AppLocalizations> {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  AppLocalizations({
    Map<String, Node>? overrides,
    PluralResolver? cardinalResolver,
    PluralResolver? ordinalResolver,
    TranslationMetadata<AppLocale, AppLocalizations>? meta,
  }) : assert(
         overrides == null,
         'Set "translation_overrides: true" in order to enable this feature.',
       ),
       $meta =
           meta ??
           TranslationMetadata(
             locale: AppLocale.en,
             overrides: overrides ?? {},
             cardinalResolver: cardinalResolver,
             ordinalResolver: ordinalResolver,
           ) {
    $meta.setFlatMapFunction(_flatMapFunction);
  }

  /// Metadata for the translations of <en>.
  @override
  final TranslationMetadata<AppLocale, AppLocalizations> $meta;

  /// Access flat map
  dynamic operator [](String key) => $meta.getTranslation(key);

  late final AppLocalizations _root = this; // ignore: unused_field

  AppLocalizations $copyWith({TranslationMetadata<AppLocale, AppLocalizations>? meta}) =>
      AppLocalizations(meta: meta ?? this.$meta);

  // Translations

  /// en: 'About — Tomás Sasovsky'
  String get metaTitleHome => 'About — Tomás Sasovsky';

  /// en: 'Projects — Tomás Sasovsky'
  String get metaTitleProjects => 'Projects — Tomás Sasovsky';

  /// en: 'Contact — Tomás Sasovsky'
  String get metaTitleContact => 'Contact — Tomás Sasovsky';

  /// en: 'Sr. Flutter & Backend Engineer'
  String get siteTagline => 'Sr. Flutter & Backend Engineer';

  /// en: 'Buenos Aires, Argentina'
  String get siteLocation => 'Buenos Aires, Argentina';

  /// en: 'About'
  String get navAbout => 'About';

  /// en: 'Projects'
  String get navProjects => 'Projects';

  /// en: 'Contact'
  String get navContact => 'Contact';

  /// en: 'Available for new opportunities'
  String get heroBadge => 'Available for new opportunities';

  /// en: 'Let's talk →'
  String get heroPrimaryCta => 'Let\'s talk →';

  /// en: 'See my work'
  String get heroSecondaryCta => 'See my work';

  /// en: 'Years experience'
  String get statYearsExperience => 'Years experience';

  /// en: 'Projects shipped'
  String get statProjectsShipped => 'Projects shipped';

  /// en: 'Continents served'
  String get statContinentsServed => 'Continents served';

  /// en: 'Bugs squashed'
  String get statBugsSquashed => 'Bugs squashed';

  /// en: 'About me'
  String get sectionAbout => 'About me';

  /// en: 'Who I am'
  String get sectionWhoIAm => 'Who I am';

  /// en: 'Engineer, builder, open-source contributor.'
  String get sectionAboutSubtitle => 'Engineer, builder, open-source contributor.';

  /// en: 'Services'
  String get sectionServices => 'Services';

  /// en: 'What I do'
  String get sectionWhatIDo => 'What I do';

  /// en: 'Experience'
  String get sectionExperience => 'Experience';

  /// en: 'Trusted by'
  String get sectionTrustedBy => 'Trusted by';

  /// en: 'Testimonials'
  String get sectionTestimonials => 'Testimonials';

  /// en: 'What people say'
  String get sectionWhatPeopleSay => 'What people say';

  /// en: 'Portfolio'
  String get portfolioLabel => 'Portfolio';

  /// en: 'Projects'
  String get projectsHeading => 'Projects';

  /// en: '{projectCount: int} projects across mobile, backend, and open source.'
  String projectsSubtitle({required int projectCount}) =>
      '${projectCount} projects across mobile, backend, and open source.';

  /// en: 'All'
  String get filterAll => 'All';

  /// en: 'Apps'
  String get filterApps => 'Apps';

  /// en: 'OSS / Tools'
  String get filterOss => 'OSS / Tools';

  /// en: 'Unreleased'
  String get projectUnreleased => 'Unreleased';

  /// en: 'Get in touch'
  String get contactGetInTouch => 'Get in touch';

  /// en: 'Contact'
  String get contactHeading => 'Contact';

  /// en: 'Let's work together on something great.'
  String get contactSubtitle => 'Let\'s work together on something great.';

  /// en: 'Book a meeting'
  String get contactBookTitle => 'Book a meeting';

  /// en: 'Pick a time that works for you using my calendar.'
  String get contactBookLine1 => 'Pick a time that works for you using my calendar.';

  /// en: 'You'll get a confirmation and a video meeting link automatically.'
  String get contactBookLine2 =>
      'You\'ll get a confirmation and a video meeting link automatically.';

  /// en: 'Schedule a call →'
  String get contactScheduleCall => 'Schedule a call →';

  /// en: 'Find me online'
  String get contactOnlineTitle => 'Find me online';

  /// en: 'Reach out directly — always happy to chat about Flutter, interesting projects, or new opportunities.'
  String get contactOnlineBody =>
      'Reach out directly — always happy to chat about Flutter, interesting projects, or new opportunities.';

  /// en: 'Send a message'
  String get contactFormTitle => 'Send a message';

  /// en: 'Fill out the form and I'll get back to you within a day or two.'
  String get contactFormDesc => 'Fill out the form and I\'ll get back to you within a day or two.';

  /// en: 'Name'
  String get formName => 'Name';

  /// en: 'Your name'
  String get formNameHint => 'Your name';

  /// en: 'Email'
  String get formEmail => 'Email';

  /// en: 'your@email.com'
  String get formEmailHint => 'your@email.com';

  /// en: 'Subject'
  String get formSubject => 'Subject';

  /// en: 'What's this about?'
  String get formSubjectHint => 'What\'s this about?';

  /// en: 'Message'
  String get formMessage => 'Message';

  /// en: 'Tell me about your project, idea, or just say hi…'
  String get formMessageHint => 'Tell me about your project, idea, or just say hi…';

  /// en: 'Send Message'
  String get formSend => 'Send Message';

  /// en: 'Sending…'
  String get formSending => 'Sending…';

  /// en: 'Message sent — I'll get back to you shortly.'
  String get formSuccess => 'Message sent — I\'ll get back to you shortly.';

  /// en: 'Something went wrong. Please try again.'
  String get formErrorGeneric => 'Something went wrong. Please try again.';

  /// en: 'Please fill in all fields.'
  String get formErrorRequired => 'Please fill in all fields.';

  /// en: 'Please enter a valid email address.'
  String get formErrorEmail => 'Please enter a valid email address.';

  /// en: '© {year: int} Tomás Sasovsky · Built with '
  String footerCopyright({required int year}) => '© ${year} Tomás Sasovsky · Built with ';

  /// en: 'EN'
  String get langSwitchEnglish => 'EN';

  /// en: 'ES'
  String get langSwitchSpanish => 'ES';

  /// en: 'Language'
  String get langSwitchLabel => 'Language';

  /// en: 'I'm a full-stack software engineer with 5+ years of professional experience, specialising in cross-platform mobile development with Flutter and Dart. I've architected and delivered production Flutter applications used by real users at scale across fintech, sports tech, and health sectors.'
  String get aboutP0 =>
      'I\'m a full-stack software engineer with 5+ years of professional experience, specialising in cross-platform mobile development with Flutter and Dart. I\'ve architected and delivered production Flutter applications used by real users at scale across fintech, sports tech, and health sectors.';

  /// en: 'My strengths include state management (Bloc, MVVM), Flutter layered architecture, clean architecture, and modern CI/CD practices. I also bring strong backend experience with TypeScript/Node.js, API integration (REST/GraphQL), and cloud infrastructure (GCP/AWS). I'm comfortable leading teams and projects, driving complex technical initiatives from concept to production, and I care deeply about engineering excellence, scalable architecture, and exceptional user experiences.'
  String get aboutP1 =>
      'My strengths include state management (Bloc, MVVM), Flutter layered architecture, clean architecture, and modern CI/CD practices. I also bring strong backend experience with TypeScript/Node.js, API integration (REST/GraphQL), and cloud infrastructure (GCP/AWS). I\'m comfortable leading teams and projects, driving complex technical initiatives from concept to production, and I care deeply about engineering excellence, scalable architecture, and exceptional user experiences.';

  /// en: 'Mobile app development'
  String get svc0Title => 'Mobile app development';

  /// en: 'Design and build reliable iOS/Android apps with modern architecture and great UX.'
  String get svc0Desc =>
      'Design and build reliable iOS/Android apps with modern architecture and great UX.';

  /// en: 'Backend & API development'
  String get svc1Title => 'Backend & API development';

  /// en: 'TypeScript/Node.js services, REST APIs, authentication, payments, and docs.'
  String get svc1Desc =>
      'TypeScript/Node.js services, REST APIs, authentication, payments, and docs.';

  /// en: 'Web apps & front-end'
  String get svc2Title => 'Web apps & front-end';

  /// en: 'Responsive, accessible interfaces with performance in mind across all devices.'
  String get svc2Desc =>
      'Responsive, accessible interfaces with performance in mind across all devices.';

  /// en: 'Integrations & DevOps'
  String get svc3Title => 'Integrations & DevOps';

  /// en: 'Product integrations, monitoring, and CI/CD pipelines for dependable releases.'
  String get svc3Desc =>
      'Product integrations, monitoring, and CI/CD pipelines for dependable releases.';

  /// en: 'Open source contributions'
  String get svc4Title => 'Open source contributions';

  /// en: 'Active contributor to community tools and libraries; maintaining and shipping OSS.'
  String get svc4Desc =>
      'Active contributor to community tools and libraries; maintaining and shipping OSS.';

  /// en: 'Google Play'
  String get labelGooglePlay => 'Google Play';

  /// en: 'App Store'
  String get labelAppStore => 'App Store';

  /// en: 'Website'
  String get labelWebsite => 'Website';

  /// en: 'Documentation'
  String get labelDocumentation => 'Documentation';

  /// en: 'GitHub'
  String get labelGithub => 'GitHub';

  /// en: 'Discord'
  String get labelDiscord => 'Discord';

  /// en: 'El Dorado P2P'
  String get proj0Title => 'El Dorado P2P';

  /// en: 'A Stablecoin SuperApp for LATAM offering a USD wallet and a peer-to-peer marketplace across 70+ finance apps (PayPal, Zelle, PIX, MercadoPago, Nequi, and more). Built for reliability and ease of use to move value across borders, protect savings in USD, and enable P2P merchant workflows.'
  String get proj0Desc =>
      'A Stablecoin SuperApp for LATAM offering a USD wallet and a peer-to-peer marketplace across 70+ finance apps (PayPal, Zelle, PIX, MercadoPago, Nequi, and more). Built for reliability and ease of use to move value across borders, protect savings in USD, and enable P2P merchant workflows.';

  /// en: 'SportsVisio App'
  String get proj1Title => 'SportsVisio App';

  /// en: 'SportsVisio delivers player stats, analysis, and highlights in a secure, simple-to-use app to elevate your game with game-changing AI technology.'
  String get proj1Desc =>
      'SportsVisio delivers player stats, analysis, and highlights in a secure, simple-to-use app to elevate your game with game-changing AI technology.';

  /// en: 'SportsVisio Manager'
  String get proj2Title => 'SportsVisio Manager';

  /// en: 'Publish schedules and upload game video. SportsVisio converts footage into player stats and highlights for easy review in the SportsVisio app.'
  String get proj2Desc =>
      'Publish schedules and upload game video. SportsVisio converts footage into player stats and highlights for easy review in the SportsVisio app.';

  /// en: 'SportsVisio Track'
  String get proj3Title => 'SportsVisio Track';

  /// en: 'Experimental native Android app for single-phone player/ball tracking. YOLO + MOT (Kalman + Hungarian), homography for court mapping. Kotlin (CameraX/MediaCodec), real-time and low power.'
  String get proj3Desc =>
      'Experimental native Android app for single-phone player/ball tracking. YOLO + MOT (Kalman + Hungarian), homography for court mapping. Kotlin (CameraX/MediaCodec), real-time and low power.';

  /// en: 'APIConnect'
  String get proj4Title => 'APIConnect';

  /// en: 'Consumer app for API Abroad built with a modern stack and production-ready CI/CD. Emphasis on secure auth, dependable releases, and crisp UX to guide users through program discovery and onboarding.'
  String get proj4Desc =>
      'Consumer app for API Abroad built with a modern stack and production-ready CI/CD. Emphasis on secure auth, dependable releases, and crisp UX to guide users through program discovery and onboarding.';

  /// en: 'TAZA Express'
  String get proj5Title => 'TAZA Express';

  /// en: 'Food ordering and delivery tracking for a high-volume marketplace. Implemented map integrations and streamlined order states for a predictable end-to-end experience.'
  String get proj5Desc =>
      'Food ordering and delivery tracking for a high-volume marketplace. Implemented map integrations and streamlined order states for a predictable end-to-end experience.';

  /// en: 'Genjo'
  String get proj6Title => 'Genjo';

  /// en: 'AI-powered platform designed to transform browsers into buyers, enhance customer interactions, and generate leads. Offers personalised, 24/7 customer engagement, boosting conversions and average order values while reducing returns.'
  String get proj6Desc =>
      'AI-powered platform designed to transform browsers into buyers, enhance customer interactions, and generate leads. Offers personalised, 24/7 customer engagement, boosting conversions and average order values while reducing returns.';

  /// en: 'Genomii'
  String get proj7Title => 'Genomii';

  /// en: 'Health insights and guidance with device integrations and privacy-first design. Responsibilities covered integrations, subscriptions, and KYC/verification flows.'
  String get proj7Desc =>
      'Health insights and guidance with device integrations and privacy-first design. Responsibilities covered integrations, subscriptions, and KYC/verification flows.';

  /// en: 'Go Router Guards'
  String get proj8Title => 'Go Router Guards';

  /// en: 'Flexible and extensible guard system for Go Router with composable boolean logic and type-safe routes. Supports ALL/ANY/ONE-OF combinations, redirect semantics, and a GuardedRoute mixin. Includes examples and tests for robust, reusable route protection.'
  String get proj8Desc =>
      'Flexible and extensible guard system for Go Router with composable boolean logic and type-safe routes. Supports ALL/ANY/ONE-OF combinations, redirect semantics, and a GuardedRoute mixin. Includes examples and tests for robust, reusable route protection.';

  /// en: 'Radio Horizon (Dart)'
  String get proj9Title => 'Radio Horizon (Dart)';

  /// en: 'Discord radio playing bot with powerful song recognition technology. Identifies and announces songs currently playing on the radio, making it easy to keep track of your favourite tunes.'
  String get proj9Desc =>
      'Discord radio playing bot with powerful song recognition technology. Identifies and announces songs currently playing on the radio, making it easy to keep track of your favourite tunes.';

  /// en: 'ncnn.dart'
  String get proj10Title => 'ncnn.dart';

  /// en: 'Dart FFI bindings and tooling around Tencent NCNN for on-device neural inference. Targets mobile and desktop with zero-copy buffers where possible and pragmatic model loading. Useful for small, fast CNNs without heavyweight runtimes.'
  String get proj10Desc =>
      'Dart FFI bindings and tooling around Tencent NCNN for on-device neural inference. Targets mobile and desktop with zero-copy buffers where possible and pragmatic model loading. Useful for small, fast CNNs without heavyweight runtimes.';

  /// en: 'pytorch.dart'
  String get proj11Title => 'pytorch.dart';

  /// en: 'Experimental Dart bindings for LibTorch/PyTorch to enable native tensor ops and model execution. Explores FFI surfaces for tensors, autograd, and model invocation from Flutter. Aimed at research/prototyping.'
  String get proj11Desc =>
      'Experimental Dart bindings for LibTorch/PyTorch to enable native tensor ops and model execution. Explores FFI surfaces for tensors, autograd, and model invocation from Flutter. Aimed at research/prototyping.';

  /// en: 'automatic_version_upgrader.dart'
  String get proj12Title => 'automatic_version_upgrader.dart';

  /// en: 'CLI helper to automatically bump Dart/Flutter package versions and changelogs. Parses conventional commits, updates pubspec, and generates changelog entries with semantic versioning. Designed to fit CI pipelines.'
  String get proj12Desc =>
      'CLI helper to automatically bump Dart/Flutter package versions and changelogs. Parses conventional commits, updates pubspec, and generates changelog entries with semantic versioning. Designed to fit CI pipelines.';

  /// en: 'tus_client'
  String get proj13Title => 'tus_client';

  /// en: 'Dart client for the TUS resumable upload protocol with reliable, restartable uploads. Handles chunking, retries, and metadata, with pluggable storage for resumption across app restarts. Great for large files and flaky networks.'
  String get proj13Desc =>
      'Dart client for the TUS resumable upload protocol with reliable, restartable uploads. Handles chunking, retries, and metadata, with pluggable storage for resumption across app restarts. Great for large files and flaky networks.';

  /// en: 'radio-browser-api.dart'
  String get proj14Title => 'radio-browser-api.dart';

  /// en: 'Dart wrapper around the Radio Browser open API for discovering and streaming internet radio stations. Supports search by name, country, language, and tag, with typed models and a simple async interface.'
  String get proj14Desc =>
      'Dart wrapper around the Radio Browser open API for discovering and streaming internet radio stations. Supports search by name, country, language, and tag, with typed models and a simple async interface.';

  /// en: 'Leave a Testimonial — Tomás Sasovsky'
  String get testiPageTitle => 'Leave a Testimonial — Tomás Sasovsky';

  /// en: 'Leave a testimonial'
  String get testiPageHeading => 'Leave a testimonial';

  /// en: 'If we've worked together and you'd like to share a few words, I'd really appreciate it. Your feedback helps others understand what it's like to collaborate with me.'
  String get testiPageSubtitle =>
      'If we\'ve worked together and you\'d like to share a few words, I\'d really appreciate it. Your feedback helps others understand what it\'s like to collaborate with me.';

  /// en: 'What others have said'
  String get testiPageExamplesTitle => 'What others have said';

  /// en: 'Here are a few examples from past colleagues and clients — there's no required format, just write in your own words.'
  String get testiPageExamplesDesc =>
      'Here are a few examples from past colleagues and clients — there\'s no required format, just write in your own words.';

  /// en: 'Your testimonial'
  String get testiPageFormTitle => 'Your testimonial';

  /// en: 'I'll review it and add it to the site if it's a good fit. A sentence or two is great — a paragraph or more is even better.'
  String get testiPageFormDesc =>
      'I\'ll review it and add it to the site if it\'s a good fit. A sentence or two is great — a paragraph or more is even better.';

  /// en: 'Your name *'
  String get testiFormName => 'Your name *';

  /// en: 'Jane Smith'
  String get testiFormNameHint => 'Jane Smith';

  /// en: 'Role / Company'
  String get testiFormRole => 'Role / Company';

  /// en: 'CTO at Acme Corp (optional)'
  String get testiFormRoleHint => 'CTO at Acme Corp (optional)';

  /// en: 'LinkedIn profile URL'
  String get testiFormLinkedin => 'LinkedIn profile URL';

  /// en: 'https://linkedin.com/in/yourprofile (optional)'
  String get testiFormLinkedinHint => 'https://linkedin.com/in/yourprofile (optional)';

  /// en: 'Your testimonial *'
  String get testiFormTestimonial => 'Your testimonial *';

  /// en: 'Write freely — a few sentences to a few paragraphs is perfect. Feel free to mention the project we worked on, what stood out, and anything you'd tell someone considering working with me.'
  String get testiFormTestimonialHint =>
      'Write freely — a few sentences to a few paragraphs is perfect. Feel free to mention the project we worked on, what stood out, and anything you\'d tell someone considering working with me.';

  /// en: 'Please fill in your name and testimonial.'
  String get testiFormErrorRequired => 'Please fill in your name and testimonial.';

  /// en: 'Thank you! Your testimonial has been submitted and I'll review it shortly.'
  String get testiFormSuccess =>
      'Thank you! Your testimonial has been submitted and I\'ll review it shortly.';

  /// en: 'Submit testimonial'
  String get testiFormSubmit => 'Submit testimonial';

  /// en: 'October 2025'
  String get testi0Date => 'October 2025';

  /// en: 'I'm excited to recommend Tomás as an outstanding software engineer. I've had the unique privilege of working alongside Tomás at IT-TechGroup and later leading him as Team Lead at SportsVisio, witnessing his remarkable evolution from promising junior developer to all-star engineer.'
  String get testi0P0 =>
      'I\'m excited to recommend Tomás as an outstanding software engineer. I\'ve had the unique privilege of working alongside Tomás at IT-TechGroup and later leading him as Team Lead at SportsVisio, witnessing his remarkable evolution from promising junior developer to all-star engineer.';

  /// en: 'What distinguishes Tomás is his unwavering reliability in delivering high-quality solutions. His work on background TUS upload optimization and Bloc-based architecture rewrite at SportsVisio exemplifies his ability to tackle complex, high-impact challenges.'
  String get testi0P1 =>
      'What distinguishes Tomás is his unwavering reliability in delivering high-quality solutions. His work on background TUS upload optimization and Bloc-based architecture rewrite at SportsVisio exemplifies his ability to tackle complex, high-impact challenges.';

  /// en: 'Tomás thrives on difficult problems that would intimidate most engineers. I could confidently take holidays knowing he'd handle any critical issue. Any organisation would be fortunate to have Tomás on their most challenging projects.'
  String get testi0P2 =>
      'Tomás thrives on difficult problems that would intimidate most engineers. I could confidently take holidays knowing he\'d handle any critical issue. Any organisation would be fortunate to have Tomás on their most challenging projects.';

  /// en: 'January 2025'
  String get testi1Date => 'January 2025';

  /// en: 'I am thrilled to recommend Tomás Sasovsky as an exceptional Flutter Developer. Over the past three years, I've had the pleasure of working with Tomás as both a coworker and his team lead, and his contributions to our team have been invaluable.'
  String get testi1P0 =>
      'I am thrilled to recommend Tomás Sasovsky as an exceptional Flutter Developer. Over the past three years, I\'ve had the pleasure of working with Tomás as both a coworker and his team lead, and his contributions to our team have been invaluable.';

  /// en: 'Tomás brings deep expertise in Flutter and mobile development, consistently delivering high-quality applications. His problem-solving skills and ability to write clean, scalable code have driven the success of numerous projects.'
  String get testi1P1 =>
      'Tomás brings deep expertise in Flutter and mobile development, consistently delivering high-quality applications. His problem-solving skills and ability to write clean, scalable code have driven the success of numerous projects.';

  /// en: 'What truly sets Tomás apart is his collaborative spirit and dedication. He is a natural team player who shares knowledge generously, mentors junior developers, and fosters a positive work environment.'
  String get testi1P2 =>
      'What truly sets Tomás apart is his collaborative spirit and dedication. He is a natural team player who shares knowledge generously, mentors junior developers, and fosters a positive work environment.';

  /// en: 'January 2025'
  String get testi2Date => 'January 2025';

  /// en: 'I had the pleasure of working closely with Tomás for 2.5 years on a variety of projects, including the development of a complex Android native app that integrated an NDK-based machine learning model.'
  String get testi2P0 =>
      'I had the pleasure of working closely with Tomás for 2.5 years on a variety of projects, including the development of a complex Android native app that integrated an NDK-based machine learning model.';

  /// en: 'Throughout our time working together, he demonstrated exceptional technical expertise, particularly as a mobile Flutter developer, where his contributions elevated our capabilities in every area of the mobile stack.'
  String get testi2P1 =>
      'Throughout our time working together, he demonstrated exceptional technical expertise, particularly as a mobile Flutter developer, where his contributions elevated our capabilities in every area of the mobile stack.';

  /// en: 'One of his standout accomplishments was designing and implementing a robust CI/CD pipeline that streamlined our development process. I strongly recommend him to any team looking for a talented, forward-thinking mobile developer.'
  String get testi2P2 =>
      'One of his standout accomplishments was designing and implementing a robust CI/CD pipeline that streamlined our development process. I strongly recommend him to any team looking for a talented, forward-thinking mobile developer.';

  /// en: 'November 2021'
  String get testi3Date => 'November 2021';

  /// en: 'Proactive and resolutive young developer. If he doesn't know how to do something he finds it out and gives results, always. He ensures to perform quality code and guarantees you for that.'
  String get testi3P0 =>
      'Proactive and resolutive young developer. If he doesn\'t know how to do something he finds it out and gives results, always. He ensures to perform quality code and guarantees you for that.';

  /// en: 'November 2021'
  String get testi4Date => 'November 2021';

  /// en: 'Tomás is a very talented young man. He has a solid knowledge of Flutter. He is very committed when he has project responsibilities. I recommend him as a co-worker or project leader, since he is always willing to learn more and help in a totally selfless way.'
  String get testi4P0 =>
      'Tomás is a very talented young man. He has a solid knowledge of Flutter. He is very committed when he has project responsibilities. I recommend him as a co-worker or project leader, since he is always willing to learn more and help in a totally selfless way.';

  /// en: 'Full-Stack Developer — El Dorado P2P'
  String get exp0Title => 'Full-Stack Developer — El Dorado P2P';

  /// en: 'Feb 2025 — Sep 2025 · Buenos Aires (Hybrid)'
  String get exp0Range => 'Feb 2025 — Sep 2025 · Buenos Aires (Hybrid)';

  /// en: 'Built a public-facing TypeScript API for crypto-to-fiat exchanges across LATAM. Implemented U.S. bank account opening/linking to crypto wallets. Modularized the Flutter app for scalability and testability.'
  String get exp0Desc =>
      'Built a public-facing TypeScript API for crypto-to-fiat exchanges across LATAM. Implemented U.S. bank account opening/linking to crypto wallets. Modularized the Flutter app for scalability and testability.';

  /// en: 'Senior Flutter Engineer — SportsVisio'
  String get exp1Title => 'Senior Flutter Engineer — SportsVisio';

  /// en: 'Jan 2022 — Feb 2025 · Remote (US)'
  String get exp1Range => 'Jan 2022 — Feb 2025 · Remote (US)';

  /// en: 'Shipped SV Manager with background TUS uploads (−30% upload time). Delivered dual-view synchronized playback for 1200+ monthly users. Led Bloc-based rewrite (−35% code size). Built Android tracking with Kalman/Hungarian algorithms for single-angle recording.'
  String get exp1Desc =>
      'Shipped SV Manager with background TUS uploads (−30% upload time). Delivered dual-view synchronized playback for 1200+ monthly users. Led Bloc-based rewrite (−35% code size). Built Android tracking with Kalman/Hungarian algorithms for single-angle recording.';

  /// en: 'Team Lead, Senior Flutter Engineer — VisionBox'
  String get exp2Title => 'Team Lead, Senior Flutter Engineer — VisionBox';

  /// en: 'Jan 2024 — Jun 2024 · Remote (Canada)'
  String get exp2Range => 'Jan 2024 — Jun 2024 · Remote (Canada)';

  /// en: 'Led a team of four; integrated Health Connect/HealthKit for AI insights. Implemented KYC with Google ML Kit; Face verification pipeline; Subscriptions via RevenueCat.'
  String get exp2Desc =>
      'Led a team of four; integrated Health Connect/HealthKit for AI insights. Implemented KYC with Google ML Kit; Face verification pipeline; Subscriptions via RevenueCat.';

  /// en: 'Software Engineer (Freelance) — CourtAvenue'
  String get exp3Title => 'Software Engineer (Freelance) — CourtAvenue';

  /// en: 'Jul 2023 — Sep 2023 · Remote (US)'
  String get exp3Range => 'Jul 2023 — Sep 2023 · Remote (US)';

  /// en: 'Built Genjo (ChatGPT web wrapper) with Express/React; delivered ApiConnect in Flutter; internal tooling for multi-package repos; AI-driven passport/visa reader.'
  String get exp3Desc =>
      'Built Genjo (ChatGPT web wrapper) with Express/React; delivered ApiConnect in Flutter; internal tooling for multi-package repos; AI-driven passport/visa reader.';

  /// en: 'Flutter Engineer — Creative Advanced Technologies'
  String get exp4Title => 'Flutter Engineer — Creative Advanced Technologies';

  /// en: 'Sep 2021 — Mar 2022 · Remote (UAE)'
  String get exp4Range => 'Sep 2021 — Mar 2022 · Remote (UAE)';

  /// en: 'Launched food ordering and delivery tracking apps (50K+ downloads, 4.5★). Google Maps integration and backend coordination.'
  String get exp4Desc =>
      'Launched food ordering and delivery tracking apps (50K+ downloads, 4.5★). Google Maps integration and backend coordination.';

  /// en: 'Flutter Engineer — It-TechGroup'
  String get exp5Title => 'Flutter Engineer — It-TechGroup';

  /// en: 'Jan 2021 — Nov 2021 · Remote (AR)'
  String get exp5Range => 'Jan 2021 — Nov 2021 · Remote (AR)';

  /// en: 'Built a Flutter plugin to integrate MercadoPago Checkout SDK for Android/iOS (Java/Swift). Set up CI/CD for automated builds and tests.'
  String get exp5Desc =>
      'Built a Flutter plugin to integrate MercadoPago Checkout SDK for Android/iOS (Java/Swift). Set up CI/CD for automated builds and tests.';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on AppLocalizations {
  dynamic _flatMapFunction(String path) {
    return switch (path) {
      'metaTitleHome' => 'About — Tomás Sasovsky',
      'metaTitleProjects' => 'Projects — Tomás Sasovsky',
      'metaTitleContact' => 'Contact — Tomás Sasovsky',
      'siteTagline' => 'Sr. Flutter & Backend Engineer',
      'siteLocation' => 'Buenos Aires, Argentina',
      'navAbout' => 'About',
      'navProjects' => 'Projects',
      'navContact' => 'Contact',
      'heroBadge' => 'Available for new opportunities',
      'heroPrimaryCta' => 'Let\'s talk →',
      'heroSecondaryCta' => 'See my work',
      'statYearsExperience' => 'Years experience',
      'statProjectsShipped' => 'Projects shipped',
      'statContinentsServed' => 'Continents served',
      'statBugsSquashed' => 'Bugs squashed',
      'sectionAbout' => 'About me',
      'sectionWhoIAm' => 'Who I am',
      'sectionAboutSubtitle' => 'Engineer, builder, open-source contributor.',
      'sectionServices' => 'Services',
      'sectionWhatIDo' => 'What I do',
      'sectionExperience' => 'Experience',
      'sectionTrustedBy' => 'Trusted by',
      'sectionTestimonials' => 'Testimonials',
      'sectionWhatPeopleSay' => 'What people say',
      'portfolioLabel' => 'Portfolio',
      'projectsHeading' => 'Projects',
      'projectsSubtitle' =>
        ({required int projectCount}) =>
            '${projectCount} projects across mobile, backend, and open source.',
      'filterAll' => 'All',
      'filterApps' => 'Apps',
      'filterOss' => 'OSS / Tools',
      'projectUnreleased' => 'Unreleased',
      'contactGetInTouch' => 'Get in touch',
      'contactHeading' => 'Contact',
      'contactSubtitle' => 'Let\'s work together on something great.',
      'contactBookTitle' => 'Book a meeting',
      'contactBookLine1' => 'Pick a time that works for you using my calendar.',
      'contactBookLine2' => 'You\'ll get a confirmation and a video meeting link automatically.',
      'contactScheduleCall' => 'Schedule a call →',
      'contactOnlineTitle' => 'Find me online',
      'contactOnlineBody' =>
        'Reach out directly — always happy to chat about Flutter, interesting projects, or new opportunities.',
      'contactFormTitle' => 'Send a message',
      'contactFormDesc' => 'Fill out the form and I\'ll get back to you within a day or two.',
      'formName' => 'Name',
      'formNameHint' => 'Your name',
      'formEmail' => 'Email',
      'formEmailHint' => 'your@email.com',
      'formSubject' => 'Subject',
      'formSubjectHint' => 'What\'s this about?',
      'formMessage' => 'Message',
      'formMessageHint' => 'Tell me about your project, idea, or just say hi…',
      'formSend' => 'Send Message',
      'formSending' => 'Sending…',
      'formSuccess' => 'Message sent — I\'ll get back to you shortly.',
      'formErrorGeneric' => 'Something went wrong. Please try again.',
      'formErrorRequired' => 'Please fill in all fields.',
      'formErrorEmail' => 'Please enter a valid email address.',
      'footerCopyright' => ({required int year}) => '© ${year} Tomás Sasovsky · Built with ',
      'langSwitchEnglish' => 'EN',
      'langSwitchSpanish' => 'ES',
      'langSwitchLabel' => 'Language',
      'aboutP0' =>
        'I\'m a full-stack software engineer with 5+ years of professional experience, specialising in cross-platform mobile development with Flutter and Dart. I\'ve architected and delivered production Flutter applications used by real users at scale across fintech, sports tech, and health sectors.',
      'aboutP1' =>
        'My strengths include state management (Bloc, MVVM), Flutter layered architecture, clean architecture, and modern CI/CD practices. I also bring strong backend experience with TypeScript/Node.js, API integration (REST/GraphQL), and cloud infrastructure (GCP/AWS). I\'m comfortable leading teams and projects, driving complex technical initiatives from concept to production, and I care deeply about engineering excellence, scalable architecture, and exceptional user experiences.',
      'svc0Title' => 'Mobile app development',
      'svc0Desc' =>
        'Design and build reliable iOS/Android apps with modern architecture and great UX.',
      'svc1Title' => 'Backend & API development',
      'svc1Desc' => 'TypeScript/Node.js services, REST APIs, authentication, payments, and docs.',
      'svc2Title' => 'Web apps & front-end',
      'svc2Desc' =>
        'Responsive, accessible interfaces with performance in mind across all devices.',
      'svc3Title' => 'Integrations & DevOps',
      'svc3Desc' =>
        'Product integrations, monitoring, and CI/CD pipelines for dependable releases.',
      'svc4Title' => 'Open source contributions',
      'svc4Desc' =>
        'Active contributor to community tools and libraries; maintaining and shipping OSS.',
      'labelGooglePlay' => 'Google Play',
      'labelAppStore' => 'App Store',
      'labelWebsite' => 'Website',
      'labelDocumentation' => 'Documentation',
      'labelGithub' => 'GitHub',
      'labelDiscord' => 'Discord',
      'proj0Title' => 'El Dorado P2P',
      'proj0Desc' =>
        'A Stablecoin SuperApp for LATAM offering a USD wallet and a peer-to-peer marketplace across 70+ finance apps (PayPal, Zelle, PIX, MercadoPago, Nequi, and more). Built for reliability and ease of use to move value across borders, protect savings in USD, and enable P2P merchant workflows.',
      'proj1Title' => 'SportsVisio App',
      'proj1Desc' =>
        'SportsVisio delivers player stats, analysis, and highlights in a secure, simple-to-use app to elevate your game with game-changing AI technology.',
      'proj2Title' => 'SportsVisio Manager',
      'proj2Desc' =>
        'Publish schedules and upload game video. SportsVisio converts footage into player stats and highlights for easy review in the SportsVisio app.',
      'proj3Title' => 'SportsVisio Track',
      'proj3Desc' =>
        'Experimental native Android app for single-phone player/ball tracking. YOLO + MOT (Kalman + Hungarian), homography for court mapping. Kotlin (CameraX/MediaCodec), real-time and low power.',
      'proj4Title' => 'APIConnect',
      'proj4Desc' =>
        'Consumer app for API Abroad built with a modern stack and production-ready CI/CD. Emphasis on secure auth, dependable releases, and crisp UX to guide users through program discovery and onboarding.',
      'proj5Title' => 'TAZA Express',
      'proj5Desc' =>
        'Food ordering and delivery tracking for a high-volume marketplace. Implemented map integrations and streamlined order states for a predictable end-to-end experience.',
      'proj6Title' => 'Genjo',
      'proj6Desc' =>
        'AI-powered platform designed to transform browsers into buyers, enhance customer interactions, and generate leads. Offers personalised, 24/7 customer engagement, boosting conversions and average order values while reducing returns.',
      'proj7Title' => 'Genomii',
      'proj7Desc' =>
        'Health insights and guidance with device integrations and privacy-first design. Responsibilities covered integrations, subscriptions, and KYC/verification flows.',
      'proj8Title' => 'Go Router Guards',
      'proj8Desc' =>
        'Flexible and extensible guard system for Go Router with composable boolean logic and type-safe routes. Supports ALL/ANY/ONE-OF combinations, redirect semantics, and a GuardedRoute mixin. Includes examples and tests for robust, reusable route protection.',
      'proj9Title' => 'Radio Horizon (Dart)',
      'proj9Desc' =>
        'Discord radio playing bot with powerful song recognition technology. Identifies and announces songs currently playing on the radio, making it easy to keep track of your favourite tunes.',
      'proj10Title' => 'ncnn.dart',
      'proj10Desc' =>
        'Dart FFI bindings and tooling around Tencent NCNN for on-device neural inference. Targets mobile and desktop with zero-copy buffers where possible and pragmatic model loading. Useful for small, fast CNNs without heavyweight runtimes.',
      'proj11Title' => 'pytorch.dart',
      'proj11Desc' =>
        'Experimental Dart bindings for LibTorch/PyTorch to enable native tensor ops and model execution. Explores FFI surfaces for tensors, autograd, and model invocation from Flutter. Aimed at research/prototyping.',
      'proj12Title' => 'automatic_version_upgrader.dart',
      'proj12Desc' =>
        'CLI helper to automatically bump Dart/Flutter package versions and changelogs. Parses conventional commits, updates pubspec, and generates changelog entries with semantic versioning. Designed to fit CI pipelines.',
      'proj13Title' => 'tus_client',
      'proj13Desc' =>
        'Dart client for the TUS resumable upload protocol with reliable, restartable uploads. Handles chunking, retries, and metadata, with pluggable storage for resumption across app restarts. Great for large files and flaky networks.',
      'proj14Title' => 'radio-browser-api.dart',
      'proj14Desc' =>
        'Dart wrapper around the Radio Browser open API for discovering and streaming internet radio stations. Supports search by name, country, language, and tag, with typed models and a simple async interface.',
      'testiPageTitle' => 'Leave a Testimonial — Tomás Sasovsky',
      'testiPageHeading' => 'Leave a testimonial',
      'testiPageSubtitle' =>
        'If we\'ve worked together and you\'d like to share a few words, I\'d really appreciate it. Your feedback helps others understand what it\'s like to collaborate with me.',
      'testiPageExamplesTitle' => 'What others have said',
      'testiPageExamplesDesc' =>
        'Here are a few examples from past colleagues and clients — there\'s no required format, just write in your own words.',
      'testiPageFormTitle' => 'Your testimonial',
      'testiPageFormDesc' =>
        'I\'ll review it and add it to the site if it\'s a good fit. A sentence or two is great — a paragraph or more is even better.',
      'testiFormName' => 'Your name *',
      'testiFormNameHint' => 'Jane Smith',
      'testiFormRole' => 'Role / Company',
      'testiFormRoleHint' => 'CTO at Acme Corp (optional)',
      'testiFormLinkedin' => 'LinkedIn profile URL',
      'testiFormLinkedinHint' => 'https://linkedin.com/in/yourprofile (optional)',
      'testiFormTestimonial' => 'Your testimonial *',
      'testiFormTestimonialHint' =>
        'Write freely — a few sentences to a few paragraphs is perfect. Feel free to mention the project we worked on, what stood out, and anything you\'d tell someone considering working with me.',
      'testiFormErrorRequired' => 'Please fill in your name and testimonial.',
      'testiFormSuccess' =>
        'Thank you! Your testimonial has been submitted and I\'ll review it shortly.',
      'testiFormSubmit' => 'Submit testimonial',
      'testi0Date' => 'October 2025',
      'testi0P0' =>
        'I\'m excited to recommend Tomás as an outstanding software engineer. I\'ve had the unique privilege of working alongside Tomás at IT-TechGroup and later leading him as Team Lead at SportsVisio, witnessing his remarkable evolution from promising junior developer to all-star engineer.',
      'testi0P1' =>
        'What distinguishes Tomás is his unwavering reliability in delivering high-quality solutions. His work on background TUS upload optimization and Bloc-based architecture rewrite at SportsVisio exemplifies his ability to tackle complex, high-impact challenges.',
      'testi0P2' =>
        'Tomás thrives on difficult problems that would intimidate most engineers. I could confidently take holidays knowing he\'d handle any critical issue. Any organisation would be fortunate to have Tomás on their most challenging projects.',
      'testi1Date' => 'January 2025',
      'testi1P0' =>
        'I am thrilled to recommend Tomás Sasovsky as an exceptional Flutter Developer. Over the past three years, I\'ve had the pleasure of working with Tomás as both a coworker and his team lead, and his contributions to our team have been invaluable.',
      'testi1P1' =>
        'Tomás brings deep expertise in Flutter and mobile development, consistently delivering high-quality applications. His problem-solving skills and ability to write clean, scalable code have driven the success of numerous projects.',
      'testi1P2' =>
        'What truly sets Tomás apart is his collaborative spirit and dedication. He is a natural team player who shares knowledge generously, mentors junior developers, and fosters a positive work environment.',
      'testi2Date' => 'January 2025',
      'testi2P0' =>
        'I had the pleasure of working closely with Tomás for 2.5 years on a variety of projects, including the development of a complex Android native app that integrated an NDK-based machine learning model.',
      'testi2P1' =>
        'Throughout our time working together, he demonstrated exceptional technical expertise, particularly as a mobile Flutter developer, where his contributions elevated our capabilities in every area of the mobile stack.',
      'testi2P2' =>
        'One of his standout accomplishments was designing and implementing a robust CI/CD pipeline that streamlined our development process. I strongly recommend him to any team looking for a talented, forward-thinking mobile developer.',
      'testi3Date' => 'November 2021',
      'testi3P0' =>
        'Proactive and resolutive young developer. If he doesn\'t know how to do something he finds it out and gives results, always. He ensures to perform quality code and guarantees you for that.',
      'testi4Date' => 'November 2021',
      'testi4P0' =>
        'Tomás is a very talented young man. He has a solid knowledge of Flutter. He is very committed when he has project responsibilities. I recommend him as a co-worker or project leader, since he is always willing to learn more and help in a totally selfless way.',
      'exp0Title' => 'Full-Stack Developer — El Dorado P2P',
      'exp0Range' => 'Feb 2025 — Sep 2025 · Buenos Aires (Hybrid)',
      'exp0Desc' =>
        'Built a public-facing TypeScript API for crypto-to-fiat exchanges across LATAM. Implemented U.S. bank account opening/linking to crypto wallets. Modularized the Flutter app for scalability and testability.',
      'exp1Title' => 'Senior Flutter Engineer — SportsVisio',
      'exp1Range' => 'Jan 2022 — Feb 2025 · Remote (US)',
      'exp1Desc' =>
        'Shipped SV Manager with background TUS uploads (−30% upload time). Delivered dual-view synchronized playback for 1200+ monthly users. Led Bloc-based rewrite (−35% code size). Built Android tracking with Kalman/Hungarian algorithms for single-angle recording.',
      'exp2Title' => 'Team Lead, Senior Flutter Engineer — VisionBox',
      'exp2Range' => 'Jan 2024 — Jun 2024 · Remote (Canada)',
      'exp2Desc' =>
        'Led a team of four; integrated Health Connect/HealthKit for AI insights. Implemented KYC with Google ML Kit; Face verification pipeline; Subscriptions via RevenueCat.',
      'exp3Title' => 'Software Engineer (Freelance) — CourtAvenue',
      'exp3Range' => 'Jul 2023 — Sep 2023 · Remote (US)',
      'exp3Desc' =>
        'Built Genjo (ChatGPT web wrapper) with Express/React; delivered ApiConnect in Flutter; internal tooling for multi-package repos; AI-driven passport/visa reader.',
      'exp4Title' => 'Flutter Engineer — Creative Advanced Technologies',
      'exp4Range' => 'Sep 2021 — Mar 2022 · Remote (UAE)',
      'exp4Desc' =>
        'Launched food ordering and delivery tracking apps (50K+ downloads, 4.5★). Google Maps integration and backend coordination.',
      'exp5Title' => 'Flutter Engineer — It-TechGroup',
      'exp5Range' => 'Jan 2021 — Nov 2021 · Remote (AR)',
      'exp5Desc' =>
        'Built a Flutter plugin to integrate MercadoPago Checkout SDK for Android/iOS (Java/Swift). Set up CI/CD for automated builds and tests.',
      _ => null,
    };
  }
}
