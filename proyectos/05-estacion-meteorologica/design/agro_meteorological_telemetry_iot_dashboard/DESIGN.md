---
name: Agro-Meteorological Telemetry & IoT Dashboard
colors:
  surface: '#faf8ff'
  surface-dim: '#d2d9f4'
  surface-bright: '#faf8ff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f2f3ff'
  surface-container: '#eaedff'
  surface-container-high: '#e2e7ff'
  surface-container-highest: '#dae2fd'
  on-surface: '#131b2e'
  on-surface-variant: '#3f4850'
  inverse-surface: '#283044'
  inverse-on-surface: '#eef0ff'
  outline: '#707881'
  outline-variant: '#bfc7d2'
  surface-tint: '#006398'
  primary: '#006194'
  on-primary: '#ffffff'
  primary-container: '#007bb9'
  on-primary-container: '#fdfcff'
  inverse-primary: '#93ccff'
  secondary: '#006c49'
  on-secondary: '#ffffff'
  secondary-container: '#6cf8bb'
  on-secondary-container: '#00714d'
  tertiary: '#825100'
  on-tertiary: '#ffffff'
  tertiary-container: '#a36700'
  on-tertiary-container: '#fffbff'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#cce5ff'
  primary-fixed-dim: '#93ccff'
  on-primary-fixed: '#001d31'
  on-primary-fixed-variant: '#004b73'
  secondary-fixed: '#6ffbbe'
  secondary-fixed-dim: '#4edea3'
  on-secondary-fixed: '#002113'
  on-secondary-fixed-variant: '#005236'
  tertiary-fixed: '#ffddb8'
  tertiary-fixed-dim: '#ffb95f'
  on-tertiary-fixed: '#2a1700'
  on-tertiary-fixed-variant: '#653e00'
  background: '#faf8ff'
  on-background: '#131b2e'
  surface-variant: '#dae2fd'
typography:
  display-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 36px
    fontWeight: '700'
    lineHeight: 44px
    letterSpacing: -0.02em
  display-lg-mobile:
    fontFamily: Plus Jakarta Sans
    fontSize: 28px
    fontWeight: '700'
    lineHeight: 36px
    letterSpacing: -0.01em
  headline-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
    letterSpacing: -0.015em
  headline-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 20px
    fontWeight: '600'
    lineHeight: 28px
    letterSpacing: -0.01em
  headline-sm:
    fontFamily: Plus Jakarta Sans
    fontSize: 16px
    fontWeight: '600'
    lineHeight: 24px
    letterSpacing: -0.005em
  body-lg:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  body-sm:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '400'
    lineHeight: 16px
  telemetry-val-lg:
    fontFamily: JetBrains Mono
    fontSize: 32px
    fontWeight: '600'
    lineHeight: 36px
    letterSpacing: -0.03em
  telemetry-val-md:
    fontFamily: JetBrains Mono
    fontSize: 20px
    fontWeight: '500'
    lineHeight: 24px
    letterSpacing: -0.02em
  label-caps:
    fontFamily: JetBrains Mono
    fontSize: 11px
    fontWeight: '500'
    lineHeight: 16px
    letterSpacing: 0.06em
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  gutter: 1.5rem
  gutter-sm: 1rem
  margin: 2rem
  margin-mobile: 1rem
  space-xs: 0.25rem
  space-sm: 0.5rem
  space-md: 1rem
  space-lg: 1.5rem
  space-xl: 2rem
---

## Brand & Style
This design system defines a high-precision, mission-critical environmental intelligence interface tailored for field agronomists, weather station operators, and smart agriculture engineers. 

The aesthetic is anchored in **Technical Minimalism with Functional Tactility**: crisp white instrumentation cards sit elevated over a cool slate ground, prioritizing instantaneous data comprehension, visual stability, and high operational clarity. The interface rejects unnecessary embellishment, leveraging systematic spatial rhythm, pristine tabular typography, and distinct chromatic status indicators to communicate the health of remote sensor networks, atmospheric readings, and automated irrigation triggers.

## Colors
The palette balances an airy, slate-tinted canvas with deep structural contrast and calibrated semantic signaling.

- **Canvas & Containers**: Application canvas lives on `#F8FAFC`, stepping into pure `#FFFFFF` for primary telemetry cards, with structural dividing lines executed in `#E2E8F0`.
- **Text & Hierarchy**: Primary typography, axes, and critical indicators use `#0F172A`. Secondary labels, metadata, and unit notations use muted slate `#334155` and `#64748B`.
- **Primary Accent (Agro/Sky)**: `#0284C7` (interactive highlights, primary metrics, active navigation states) with a deeper shade `#0369A1` for focused states and high-contrast links.
- **Semantic Statuses**:
  - **Online / Healthy / Optimal**: `#10B981` (primary fill), `#059669` (borders, dense text).
  - **Caution / Threshold Warning**: `#F59E0B` (fill), `#D97706` (text and outlines).
  - **Fault / Sensor Offline / Critical**: `#EF4444` (fill), `#DC2626` (text and outlines).

## Typography
The system employs a tri-font pairing to address structural, textual, and machine-data demands:

