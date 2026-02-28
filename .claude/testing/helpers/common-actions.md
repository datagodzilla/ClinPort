# Common UI Testing Actions

Quick reference for Playwright MCP actions in Claude Code.

## Navigation

### Navigate to URL
```
mcp__playwright__browser_navigate({ url: "https://example.com" })
```

### Navigate Back
```
mcp__playwright__browser_navigate_back()
```

### Get Current Page Snapshot
```
mcp__playwright__browser_snapshot()
```

## Element Interactions

### Click Element
```javascript
// By CSS selector
mcp__playwright__browser_click({ selector: "button.submit" })

// By text content
mcp__playwright__browser_click({ selector: "text=Submit" })

// By test ID
mcp__playwright__browser_click({ selector: "[data-testid='login-button']" })

// By role
mcp__playwright__browser_click({ selector: "role=button[name='Submit']" })
```

### Hover Element
```javascript
mcp__playwright__browser_hover({ selector: ".dropdown-trigger" })
```

### Type Text
```javascript
mcp__playwright__browser_type({
  selector: "input[name='email']",
  text: "user@example.com"
})
```

### Fill Form Fields
```javascript
mcp__playwright__browser_fill_form({
  selector: "form#login",
  values: {
    "email": "user@example.com",
    "password": "securepassword"
  }
})
```

### Select Dropdown Option
```javascript
mcp__playwright__browser_select_option({
  selector: "select#country",
  value: "US"
})
```

### Press Key
```javascript
mcp__playwright__browser_press_key({ key: "Enter" })
mcp__playwright__browser_press_key({ key: "Tab" })
mcp__playwright__browser_press_key({ key: "Escape" })
```

### File Upload
```javascript
mcp__playwright__browser_file_upload({
  selector: "input[type='file']",
  paths: ["/path/to/file.pdf"]
})
```

## Waiting

### Wait for Element
```javascript
// Wait for element to be visible
mcp__playwright__browser_wait_for({
  selector: ".loading-complete",
  state: "visible"
})

// Wait for element to be hidden
mcp__playwright__browser_wait_for({
  selector: ".spinner",
  state: "hidden"
})

// Wait for element to be attached to DOM
mcp__playwright__browser_wait_for({
  selector: ".dynamic-content",
  state: "attached"
})
```

## Screenshots

### Full Page Screenshot
```javascript
mcp__playwright__browser_take_screenshot({ fullPage: true })
```

### Element Screenshot
```javascript
mcp__playwright__browser_take_screenshot({
  selector: ".chart-container",
  fullPage: false
})
```

## Browser Control

### Resize Viewport
```javascript
mcp__playwright__browser_resize({
  width: 375,
  height: 667
})  // iPhone SE size
```

### Handle Dialogs
```javascript
// Accept alert/confirm
mcp__playwright__browser_handle_dialog({ action: "accept" })

// Dismiss dialog
mcp__playwright__browser_handle_dialog({ action: "dismiss" })

// Accept with prompt text
mcp__playwright__browser_handle_dialog({
  action: "accept",
  promptText: "My input"
})
```

### Close Browser
```javascript
mcp__playwright__browser_close()
```

## Debugging

### Get Console Messages
```javascript
mcp__playwright__browser_console_messages()
```

### Get Network Requests
```javascript
mcp__playwright__browser_network_requests()
```

### Execute JavaScript
```javascript
mcp__playwright__browser_evaluate({
  script: "document.title"
})

mcp__playwright__browser_evaluate({
  script: "document.querySelectorAll('.item').length"
})
```

### Get All Tabs
```javascript
mcp__playwright__browser_tabs()
```

## Selector Best Practices

Priority order for selectors:
1. **Role + name**: `role=button[name='Submit']` - Most accessible
2. **data-testid**: `[data-testid='submit-btn']` - Stable for testing
3. **Visible text**: `text=Submit` - User-centric
4. **CSS selectors**: `.btn-primary` - Last resort

## Common Patterns

### Login Flow
```javascript
// Navigate to login page
mcp__playwright__browser_navigate({ url: "https://app.example.com/login" })

// Wait for form
mcp__playwright__browser_wait_for({ selector: "form#login", state: "visible" })

// Fill credentials
mcp__playwright__browser_type({ selector: "input[name='email']", text: "user@example.com" })
mcp__playwright__browser_type({ selector: "input[name='password']", text: "password123" })

// Submit
mcp__playwright__browser_click({ selector: "button[type='submit']" })

// Wait for redirect
mcp__playwright__browser_wait_for({ selector: ".dashboard", state: "visible" })
```

### Form Validation Test
```javascript
// Submit empty form
mcp__playwright__browser_click({ selector: "button[type='submit']" })

// Check for error messages
mcp__playwright__browser_snapshot()
// Verify error elements are visible

// Screenshot for visual verification
mcp__playwright__browser_take_screenshot({ fullPage: false })
```

### Responsive Design Test
```javascript
// Desktop view
mcp__playwright__browser_resize({ width: 1920, height: 1080 })
mcp__playwright__browser_take_screenshot({ fullPage: true })

// Tablet view
mcp__playwright__browser_resize({ width: 768, height: 1024 })
mcp__playwright__browser_take_screenshot({ fullPage: true })

// Mobile view
mcp__playwright__browser_resize({ width: 375, height: 667 })
mcp__playwright__browser_take_screenshot({ fullPage: true })
```
