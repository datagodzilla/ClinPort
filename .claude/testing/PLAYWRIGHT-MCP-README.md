# UI Testing with Playwright MCP

Complete setup for UI testing, debugging, and browser automation using Playwright MCP server with Claude Code.

---

## Configuration Summary

### MCP Server Settings
Updated [settings.local.json](../settings.local.json) with:
- Playwright MCP server configuration (`npx @playwright/mcp@latest`)
- All 19 Playwright browser tools pre-approved
- Screenshot logging hook

### Folder Structure Overview
```
.claude/testing/
├── README.md                      # Complete documentation
├── config.json                    # Browser/test configuration
├── fixtures/
│   └── test-data.json            # Users, viewports, form data
├── helpers/
│   └── common-actions.md         # Quick reference guide
├── reports/                       # Test execution logs
├── screenshots/                   # Captured screenshots
└── ui-tests/
    ├── smoke/
    │   └── basic-navigation.md   # Quick sanity tests
    ├── regression/
    │   └── form-validation.md    # Form testing scenarios
    ├── visual/
    │   └── responsive-layout.md  # Responsive design tests
    └── accessibility/
        └── a11y-checks.md        # WCAG compliance tests
```

### Available Playwright Tools by Category

| Category | Tools |
|----------|-------|
| Navigation | `browser_navigate`, `browser_navigate_back`, `browser_tabs` |
| Interaction | `browser_click`, `browser_hover`, `browser_type`, `browser_fill_form`, `browser_press_key`, `browser_select_option`, `browser_drag` |
| Screenshots | `browser_take_screenshot`, `browser_snapshot` |
| Waiting | `browser_wait_for` |
| Debugging | `browser_console_messages`, `browser_network_requests`, `browser_evaluate` |
| Viewport | `browser_resize` |
| Dialogs | `browser_handle_dialog` |
| Files | `browser_file_upload` |
| Lifecycle | `browser_close`, `browser_install` |

---

## Quick Start

### 1. Verify MCP Server is Running
The Playwright MCP server is configured in `.claude/settings.local.json` and starts automatically when Claude Code loads.

### 2. Basic Test Example
```javascript
// Navigate to a page
mcp__playwright__browser_navigate({ url: "https://example.com" })

// Wait for content
mcp__playwright__browser_wait_for({ selector: "main", state: "visible" })

// Take a screenshot
mcp__playwright__browser_take_screenshot({ fullPage: true })

// Clean up
mcp__playwright__browser_close()
```

## Available Playwright Tools

| Tool | Description | Common Use |
|------|-------------|------------|
| `browser_navigate` | Navigate to a URL | Page loading |
| `browser_snapshot` | Get DOM accessibility tree | Element discovery |
| `browser_take_screenshot` | Capture screenshots | Visual verification |
| `browser_click` | Click elements | Buttons, links, menus |
| `browser_hover` | Hover over elements | Dropdowns, tooltips |
| `browser_drag` | Drag and drop | Sortable lists, sliders |
| `browser_type` | Type text | Text inputs |
| `browser_fill_form` | Fill multiple fields | Forms |
| `browser_press_key` | Press keyboard keys | Tab, Enter, Escape |
| `browser_select_option` | Select dropdown options | Select elements |
| `browser_file_upload` | Upload files | File inputs |
| `browser_handle_dialog` | Handle dialogs | Alerts, confirms |
| `browser_evaluate` | Execute JavaScript | Custom assertions |
| `browser_wait_for` | Wait for conditions | Loading states |
| `browser_tabs` | Manage tabs | Multi-tab tests |
| `browser_navigate_back` | Go back | Navigation testing |
| `browser_network_requests` | Monitor network | API debugging |
| `browser_console_messages` | View console | Error detection |
| `browser_resize` | Change viewport | Responsive testing |
| `browser_close` | Close browser | Cleanup |

## Folder Structure

```
testing/
├── README.md                 # This documentation
├── config.json               # Test configuration settings
├── fixtures/                 # Test data and fixtures
│   └── test-data.json        # Users, viewports, form data
├── helpers/                  # Utility documentation
│   └── common-actions.md     # Quick reference for actions
├── reports/                  # Test execution reports
│   └── screenshots.log       # Screenshot history
├── screenshots/              # Captured screenshots
└── ui-tests/                 # Test scenarios by category
    ├── accessibility/        # A11y and WCAG tests
    │   └── a11y-checks.md    # Accessibility checklist
    ├── regression/           # Feature regression tests
    │   └── form-validation.md
    ├── smoke/                # Quick smoke tests
    │   └── basic-navigation.md
    └── visual/               # Visual regression tests
        └── responsive-layout.md
```

