# Accessibility Test: A11y Checks

## Purpose
Verify application meets WCAG 2.1 accessibility standards.

## Test Areas
1. Keyboard Navigation
2. Screen Reader Compatibility
3. Color Contrast
4. Form Accessibility
5. Focus Management
6. ARIA Attributes

## Prerequisites
- Application accessible via MCP Playwright
- Understanding of WCAG 2.1 guidelines

## Test Cases

### TC-A01: Keyboard Navigation
```
Purpose: Verify all interactive elements accessible via keyboard

Steps:
1. Navigate to page
2. Tab through all elements
3. Verify visible focus indicators
4. Test Enter/Space activation

Actions:
mcp__playwright__browser_navigate({ url: "<BASE_URL>" })
mcp__playwright__browser_press_key({ key: "Tab" })
mcp__playwright__browser_snapshot()  // Verify focus visible
// Repeat Tab and verify focus order

Expected:
- Logical tab order
- Visible focus ring on all interactive elements
- No keyboard traps
```

### TC-A02: Skip Links
```
Purpose: Verify skip navigation links present

Steps:
1. Load page
2. Press Tab immediately
3. Verify skip link appears

Actions:
mcp__playwright__browser_navigate({ url: "<BASE_URL>" })
mcp__playwright__browser_press_key({ key: "Tab" })
mcp__playwright__browser_snapshot()

Expected:
- "Skip to main content" link visible on focus
- Link functional when activated
```

### TC-A03: Form Labels
```
Purpose: Verify all form inputs have associated labels

Actions:
mcp__playwright__browser_navigate({ url: "<FORM_URL>" })
mcp__playwright__browser_evaluate({
  script: `
    const inputs = document.querySelectorAll('input, select, textarea');
    const unlabeled = Array.from(inputs).filter(input => {
      const id = input.id;
      const label = document.querySelector('label[for="' + id + '"]');
      const ariaLabel = input.getAttribute('aria-label');
      const ariaLabelledBy = input.getAttribute('aria-labelledby');
      return !label && !ariaLabel && !ariaLabelledBy;
    });
    return unlabeled.map(el => el.name || el.id || 'unnamed');
  `
})

Expected:
- Empty array (all inputs have labels)
```

### TC-A04: ARIA Landmarks
```
Purpose: Verify proper ARIA landmark regions

Actions:
mcp__playwright__browser_evaluate({
  script: `
    const landmarks = {
      header: document.querySelectorAll('header, [role="banner"]').length,
      nav: document.querySelectorAll('nav, [role="navigation"]').length,
      main: document.querySelectorAll('main, [role="main"]').length,
      footer: document.querySelectorAll('footer, [role="contentinfo"]').length
    };
    return landmarks;
  `
})

Expected:
- At least 1 header, nav, main, and footer landmark
```

### TC-A05: Image Alt Text
```
Purpose: Verify all images have appropriate alt text

Actions:
mcp__playwright__browser_evaluate({
  script: `
    const images = document.querySelectorAll('img');
    return Array.from(images).map(img => ({
      src: img.src.slice(-30),
      alt: img.alt || '[MISSING]',
      decorative: img.alt === '' || img.role === 'presentation'
    }));
  `
})

Expected:
- All images have alt attribute
- Decorative images have empty alt or role="presentation"
- Informative images have descriptive alt
```

### TC-A06: Color Contrast Check
```
Purpose: Verify text has sufficient color contrast

Note: Full contrast checking requires specialized tools.
Basic check for common issues:

Actions:
mcp__playwright__browser_evaluate({
  script: `
    // Check for low contrast combinations
    const textElements = document.querySelectorAll('p, span, a, h1, h2, h3, h4, h5, h6, li, td, th');
    const issues = [];
    textElements.forEach(el => {
      const style = getComputedStyle(el);
      const color = style.color;
      const bg = style.backgroundColor;
      // Flag light gray text as potential issue
      if (color.includes('rgb(153') || color.includes('rgb(170')) {
        issues.push({ element: el.tagName, color, bg });
      }
    });
    return issues.slice(0, 10);  // Limit output
  `
})

Expected:
- No light gray text on white backgrounds
- Links visually distinct from regular text
```

### TC-A07: Focus Trap in Modals
```
Purpose: Verify focus trapped within open modals

Steps:
1. Open modal
2. Tab through all elements
3. Verify focus stays within modal

Actions:
mcp__playwright__browser_click({ selector: ".open-modal" })
mcp__playwright__browser_wait_for({ selector: ".modal", state: "visible" })
// Tab multiple times
mcp__playwright__browser_press_key({ key: "Tab" })
mcp__playwright__browser_press_key({ key: "Tab" })
mcp__playwright__browser_press_key({ key: "Tab" })
mcp__playwright__browser_snapshot()

Expected:
- Focus cycles within modal
- Escape closes modal
- Focus returns to trigger element on close
```

## WCAG 2.1 Quick Reference

| Level | Requirement | Check |
|-------|-------------|-------|
| A | Alt text for images | TC-A05 |
| A | Keyboard accessible | TC-A01 |
| A | Form labels | TC-A03 |
| A | Skip links | TC-A02 |
| AA | Color contrast 4.5:1 | TC-A06 |
| AA | Focus visible | TC-A01 |
| AA | Multiple ways | Navigation |
| AAA | Extended contrast | Enhanced |

## Tools Integration
For comprehensive a11y testing, consider:
- axe-core (can be injected via evaluate)
- Lighthouse accessibility audit
- Manual screen reader testing

## Injecting axe-core
```javascript
mcp__playwright__browser_evaluate({
  script: `
    const script = document.createElement('script');
    script.src = 'https://cdnjs.cloudflare.com/ajax/libs/axe-core/4.7.2/axe.min.js';
    document.head.appendChild(script);
    return new Promise(resolve => script.onload = resolve);
  `
})

// Then run audit
mcp__playwright__browser_evaluate({
  script: `axe.run().then(results => JSON.stringify(results.violations))`
})
```
