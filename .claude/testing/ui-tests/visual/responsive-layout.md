# Visual Test: Responsive Layout

## Purpose
Verify UI renders correctly across all device sizes and breakpoints.

## Prerequisites
- Application is running
- Playwright MCP server connected
- Screenshots folder accessible

## Viewports to Test

| Device | Width | Height | Notes |
|--------|-------|--------|-------|
| Desktop Large | 1920 | 1080 | Full HD |
| Desktop | 1366 | 768 | Common laptop |
| Laptop | 1280 | 800 | MacBook |
| Tablet Landscape | 1024 | 768 | iPad landscape |
| Tablet Portrait | 768 | 1024 | iPad portrait |
| Mobile Large | 414 | 896 | iPhone 11 Pro Max |
| Mobile | 375 | 667 | iPhone SE/8 |
| Mobile Small | 320 | 568 | iPhone 5 |

## Test Procedure

### Desktop Large (1920x1080)
```javascript
mcp__playwright__browser_resize({ width: 1920, height: 1080 })
mcp__playwright__browser_navigate({ url: "https://example.com" })
mcp__playwright__browser_wait_for({ selector: "main", state: "visible" })
mcp__playwright__browser_take_screenshot({ fullPage: true })

// Verify full navigation visible
mcp__playwright__browser_evaluate({
  script: `!document.querySelector('.hamburger, .menu-toggle')`
})
```
**Expected**: Full horizontal navigation, multi-column layout, sidebar visible

### Desktop Standard (1366x768)
```javascript
mcp__playwright__browser_resize({ width: 1366, height: 768 })
mcp__playwright__browser_take_screenshot({ fullPage: true })

// Check for horizontal overflow
mcp__playwright__browser_evaluate({
  script: `document.body.scrollWidth <= document.body.clientWidth`
})
```
**Expected**: No horizontal scrolling, layout intact

### Tablet Landscape (1024x768)
```javascript
mcp__playwright__browser_resize({ width: 1024, height: 768 })
mcp__playwright__browser_take_screenshot({ fullPage: true })
```
**Expected**: Layout may condense, navigation still visible

### Tablet Portrait (768x1024)
```javascript
mcp__playwright__browser_resize({ width: 768, height: 1024 })
mcp__playwright__browser_take_screenshot({ fullPage: true })

// Check if hamburger menu appears
mcp__playwright__browser_evaluate({
  script: `!!document.querySelector('.hamburger, .menu-toggle, [aria-label*="menu"]')`
})
```
**Expected**: Navigation may collapse to hamburger, content reflows

### Mobile Large (414x896)
```javascript
mcp__playwright__browser_resize({ width: 414, height: 896 })
mcp__playwright__browser_take_screenshot({ fullPage: true })
```
**Expected**: Single column layout, mobile navigation

### Mobile (375x667)
```javascript
mcp__playwright__browser_resize({ width: 375, height: 667 })
mcp__playwright__browser_take_screenshot({ fullPage: true })

// Test hamburger menu if present
mcp__playwright__browser_click({ selector: ".hamburger, .menu-toggle" })
mcp__playwright__browser_wait_for({ selector: ".mobile-nav, .nav-open", state: "visible" })
mcp__playwright__browser_take_screenshot({ fullPage: false })

// Close menu
mcp__playwright__browser_press_key({ key: "Escape" })
```
**Expected**: Hamburger menu works, content readable

### Mobile Small (320x568)
```javascript
mcp__playwright__browser_resize({ width: 320, height: 568 })
mcp__playwright__browser_take_screenshot({ fullPage: true })

// Verify touch targets are adequate (44px minimum)
mcp__playwright__browser_evaluate({
  script: `
    const buttons = document.querySelectorAll('button, a, input, [role="button"]');
    const tooSmall = Array.from(buttons).filter(el => {
      const rect = el.getBoundingClientRect();
      return rect.width < 44 || rect.height < 44;
    });
    return tooSmall.length;
  `
})
```
**Expected**: No content overflow, adequate touch targets

## Verification Checklist

### Desktop (1280px+)
- [ ] Full navigation visible
- [ ] Multi-column layout renders
- [ ] Sidebar visible
- [ ] Images full size
- [ ] Hover states work

### Tablet (768-1024px)
- [ ] Navigation adapts appropriately
- [ ] Content reflows to fewer columns
- [ ] Touch-friendly buttons
- [ ] Readable text size
- [ ] No horizontal scroll

### Mobile (<768px)
- [ ] Single column layout
- [ ] Hamburger/mobile menu works
- [ ] Stacked elements
- [ ] No horizontal scroll
- [ ] Adequate tap targets (44x44px min)
- [ ] Readable font sizes

## Common Issues to Check

### Horizontal Scrolling
```javascript
mcp__playwright__browser_evaluate({
  script: `document.body.scrollWidth > document.body.clientWidth`
})
// Should return false
```

### Overlapping Elements
```javascript
mcp__playwright__browser_evaluate({
  script: `
    // Visual inspection via screenshot
    // Check for elements with negative margins that may overlap
    const positioned = document.querySelectorAll('[style*="position: absolute"]');
    return positioned.length;
  `
})
```

### Cut-off Text
```javascript
mcp__playwright__browser_evaluate({
  script: `
    const textEls = document.querySelectorAll('p, h1, h2, h3, span');
    const cutOff = Array.from(textEls).filter(el =>
      el.scrollWidth > el.clientWidth
    );
    return cutOff.length;
  `
})
```

## Screenshot Naming Convention
```
{timestamp}-{viewport}-{page}-{state}.png

Examples:
- 20251226-mobile-homepage-initial.png
- 20251226-tablet-form-hamburger-open.png
- 20251226-desktop-dashboard-loaded.png
```

## Cleanup
```javascript
mcp__playwright__browser_close()
```