## Test Categories

### Smoke Tests (`ui-tests/smoke/`)
Quick sanity checks for basic functionality:
- Homepage loads
- Navigation works
- No console errors
- Key elements visible

### Regression Tests (`ui-tests/regression/`)
Comprehensive feature verification:
- Form validation
- User authentication
- CRUD operations
- Error handling

### Accessibility Tests (`ui-tests/accessibility/`)
WCAG 2.1 compliance:
- Keyboard navigation
- Screen reader compatibility
- Color contrast
- ARIA landmarks
- Form labels

### Visual Tests (`ui-tests/visual/`)
Responsive design verification:
- Desktop (1920x1080)
- Laptop (1366x768)
- Tablet (768x1024)
- Mobile (375x667)

## Configuration

### MCP Server (`settings.local.json`)
```json
{
  "mcpServers": {
    "playwright": {
      "type": "stdio",
      "command": "npx",
      "args": ["@playwright/mcp@latest"],
      "env": {
        "PLAYWRIGHT_BROWSERS_PATH": "/Users/Wolverine/Library/Caches/ms-playwright"
      }
    }
  }
}
```

### Test Data (`fixtures/test-data.json`)
Contains:
- Test user credentials
- Viewport sizes for responsive testing
- Form data for input tests
- Invalid inputs for validation testing
- Environment URLs (local, staging, production)

## Common Patterns

### Login Flow
```javascript
mcp__playwright__browser_navigate({ url: "https://app.example.com/login" })
mcp__playwright__browser_wait_for({ selector: "form", state: "visible" })
mcp__playwright__browser_type({ selector: "input[name='email']", text: "user@example.com" })
mcp__playwright__browser_type({ selector: "input[name='password']", text: "password" })
mcp__playwright__browser_click({ selector: "button[type='submit']" })
mcp__playwright__browser_wait_for({ selector: ".dashboard", state: "visible" })
```

### Responsive Screenshot Series
```javascript
const viewports = [
  { width: 1920, height: 1080 },
  { width: 768, height: 1024 },
  { width: 375, height: 667 }
];

for (const vp of viewports) {
  mcp__playwright__browser_resize(vp)
  mcp__playwright__browser_take_screenshot({ fullPage: true })
}
```

### Form Validation Test
```javascript
mcp__playwright__browser_click({ selector: "button[type='submit']" })
mcp__playwright__browser_snapshot()  // Check for error messages
mcp__playwright__browser_evaluate({
  script: `document.querySelectorAll('.error').length`
})
```

### Console Error Check
```javascript
mcp__playwright__browser_console_messages()
// Filter for 'error' level messages
```

## Debugging

### Element Not Found
```javascript
// Get page snapshot to see actual structure
mcp__playwright__browser_snapshot()

// Check element count
mcp__playwright__browser_evaluate({
  script: `document.querySelectorAll('button').length`
})
```

### Page Load Issues
```javascript
// Check network requests
mcp__playwright__browser_network_requests()

// Check for JavaScript errors
mcp__playwright__browser_console_messages()
```

### Screenshot Issues
```javascript
// Try element-specific screenshot
mcp__playwright__browser_take_screenshot({
  selector: ".main-content",
  fullPage: false
})
```

## Best Practices

1. **Always wait for elements** - Use `browser_wait_for` before interacting
2. **Use semantic selectors** - Prefer `role=`, `text=`, `data-testid` over CSS
3. **Take screenshots at key points** - Document test progress
4. **Check for errors** - Monitor console and network
5. **Clean up** - Always close browser when done
6. **Use fixtures** - Store test data in `fixtures/test-data.json`

## Troubleshooting

### Browser Not Launching
```bash
# Reinstall browsers
npx playwright install chromium
```

### Timeout Errors
Increase timeout or use explicit waits:
```javascript
mcp__playwright__browser_wait_for({
  selector: ".slow-loading",
  state: "visible",
  timeout: 30000
})
```

### Permission Denied
Ensure MCP tools are allowed in `settings.local.json`:
```json
{
  "permissions": {
    "allow": ["mcp__playwright__*"]
  }
}
```

## Integration with Skills

This testing setup integrates with:
- **playwright-web-extraction** skill for content capture
- **research-orchestration** skill for research workflows
- **blog-publishing** skill for visual verification

## Related Files
- [.claude/settings.local.json](../.claude/settings.local.json) - MCP configuration
- [.claude/skills/playwright-web-extraction/](../.claude/skills/playwright-web-extraction/) - Extraction skill
- [helpers/common-actions.md](helpers/common-actions.md) - Quick reference
