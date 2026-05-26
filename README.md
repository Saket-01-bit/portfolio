# Saket Jain — Flutter Portfolio

A high-end, dark-themed personal portfolio app built in Flutter.  
Inspired by the CodeNest design spec: video background, liquid glass cards, glowing accents, and animated reveals.

---

## ✨ Features

- **HLS Video Background** — Mux stream with 60% opacity and gradient overlays
- **Liquid Glass Card** — Frosted glass card with subtle border glow
- **Vertical Grid Lines** — Thin white lines at 25%, 50%, 75% (desktop)
- **Central Glow Ellipse** — Animated cyan/green atmospheric glow
- **Scroll-Triggered Reveals** — Every section fades and slides in on scroll
- **Responsive Layout** — Desktop (>900px) and mobile breakpoints
- **Sticky Nav Header** — Background appears on scroll, hamburger menu on mobile
- **Full-Screen Mobile Menu** — Animated overlay with staggered nav items
- **Project Cards** — Hover lift effect, accent colors per project, GitHub links
- **Skills Grid** — Categorized cards with hover states
- **Stats Panel** — Big-number highlights
- **Certifications & Leadership** — Clean glassmorphic cards
- **Contact Section** — Email CTA, social links, footer

---

## 📦 Dependencies

```yaml
dependencies:
  flutter_animate: ^4.5.0      # Staggered entry animations
  google_fonts: ^6.2.1         # Playfair Display, Space Grotesk, DM Sans, JetBrains Mono
  url_launcher: ^6.3.0         # GitHub, LinkedIn, email links
  video_player: ^2.8.6         # HLS video background
  visibility_detector: ^0.4.0+2 # Scroll-triggered reveals
```

---

## 🚀 Setup

### 1. Create a new Flutter project (or use existing)

```bash
flutter create saket_portfolio
cd saket_portfolio
```

### 2. Copy files

Replace the contents of your project with the files provided:

```
lib/
├── main.dart
├── screens/
│   └── home_screen.dart
├── widgets/
│   ├── hero_section.dart
│   ├── nav_header.dart
│   ├── projects_section.dart
│   ├── skills_section.dart
│   ├── about_section.dart
│   ├── contact_section.dart
│   └── common_widgets.dart
├── theme/
│   └── app_theme.dart
└── data/
    └── portfolio_data.dart
pubspec.yaml
```

### 3. Install dependencies

```bash
flutter pub get
```

### 4. Android — allow cleartext/HLS video

Add to `android/app/src/main/AndroidManifest.xml` inside `<application>`:

```xml
android:usesCleartextTraffic="true"
```

Also add internet permission above `<application>`:
```xml
<uses-permission android:name="android.permission.INTERNET"/>
```

### 5. iOS — allow arbitrary loads (for HLS)

Add to `ios/Runner/Info.plist`:

```xml
<key>NSAppTransportSecurity</key>
<dict>
  <key>NSAllowsArbitraryLoads</key>
  <true/>
</dict>
```

### 6. Run

```bash
flutter run
```

---

## 🎨 Customization

All content is in `lib/data/portfolio_data.dart` — update your name, links, projects, skills, etc.  
All colors and typography are in `lib/theme/app_theme.dart`.

---

## 📱 Platform Notes

| Platform | Video BG | Notes |
|----------|----------|-------|
| Android  | ✅       | Requires internet permission |
| iOS      | ✅       | Requires NSAppTransportSecurity |
| Desktop  | ✅       | Full layout with grid lines |

> If HLS video fails to load on any platform, the app gracefully falls back to the dark background — no crashes.

---

## 📁 File Structure

```
saket_portfolio/
├── lib/
│   ├── main.dart                  # App entry point
│   ├── screens/
│   │   └── home_screen.dart       # Scrollable page composer
│   ├── widgets/
│   │   ├── hero_section.dart      # Video bg, glass card, headline, CTAs
│   │   ├── nav_header.dart        # Sticky nav + mobile hamburger
│   │   ├── projects_section.dart  # Project cards with hover effects
│   │   ├── skills_section.dart    # Skills grid + stats
│   │   ├── about_section.dart     # Bio, education, leadership, certs
│   │   ├── contact_section.dart   # Email CTA, socials, footer
│   │   └── common_widgets.dart    # RevealOnScroll, GlassCard, AccentTag
│   ├── theme/
│   │   └── app_theme.dart         # Colors + text styles
│   └── data/
│       └── portfolio_data.dart    # All resume content
└── pubspec.yaml
```