- **Plus Jakarta Sans** anchors headers, section titles, and modal designations, offering clean geometry without sacrificing human readability.
- **Inter** provides high legibility at micro and regular body sizes for diagnostic narratives, system logs, form labels, and administrative inputs.
- **JetBrains Mono** is reserved strictly for real-time telemetry readouts, units (e.g., `mm/h`, `hPa`, `°C`, `m/s`), coordinates, station IDs, and timestamps, preventing layout shifts during numerical streaming.

## Layout & Spacing
The layout implements a persistent desktop-first architecture tailored for wide-aspect monitoring:

- **Sidebar Anchor**: A fixed 260px left-hand control and station navigation bar remains pinned across desktop screens, collapsing into an icon-only dock (72px) on medium screens.
- **Dashboard Grid**: The main canvas uses a 12-column fluid grid system framed by generous `2rem` outer page margins and `1.5rem` (`24px`) gutters between telemetry widgets.
- **Breakpoint Behavior**:
  - **Desktop (≥ 1280px)**: 12-column layout. High-density metrics cards span 3 or 4 columns; time-series chart containers span 8 or 12 columns.
  - **Tablet / Small Desktop (768px - 1279px)**: Sidebar shrinks to 72px; grid converts to an 8-column flow with `1rem` gutters.
  - **Mobile (< 768px)**: Canvas condenses to single-column stacking with `1rem` margins and `1rem` gaps. Sidebar shifts to a sliding bottom sheet or top drawer.

## Elevation & Depth
Depth is created through low-contrast perimeter definition combined with ultra-diffused atmospheric shadowing:

- **Base Cards**: Elevated with crisp `#FFFFFF` fill, bounded by a 1px continuous hairline outline using `#E2E8F0`, and softened by an ambient drop shadow: `0 1px 3px 0 rgba(15, 23, 42, 0.04), 0 4px 12px 0 rgba(15, 23, 42, 0.03)`.
- **Hover & Active States**: Interactive telemetry tiles elevate slightly, shifting borders to `#CBD5E1` and expanding shadows to `0 8px 24px -4px rgba(15, 23, 42, 0.08)`.
- **Flyouts & Modals**: Calibration popovers and alert inspection dialogs use an intensified tier: `0 20px 25px -5px rgba(15, 23, 42, 0.1), 0 8px 10px -6px rgba(15, 23, 42, 0.05)`, backed by a `#0F172A` backdrop mask at 30% opacity with a 2px blur.
- **Strict Prohibition**: Pure solid black shadows and raw high-saturation glow halos are disallowed; all depth must retain the cool blue-gray cast of the canvas.

## Shapes
The design system adopts a balanced structural curve profile:

- **Standard Cards & Modals (`rounded-xl` / `1rem`)**: Telemetry cards, charts, and map containers maintain `16px` outer border radii, softening the high density of numerical data.
- **Interactive Controls (`rounded-lg` / `0.5rem`)**: Buttons, text inputs, dropdown triggers, and filter chips utilize `8px` corner radii for consistent touch-point familiarity.
- **Status Dots & Micro Indicators (`rounded-full`)**: Pulse indicators, sensor online pings, and notification counters are strictly circular (`9999px`).

## Components

### Telemetry & Metric Cards
- **Structure**: White card (`rounded-xl`), 1px `#E2E8F0` border, `1.5rem` internal padding.
- **Header**: Includes sensor label (`label-caps`, uppercase, `#64748B`), station sync timestamp, and semantic status dot.
- **Core Value**: Displayed in `JetBrains Mono` (`telemetry-val-lg`, `#0F172A`), coupled with an inline unit suffix (`14px`, `#64748B`).
- **Footer**: Visual delta indicator displaying 24-hour variance with trending directional icons.

### Buttons & Controls
- **Primary**: Solid `#0284C7` background, white text (`Inter`, 14px, semibold), 8px radius. Hover shifts to `#0369A1`.
- **Secondary / Outlined**: `#FFFFFF` background, `#E2E8F0` border, `#334155` text. Hover shifts border to `#CBD5E1` and background to `#F8FAFC`.
- **Danger (Critical Action)**: Transparent background with `#DC2626` outline, shifting to solid `#EF4444` on destructive trigger.

### Sensor Status Badges & Chips
- **Tokens**: Compact padding (`2px 8px`), `rounded-md`, `label-caps` font weight.
- **Online**: 10% opacity `#10B981` background, `#059669` text, paired with a radiating animated emerald ping dot.
- **Warning**: 10% opacity `#F59E0B` background, `#D97706` text.
- **Offline / Alert**: 10% opacity `#EF4444` background, `#DC2626` text.

### Form Inputs & Dropdowns
- **Input Fields**: Height `40px`, background `#FFFFFF`, border `1px solid #E2E8F0`, corner radius `8px`, typography `Inter 14px`.
- **Focus State**: Border shifts to `#0284C7` accompanied by a subtle focus ring `0 0 0 3px rgba(2, 132, 199, 0.15)`.
- **Station Selectors**: Monospaced station ID chips pre-pended to descriptive farm names.

### Data Tables & Event Logs
- **Grid Lines**: Horizontal dividing lines only (`#F1F5F9`), zero vertical borders.
- **Header**: Sticky `#F8FAFC` background, `label-caps` typography, `#64748B`.
- **Row States**: Alternate hover feedback with `#F8FAFC`. Critical alerts highlight with a left-edge 3px solid border in `#EF4444`.