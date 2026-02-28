# Smoke Test: Basic Navigation

## Purpose
Verify core navigation and page loading functionality works correctly.

## Prerequisites
- Application is running at configured base URL
- Playwright MCP server is available and connected

## Test Steps

### Step 1: Navigate to Homepage
```javascript
// Navigate to the homepage
mcp__playwright__browser_navigate({ url: "https://example.com" })

// Wait for main content to load
mcp__playwright__browser_wait_for({
  selector: "main, [role='main']",
  state: "visible"
})
```
**Expected**: Page loads successfully within timeout

### Step 2: Verify Page Structure
```javascript
// Get page snapshot to analyze DOM
mcp__playwright__browser_snapshot()

// Verify key elements via JavaScript
mcp__playwright__browser_evaluate({
  script: `({
    hasNav: !!document.querySelector('nav, [role="navigation"]'),
    hasMain: !!document.querySelector('main, [role="main"]'),
    hasFooter: !!document.querySelector('footer, [role="contentinfo"]'),
    title: document.title
  })`
})
```
**Expected**: All key landmarks present, title is correct

### Step 3: Test Navigation Links
```javascript
// Get all main navigation links
mcp__playwright__browser_evaluate({
  script: `Array.from(document.querySelectorAll('nav a')).map(a => ({
    text: a.textContent.trim(),
    href: a.href
  }))`
})

// Click first navigation link
mcp__playwright__browser_click({ selector: "nav a:first-child" })

// Wait for new page content
mcp__playwright__browser_wait_for({ selector: "main", state: "visible" })

// Take screenshot
mcp__playwright__browser_take_screenshot({ fullPage: true })
```
**Expected**: Navigation works, new page loads

### Step 4: Test Browser Back Navigation
```javascript
// Navigate back
mcp__playwright__browser_navigate_back()

// Verify we're back on homepage
mcp__playwright__browser_wait_for({ selector: "main", state: "visible" })
mcp__playwright__browser_snapshot()
```
**Expected**: Returns to previous page correctly

### Step 5: Check for JavaScript Errors
```javascript
// Get console messages
mcp__playwright__browser_console_messages()
```
**Expected**: No error-level console messages

### Step 6: Verify Network Requests
```javascript
// Check for failed requests
mcp__playwright__browser_network_requests()
```
**Expected**: No failed network requests (4xx, 5xx)

### Step 7: Final Screenshot
```javascript
mcp__playwright__browser_take_screenshot({ fullPage: true })
```
**Purpose**: Visual verification record

## Success Criteria
- [ ] Homepage loads within 3 seconds
- [ ] All major page sections visible (nav, main, footer)
- [ ] Navigation links functional
- [ ] No console errors
- [ ] No failed network requests
- [ ] Browser back button works

## Debugging

### If page doesn't load:
```javascript
mcp__playwright__browser_network_requests()
mcp__playwright__browser_console_messages()
```

### If elements not found:
```javascript
mcp__playwright__browser_snapshot()
// Check returned HTML for actual element structure
```

### If navigation fails:
```javascript
// Try more specific selector
mcp__playwright__browser_evaluate({
  script: `document.querySelectorAll('a').length`
})
```

## Cleanup
```javascript
// Always close browser when done
mcp__playwright__browser_close()
```
