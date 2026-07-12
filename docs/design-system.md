---
name: Systematic Enterprise UI
colors:
  surface: '#fcf8fa'
  surface-dim: '#dcd9db'
  surface-bright: '#fcf8fa'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f6f3f5'
  surface-container: '#f0edef'
  surface-container-high: '#eae7e9'
  surface-container-highest: '#e4e2e4'
  on-surface: '#1b1b1d'
  on-surface-variant: '#45464d'
  inverse-surface: '#303032'
  inverse-on-surface: '#f3f0f2'
  outline: '#76777d'
  outline-variant: '#c6c6cd'
  surface-tint: '#565e74'
  primary: '#000000'
  on-primary: '#ffffff'
  primary-container: '#131b2e'
  on-primary-container: '#7c839b'
  inverse-primary: '#bec6e0'
  secondary: '#505f76'
  on-secondary: '#ffffff'
  secondary-container: '#d0e1fb'
  on-secondary-container: '#54647a'
  tertiary: '#000000'
  on-tertiary: '#ffffff'
  tertiary-container: '#271901'
  on-tertiary-container: '#98805d'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#dae2fd'
  primary-fixed-dim: '#bec6e0'
  on-primary-fixed: '#131b2e'
  on-primary-fixed-variant: '#3f465c'
  secondary-fixed: '#d3e4fe'
  secondary-fixed-dim: '#b7c8e1'
  on-secondary-fixed: '#0b1c30'
  on-secondary-fixed-variant: '#38485d'
  tertiary-fixed: '#fcdeb5'
  tertiary-fixed-dim: '#dec29a'
  on-tertiary-fixed: '#271901'
  on-tertiary-fixed-variant: '#574425'
  background: '#fcf8fa'
  on-background: '#1b1b1d'
  surface-variant: '#e4e2e4'
typography:
  headline-lg:
    fontFamily: Inter
    fontSize: 30px
    fontWeight: '600'
    lineHeight: 36px
    letterSpacing: -0.02em
  headline-lg-mobile:
    fontFamily: Inter
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
  headline-md:
    fontFamily: Inter
    fontSize: 20px
    fontWeight: '600'
    lineHeight: 28px
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
  label-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '500'
    lineHeight: 20px
  label-sm:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.05em
  code:
    fontFamily: JetBrains Mono
    fontSize: 13px
    fontWeight: '400'
    lineHeight: 20px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  unit: 4px
  container-max: 1440px
  gutter: 24px
  margin-mobile: 16px
  margin-desktop: 32px
---

## Brand & Style

This design system is engineered for high-velocity IT operations, where clarity and trust are paramount. The aesthetic follows a **Modern Corporate** direction—balancing the rigorous structure of enterprise software with the refined UI polish of contemporary SaaS. 

The focus is on "Information Density without Clutter," utilizing ample white space, a strictly governed color palette, and high-readability typography to reduce cognitive load during critical incident management. The emotional response should be one of calm control, professional efficiency, and systemic reliability.

## Colors

The palette is anchored by "Enterprise Blue" (#0F172A), used for primary actions and structural navigation to establish authority. 

- **Primary:** Used for the most important "call to action" buttons and active states.
- **Surface:** A tiered neutral scale (Slate) provides depth. #FFFFFF for primary cards, #F8FAFC for background canvas areas.
- **Semantic:** Status colors are high-chroma to ensure immediate recognition of ticket urgency. Success (Resolved), Warning (Pending/SLA Risk), Danger (Overdue/Urgent), and Info (New/In-Progress).
- **Interactive:** Use 10% opacity overlays of the primary color for hover states on neutral elements.

## Typography

The design system utilizes **Inter** for all UI elements to ensure maximum legibility across dense data tables and complex forms. 

- **Headlines:** Use Semi-Bold (600) weights with slight negative letter-spacing for a modern, compact look.
- **Body:** Standard body text is 14px (body-md) to accommodate the data-heavy nature of help desk interfaces.
- **Labels:** Use Medium (500) for form labels and Bold (600) for small caps badges.
- **Monospace:** For ticket IDs, system logs, or technical snippets, use a monospaced font at a slightly smaller scale.

## Layout & Spacing

The system follows a **Fixed-Fluid Hybrid** model. The sidebar navigation remains fixed at 280px (collapsible to 64px), while the main content area utilizes a fluid 12-column grid.

- **Spacing Scale:** An 8pt grid system is the default, with a 4px "half-step" for tight component internal spacing (e.g., icon-to-text).
- **Margins:** 32px padding for main dashboard containers; 16px for mobile views.
- **Tables:** Dense layout for ticket queues (12px vertical padding on rows), wider spacing for settings and documentation pages.

## Elevation & Depth

This design system uses a **Tonal Layering** approach combined with **Low-Contrast Outlines**. Depth is used sparingly to signify interactivity and priority.

- **Flat Level:** The main background canvas (#F8FAFC).
- **Level 1 (Cards/Sidebar):** White surface with a 1px border (#E2E8F0). No shadow.
- **Level 2 (Dropdowns/Modals):** White surface with a 1px border and a "Soft Shadow": `0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1)`.
- **Active State:** Elements being dragged or high-priority popovers use a more pronounced ambient shadow to separate from the grid.

## Shapes

The shape language is structured and professional. A standard **0.5rem (8px)** corner radius is applied to most UI components (Buttons, Inputs, Cards). 

- **Standard (rounded):** 8px for primary containers.
- **Large (rounded-lg):** 12px for modals and large surface areas.
- **Full (pill):** Reserved strictly for status badges/tags and search bars to distinguish them from actionable buttons.

## Components

### Buttons
- **Primary:** Solid #0F172A with white text. 8px radius.
- **Secondary:** White background with #E2E8F0 border and #0F172A text.
- **Ghost:** No background or border; text changes to #1E293B on hover with a subtle grey background fill.

### Inputs & Selects
- 1px solid #E2E8F0 border, 8px radius. 
- Focus state: 2px ring of #3B82F6 (Info) with 0px offset.
- Labels are placed above the field in `label-md` style.

### Status Badges (Chips)
- Subdued background (10% opacity of status color) with high-contrast text of the same hue.
- Pill-shaped (full roundedness).
- Accompanied by a 6px solid dot for visual "live" status.

### Cards
- White background, 1px #E2E8F0 border.
- 16px to 24px internal padding.
- Header sections within cards should have a subtle bottom border.

### Data Tables
- Header row uses `label-sm` with a background of #F8FAFC.
- Row hover state: #F1F5F9.
- Vertical alignment: Middle. Horizontal padding: 16px.

### Ticket Timeline
- Vertical 2px line in #E2E8F0 connecting circular status nodes.
- Comment bubbles use Level 1 elevation (white card).