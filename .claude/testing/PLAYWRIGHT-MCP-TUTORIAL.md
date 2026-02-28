# Comprehensive Guide: Playwright MCP for UI Testing & Streamlit Development

A complete tutorial for using Playwright MCP server with Claude Code to build, test, and debug Streamlit applications efficiently.

---

## Configuration Summary

### MCP Server Setup
The Playwright MCP server is configured in `.claude/settings.local.json`:

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

### Pre-Approved Playwright Tools
All 19 Playwright MCP tools are pre-approved for seamless testing:

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

### Quick Verification
```bash
# Check if Playwright browsers are installed
npx playwright install chromium

# Verify MCP server connection in Claude Code
/mcp
```

---

## Table of Contents

1. [Introduction](#introduction)
2. [Understanding Playwright MCP](#understanding-playwright-mcp)
3. [Core Concepts](#core-concepts)
4. [Getting Started](#getting-started)
5. [Essential Commands Reference](#essential-commands-reference)
6. [Streamlit-Specific Testing Patterns](#streamlit-specific-testing-patterns)
7. [Debugging Workflows](#debugging-workflows)
8. [Automated Testing Strategies](#automated-testing-strategies)
9. [Advanced Techniques](#advanced-techniques)
10. [Best Practices](#best-practices)
11. [Troubleshooting Guide](#troubleshooting-guide)
12. [Real-World Examples](#real-world-examples)
13. [Efficient Streamlit Development Workflow](#efficient-streamlit-development-workflow)
14. [Quick Reference Card](#quick-reference-card)

---

## Introduction

### What is Playwright MCP?

Playwright MCP (Model Context Protocol) is a server that enables Claude Code to control a real web browser programmatically. This allows you to:

- **Navigate** to any URL and interact with web pages
- **Test** your Streamlit apps visually and functionally
- **Debug** UI issues by inspecting elements and monitoring console/network
- **Automate** repetitive testing workflows
- **Capture** screenshots for documentation or visual regression

### Why Use Playwright MCP for Streamlit Development?

| Traditional Approach | With Playwright MCP |
|---------------------|---------------------|
| Manually refresh browser | Claude navigates automatically |
| Describe bugs in words | Claude sees exactly what you see |
| Manual screenshot capture | Instant programmatic screenshots |
| Switch between terminal and browser | Single Claude Code interface |
| Guess at responsive issues | Test all viewport sizes instantly |

---

## Understanding Playwright MCP

### Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                      Claude Code                             │
│  ┌─────────────────────────────────────────────────────┐    │
│  │              Your Conversation                       │    │
│  │  "Navigate to my Streamlit app and test the form"   │    │
│  └─────────────────────────────────────────────────────┘    │
│                           │                                  │
│                           ▼                                  │
│  ┌─────────────────────────────────────────────────────┐    │
│  │           Playwright MCP Server                      │    │
│  │  • Receives commands from Claude                     │    │
│  │  • Controls browser via Playwright                   │    │
│  │  • Returns results/screenshots                       │    │
│  └─────────────────────────────────────────────────────┘    │
│                           │                                  │
└───────────────────────────│──────────────────────────────────┘
                            ▼
              ┌─────────────────────────┐
              │    Chromium Browser     │
              │  ┌───────────────────┐  │
              │  │  Your Streamlit   │  │
              │  │       App         │  │
              │  └───────────────────┘  │
              └─────────────────────────┘
```

### Available Tools

| Tool | Description | Common Use Case |
|------|-------------|-----------------|
| `browser_navigate` | Go to URL | Open your Streamlit app |
| `browser_snapshot` | Get DOM/accessibility tree | Understand page structure |
| `browser_take_screenshot` | Capture visual state | Document UI, find issues |
| `browser_click` | Click elements | Interact with buttons, links |
| `browser_type` | Type text | Fill inputs, search boxes |
| `browser_fill_form` | Fill multiple fields | Complete forms quickly |
| `browser_select_option` | Select dropdowns | Choose from selectboxes |
| `browser_press_key` | Keyboard input | Submit forms, shortcuts |
| `browser_wait_for` | Wait for conditions | Handle async loading |
| `browser_evaluate` | Run JavaScript | Custom DOM queries |
| `browser_console_messages` | View console logs | Debug JavaScript errors |
| `browser_network_requests` | Monitor network | Debug API calls |
| `browser_resize` | Change viewport | Test responsive design |
| `browser_close` | Close browser | Clean up session |

---

## Core Concepts

### 1. Element Selection

Playwright MCP uses accessibility-based selectors. When you take a snapshot, you'll see elements like:

```
- button "Submit" [ref=s1]
- textbox "Enter your name" [ref=s2]
- link "Learn More" [ref=s3]
```

You can reference elements by:
- **Text content**: "Click the Submit button"
- **Role and name**: "Click the button labeled Submit"
- **Reference ID**: "Click element ref=s1"

### 2. Streamlit Element Mapping

Streamlit widgets map to standard HTML elements:

| Streamlit Widget | HTML Element | Playwright Selector Strategy |
|-----------------|--------------|------------------------------|
| `st.button()` | `<button>` | By button text |
| `st.text_input()` | `<input type="text">` | By label text |
| `st.selectbox()` | `<select>` or custom | By label, then options |
| `st.slider()` | `<input type="range">` | By label |
| `st.checkbox()` | `<input type="checkbox">` | By label text |
| `st.radio()` | `<input type="radio">` | By option text |
| `st.file_uploader()` | `<input type="file">` | By label |
| `st.dataframe()` | `<div>` with table | By surrounding text |
| `st.plotly_chart()` | `<div>` with SVG/Canvas | By title or container |

### 3. Streamlit's Reactive Model

Streamlit reruns the entire script on each interaction. This means:

- **Wait after actions**: Always wait for the page to stabilize after clicking
- **State changes**: The URL may include query params for widget state
- **Loading indicators**: Watch for Streamlit's "Running..." indicator

---

## Getting Started

### Step 1: Start Your Streamlit App

```bash
# In your terminal
streamlit run your_app.py --server.port 8501
```

### Step 2: Navigate with Claude Code

Simply ask Claude:

```
Navigate to http://localhost:8501
```

### Step 3: Explore the Page

```
Take a screenshot of the current page
```

```
Take an accessibility snapshot to see all interactive elements
```

### Step 4: Interact

```
Click the "Generate Report" button
Fill the name field with "Test User"
Select "Option B" from the dropdown
```

---

## Essential Commands Reference

### Navigation

```markdown
# Basic navigation
Navigate to http://localhost:8501

# Navigate and wait for specific element
Navigate to http://localhost:8501 and wait for the sidebar to load

# Navigate back
Go back to the previous page

# Refresh
Refresh the current page
```

### Screenshots

```markdown
# Full page screenshot
Take a screenshot of the entire page

# Specific area
Take a screenshot of the sidebar

# Named screenshot for comparison
Take a screenshot and save it as "dashboard-v1"

# Multiple viewports
Take screenshots at mobile, tablet, and desktop sizes
```

### Interactions

```markdown
# Buttons
Click the "Submit" button
Click the download button in the sidebar

# Text inputs
Type "Hello World" in the search box
Fill the email field with "test@example.com"
Clear the input field and type new text

# Dropdowns/Selectbox
Select "Category A" from the filter dropdown
Choose the second option in the model selector

# Checkboxes
Check the "Enable advanced mode" checkbox
Uncheck the notifications option

# Sliders
Set the slider to 50
Adjust the date range slider

# File upload
Upload the file test-data.csv to the file uploader
```

### Waiting

```markdown
# Wait for element
Wait for the results table to appear

# Wait for loading to complete
Wait for the "Running..." indicator to disappear

# Wait for network
Wait for all API calls to complete

# Explicit wait
Wait 3 seconds for the chart to render
```

### Debugging

```markdown
# Console
Show me all console messages
Check for any JavaScript errors

# Network
Show all network requests
Check if any API calls failed

# DOM inspection
Get the accessibility snapshot
Show me the structure of the main content area
```

---

## Streamlit-Specific Testing Patterns

### Pattern 1: Widget State Testing

Test that widget interactions update the app correctly:

```markdown
1. Navigate to the Streamlit app
2. Take a screenshot of initial state
3. Change the selectbox from "Option A" to "Option B"
4. Wait for the app to rerun (watch for Running indicator to clear)
5. Take a screenshot of new state
6. Verify the displayed content changed appropriately
```

### Pattern 2: Session State Verification

Test that session state persists correctly:

```markdown
1. Navigate to the app
2. Enter "Test Value" in the persistent input
3. Click a button that triggers a rerun
4. Verify the input still contains "Test Value"
5. Take screenshot showing state persistence
```

### Pattern 3: Sidebar Navigation

Test multi-page apps via sidebar:

```markdown
1. Navigate to the app
2. Take accessibility snapshot of sidebar
3. Click "Page 2" in the sidebar navigation
4. Wait for new page content to load
5. Verify correct page is displayed
6. Take screenshot of Page 2
```

### Pattern 4: Data Display Testing

Test dataframes and tables:

```markdown
1. Navigate to the data view page
2. Take snapshot to see table structure
3. Verify expected columns are present
4. Check row count matches expected
5. Test sorting by clicking column headers
6. Test filtering if available
7. Take screenshot of filtered/sorted state
```

### Pattern 5: Chart Interaction

Test interactive charts (Plotly, Altair):

```markdown
1. Navigate to the chart page
2. Wait for chart to fully render
3. Take screenshot of initial chart
4. Hover over data points to test tooltips
5. Click legend items to toggle series
6. Test zoom/pan if enabled
7. Take screenshot of modified view
```

### Pattern 6: Form Submission Flow

Complete end-to-end form testing:

```markdown
1. Navigate to the form page
2. Take screenshot of empty form
3. Fill all required fields:
   - Name: "Test User"
   - Email: "test@example.com"
   - Category: select "Option B"
   - Agreement: check the checkbox
4. Take screenshot of filled form
5. Click Submit button
6. Wait for success message or results
7. Take screenshot of result
8. Check console for any errors
```

### Pattern 7: File Upload Testing

Test file upload functionality:

```markdown
1. Navigate to the upload page
2. Upload a test file (CSV, image, etc.)
3. Wait for upload processing
4. Verify file preview or confirmation appears
5. Check that data processing completed
6. Take screenshot of processed result
```

### Pattern 8: Responsive Layout Testing

Test Streamlit's responsive behavior:

```markdown
1. Navigate to the app
2. Test at desktop (1280x800):
   - Verify sidebar is visible
   - Verify columns layout correctly
   - Take screenshot
3. Test at tablet (768x1024):
   - Check if sidebar becomes collapsible
   - Verify content reflows
   - Take screenshot
4. Test at mobile (375x667):
   - Verify single-column layout
   - Check widget usability
   - Take screenshot
```

---

## Debugging Workflows

### Workflow 1: Visual Bug Investigation

When something looks wrong:

```markdown
1. Navigate to the problematic page
2. Take a full-page screenshot
3. Take an accessibility snapshot
4. Check console for errors:
   "Show me all console messages"
5. Check network for failed requests:
   "Show me any failed network requests"
6. Resize to different viewports to see if it's responsive-related
7. Evaluate specific CSS:
   "Run JavaScript to get computed styles of the header"
```

### Workflow 2: Performance Investigation

When the app feels slow:

```markdown
1. Navigate to the app
2. Start monitoring network requests
3. Perform the slow action (click button, load data)
4. Review network timeline:
   - Which requests took longest?
   - Are there unnecessary requests?
   - Are large payloads being transferred?
5. Check console for performance warnings
6. Document findings with screenshots
```

### Workflow 3: JavaScript Error Debugging

When functionality isn't working:

```markdown
1. Navigate to the page
2. Clear console and start fresh
3. Perform the action that fails
4. Immediately check console:
   "Show me all console errors"
5. Take screenshot of current state
6. Check if error prevents further interaction
7. Identify the error source and report
```

### Workflow 4: State Management Debugging

When app state seems incorrect:

```markdown
1. Navigate to the app
2. Take initial screenshot with state A
3. Perform action expected to change state
4. Wait for rerun to complete
5. Take screenshot - is it state B as expected?
6. Check URL for query params (Streamlit encodes some state)
7. Refresh page - does state persist or reset?
8. Document expected vs actual behavior
```

### Workflow 5: Cross-Browser Approximation

While Playwright MCP uses Chromium, you can catch many issues:

```markdown
1. Test standard functionality in default Chromium
2. Pay attention to:
   - CSS flexbox/grid layouts
   - Modern JavaScript features
   - Font rendering differences
3. Take screenshots at multiple viewport sizes
4. Note any browser-specific CSS used
5. Flag features that need manual cross-browser testing
```

---

## Automated Testing Strategies

### Strategy 1: Smoke Test Suite

Quick tests to verify basic functionality:

```markdown
## Smoke Test: App Launch
1. Navigate to http://localhost:8501
2. Wait for page load (no "Running..." indicator)
3. Verify title is correct
4. Verify sidebar renders
5. Verify main content area has expected sections
6. Take screenshot
7. Check console for errors
Result: Pass if no errors and expected elements present
```

### Strategy 2: Regression Test Suite

Tests to run after code changes:

```markdown
## Regression Test: Feature X
Prerequisites: Test data loaded, user logged in (if applicable)

1. Navigate to Feature X page
2. Verify initial state matches baseline screenshot
3. Test primary user flow:
   a. Select input option
   b. Click process button
   c. Verify output appears
4. Test edge cases:
   a. Empty input
   b. Maximum input
   c. Special characters
5. Take screenshots at each step
6. Compare with baseline screenshots
Result: Pass if all steps complete and match baseline
```

### Strategy 3: Visual Regression Testing

Catch unintended visual changes:

```markdown
## Visual Regression: Dashboard

Before (create baselines):
1. Navigate to dashboard at 1280x800
2. Take screenshot "dashboard-desktop-baseline"
3. Resize to 768x1024
4. Take screenshot "dashboard-tablet-baseline"
5. Resize to 375x667
6. Take screenshot "dashboard-mobile-baseline"

After (compare):
1. Repeat same navigation and screenshots
2. Compare new screenshots with baselines
3. Report any pixel differences > threshold
4. Review and approve intentional changes
```

### Strategy 4: Accessibility Testing

Verify app is accessible:

```markdown
## Accessibility Test Suite

1. Navigate to each major page
2. For each page:
   a. Take accessibility snapshot
   b. Verify heading hierarchy (h1 -> h2 -> h3)
   c. Check all images have alt text
   d. Verify form inputs have labels
   e. Test keyboard navigation:
      - Tab through all elements
      - Verify focus indicators visible
      - Check Enter activates buttons
   f. Check color contrast (manual review of screenshots)
3. Document any violations
4. Prioritize fixes by severity
```

### Strategy 5: Load State Testing

Test app behavior under different data conditions:

```markdown
## Load State Tests

1. Empty State:
   - Navigate with no data
   - Verify appropriate empty message
   - Take screenshot

2. Minimal Data:
   - Load 1-5 records
   - Verify correct display
   - Take screenshot

3. Typical Data:
   - Load 100-1000 records
   - Verify pagination/scrolling works
   - Check performance is acceptable

4. Large Data:
   - Load maximum expected records
   - Verify no crashes
   - Check memory/performance
   - Take screenshot of loaded state
```

---

## Advanced Techniques

### Technique 1: JavaScript Evaluation

Execute custom JavaScript for advanced testing:

```markdown
# Get Streamlit component count
Run JavaScript: document.querySelectorAll('[data-testid]').length

# Check if specific data is rendered
Run JavaScript: document.body.innerText.includes('Expected Text')

# Get computed styles
Run JavaScript: getComputedStyle(document.querySelector('.stButton button')).backgroundColor

# Measure element dimensions
Run JavaScript: document.querySelector('.stDataFrame').getBoundingClientRect()

# Check for memory leaks (approximate)
Run JavaScript: performance.memory.usedJSHeapSize
```

### Technique 2: Network Mocking Preparation

Identify API calls for mocking:

```markdown
1. Navigate to the app
2. Monitor network requests
3. Identify API endpoints:
   - Data fetching endpoints
   - Authentication endpoints
   - File upload endpoints
4. Document request/response shapes
5. Use this info to set up backend mocks for isolated testing
```

### Technique 3: State Injection via URL

Test specific states directly:

```markdown
# Streamlit encodes some widget state in URL
1. Set up desired widget state manually
2. Copy the URL with query parameters
3. Use this URL to test that specific state:
   Navigate to http://localhost:8501/?param=value

# Test deep linking
1. Navigate to specific page/state via URL
2. Verify correct state is restored
3. Verify no errors during state restoration
```

### Technique 4: Multi-Tab Testing

Test concurrent sessions:

```markdown
1. Navigate to app in first tab
2. Perform initial action
3. Open new tab with same app
4. Check if session state is shared or isolated
5. Perform action in second tab
6. Switch back to first tab
7. Verify expected behavior (shared vs isolated)
```

### Technique 5: Timing-Sensitive Testing

Test loading states and transitions:

```markdown
1. Navigate to the app
2. Immediately take screenshot to capture loading state
3. Wait for content to load
4. Take screenshot of loaded state
5. Trigger slow operation (data load, computation)
6. Take screenshot of loading/processing state
7. Wait for completion
8. Take final screenshot

Document the timing of transitions for UX review
```

---

## Best Practices

### 1. Consistent Test Environment

```markdown
Before each test session:
- Ensure Streamlit app is running fresh
- Clear browser cache if needed (close and reopen)
- Use consistent test data
- Document app version/commit being tested
```

### 2. Meaningful Screenshots

```markdown
Screenshot naming convention:
[page]-[state]-[viewport]-[timestamp]

Examples:
- dashboard-initial-desktop-20241226
- form-validation-error-mobile-20241226
- chart-filtered-tablet-20241226
```

### 3. Wait for Stability

```markdown
After any interaction with Streamlit:
1. Wait for "Running..." indicator to disappear
2. Wait for any loading spinners to clear
3. Wait for network requests to complete
4. Only then take screenshots or verify state
```

### 4. Atomic Test Steps

```markdown
Keep each test step independent:
- One action per step
- Clear verification after each action
- Don't chain too many actions without checkpoints
- Easy to identify exactly where failures occur
```

### 5. Document Assumptions

```markdown
At the start of each test:
- Document expected initial state
- List any required test data
- Note external dependencies
- Specify expected environment
```

### 6. Error Capture Protocol

```markdown
When an error occurs:
1. Immediately take screenshot
2. Capture console messages
3. Capture network requests
4. Document reproduction steps
5. Note environment details
```

### 7. Clean Up Sessions

```markdown
At the end of testing:
- Close browser to free resources
- Note any test data that was created
- Document any state changes made
- Report summary of findings
```

---

## Troubleshooting Guide

### Problem: Browser won't navigate

**Symptoms**: Navigation commands fail or timeout

**Solutions**:
1. Verify Streamlit app is running: `curl http://localhost:8501`
2. Check if port is correct
3. Try closing browser and navigating fresh
4. Verify MCP server is connected: `/mcp` in Claude Code

### Problem: Elements not found

**Symptoms**: Click or type commands fail to find elements

**Solutions**:
1. Take accessibility snapshot to see actual element names
2. Wait for page to fully load before interacting
3. Check if element is inside an iframe (rare in Streamlit)
4. Try alternative selectors (text, role, reference ID)
5. Scroll element into view first

### Problem: Screenshots are blank or incomplete

**Symptoms**: Screenshots show blank areas or missing content

**Solutions**:
1. Wait longer for content to render (especially charts)
2. Scroll to ensure content is in viewport
3. Check if content is loaded dynamically (wait for network)
4. Try full-page screenshot vs viewport screenshot

### Problem: Interactions don't trigger Streamlit rerun

**Symptoms**: Clicking buttons doesn't update the app

**Solutions**:
1. Verify clicking the correct element (Streamlit buttons have specific structure)
2. Wait and check if there's a "Running..." indicator
3. Try pressing Enter after clicking
4. Check console for JavaScript errors blocking interaction

### Problem: State not persisting

**Symptoms**: Widget values reset after actions

**Solutions**:
1. This is expected Streamlit behavior for non-session-state widgets
2. Verify session_state is used correctly in app code
3. Check if URL state encoding is working
4. Test that specific widget values are preserved

### Problem: Network requests timeout

**Symptoms**: Page loads hang or API calls fail

**Solutions**:
1. Check backend/API is running
2. Verify network connectivity
3. Check for CORS issues in console
4. Increase timeout settings if legitimate slow requests

### Problem: Inconsistent test results

**Symptoms**: Same test passes sometimes, fails others

**Solutions**:
1. Add explicit waits instead of relying on timing
2. Wait for specific elements rather than fixed time
3. Clear app state between test runs
4. Check for race conditions in test steps
5. Ensure consistent test data

---

## Real-World Examples

### Example 1: Testing a Data Dashboard

```markdown
# Scenario: Test the healthcare data dashboard

1. Start the app:
   - Ensure Streamlit is running on port 8501

2. Navigate and verify initial state:
   Navigate to http://localhost:8501
   Wait for the dashboard header to appear
   Take screenshot "dashboard-initial"

3. Test data filtering:
   Select "Last 7 Days" from the date range dropdown
   Wait for charts to update
   Verify the chart titles include "Last 7 Days"
   Take screenshot "dashboard-filtered-7days"

4. Test metric cards:
   Take accessibility snapshot
   Verify these metrics are displayed:
   - Total Patients
   - Active Cases
   - Completion Rate
   Take screenshot "dashboard-metrics"

5. Test chart interactions:
   Hover over the first bar in the bar chart
   Verify tooltip appears with data
   Click on a chart segment to drill down (if enabled)

6. Test responsive layout:
   Resize to 375x667 (mobile)
   Verify sidebar becomes hamburger menu
   Verify charts stack vertically
   Take screenshot "dashboard-mobile"

7. Check for errors:
   Show console messages
   Verify no JavaScript errors
   Check network for failed API calls

8. Clean up:
   Close browser
```

### Example 2: Testing a ML Model Interface

```markdown
# Scenario: Test the prediction model interface

1. Navigate to model page:
   Navigate to http://localhost:8501/Predict
   Take screenshot "predict-initial"

2. Test input validation:
   Click the "Predict" button without filling inputs
   Verify error message appears
   Take screenshot "predict-validation-error"

3. Fill model inputs:
   Fill "Patient Age" with "45"
   Select "Male" from "Gender" dropdown
   Fill "Lab Value A" with "120"
   Fill "Lab Value B" with "80"
   Take screenshot "predict-inputs-filled"

4. Run prediction:
   Click "Predict" button
   Wait for "Running..." to disappear
   Wait for prediction result to appear

5. Verify output:
   Take screenshot "predict-result"
   Verify probability score is displayed
   Verify confidence interval is shown
   Verify feature importance chart rendered

6. Test model explanation:
   Click "Show Explanation" expander
   Wait for SHAP plot to render
   Take screenshot "predict-explanation"

7. Test download:
   Click "Download Report" button
   Verify download initiated (check network)

8. Test edge cases:
   Fill extreme values and verify handling
   Fill invalid values and verify validation

9. Clean up:
   Close browser
```

### Example 3: Testing Multi-Page App Navigation

```markdown
# Scenario: Test navigation in multi-page Streamlit app

1. Start on home page:
   Navigate to http://localhost:8501
   Verify "Home" page content is displayed
   Take screenshot "nav-home"

2. Test sidebar navigation:
   Take accessibility snapshot of sidebar
   Verify these pages are listed:
   - Home
   - Data Explorer
   - Analytics
   - Settings

3. Navigate to Data Explorer:
   Click "Data Explorer" in sidebar
   Wait for page transition
   Verify Data Explorer content appears
   Verify URL changed appropriately
   Take screenshot "nav-data-explorer"

4. Navigate to Analytics:
   Click "Analytics" in sidebar
   Wait for charts to render
   Verify Analytics page displayed
   Take screenshot "nav-analytics"

5. Test browser back:
   Navigate back
   Verify returns to Data Explorer
   Take screenshot "nav-back-data"

6. Navigate to Settings:
   Click "Settings" in sidebar
   Verify Settings form appears
   Take screenshot "nav-settings"

7. Test direct URL navigation:
   Navigate to http://localhost:8501/Analytics
   Verify Analytics page loads directly
   Verify sidebar shows Analytics as selected

8. Test invalid URL:
   Navigate to http://localhost:8501/InvalidPage
   Verify 404 or redirect to home
   Take screenshot "nav-invalid"

9. Clean up:
   Close browser
```

### Example 4: Debugging Session State Issues

```markdown
# Scenario: Debug why form data isn't persisting

1. Set up debug session:
   Navigate to http://localhost:8501
   Take screenshot "debug-initial"

2. Fill form data:
   Fill "Name" with "Test User"
   Fill "Email" with "test@example.com"
   Take screenshot "debug-form-filled"

3. Trigger unrelated action:
   Click "Refresh Data" button (which causes rerun)
   Wait for rerun to complete

4. Check persistence:
   Take accessibility snapshot
   - Is Name field still "Test User"?
   - Is Email field still "test@example.com"?
   Take screenshot "debug-after-rerun"

5. Analyze results:
   If data cleared:
   - Widgets not using session_state
   - Key prop missing from widgets
   - Session being reset somewhere

   If data persisted:
   - Check for other cause of reported issue
   - Test specific reproduction steps

6. Check session state via URL:
   Look at URL parameters
   Note any encoded widget state

7. Test page refresh:
   Refresh the page
   Check which state survives
   Take screenshot "debug-after-refresh"

8. Document findings:
   - What persists across reruns
   - What persists across refreshes
   - Recommended fixes for code
```

---

## Efficient Streamlit Development Workflow

### The Claude Code + Playwright Development Loop

This workflow maximizes productivity by keeping you in a single Claude Code environment for coding, testing, and debugging.

```
┌─────────────────────────────────────────────────────────────────┐
│                    DEVELOPMENT LOOP                              │
│                                                                  │
│  ┌──────────┐     ┌──────────┐     ┌──────────┐     ┌────────┐ │
│  │  WRITE   │────▶│   RUN    │────▶│   TEST   │────▶│ DEBUG  │ │
│  │  CODE    │     │ STREAMLIT│     │ WITH     │     │ WITH   │ │
│  │          │     │          │     │PLAYWRIGHT│     │PLAYWRIGHT│
│  └──────────┘     └──────────┘     └──────────┘     └────────┘ │
│       ▲                                                    │    │
│       └────────────────────────────────────────────────────┘    │
│                         ITERATE                                  │
└─────────────────────────────────────────────────────────────────┘
```

### Step 1: Initial App Setup

```markdown
# Ask Claude to scaffold your Streamlit app
Create a Streamlit app with:
- Sidebar navigation
- Data upload functionality
- Interactive chart using Plotly
- Download results button

# Claude writes the code, then verify it works:
Start the Streamlit app and navigate to it
Take a screenshot of the initial state
```

### Step 2: Iterative Feature Development

```markdown
# Feature: Add a filter dropdown

1. Ask Claude to add the feature:
   "Add a category filter dropdown that updates the chart"

2. Immediately test:
   "Navigate to the app and test the new dropdown"
   "Select each option and verify the chart updates"
   "Take screenshots of each filter state"

3. Fix any issues:
   "The chart doesn't update when I select 'Category B'"
   "Check console for errors"
   "Fix the bug and test again"
```

### Step 3: Component-by-Component Building

Build complex UIs incrementally with immediate visual feedback:

```markdown
## Phase 1: Layout
"Create a 3-column layout with metrics cards"
→ Navigate and screenshot
→ Verify layout is correct
→ Fix any spacing issues

## Phase 2: Data Display
"Add a dataframe below the metrics"
→ Navigate and screenshot
→ Verify data displays correctly
→ Test sorting/filtering

## Phase 3: Interactivity
"Add click handlers to the metrics cards"
→ Navigate and test each card
→ Verify interactions work
→ Debug any issues

## Phase 4: Styling
"Apply custom CSS to match our brand colors"
→ Navigate and screenshot
→ Verify visual consistency
→ Test responsive layout
```

### Step 4: Real-Time Debugging Cycle

When something breaks:

```markdown
1. Identify the issue:
   "Navigate to the app - the chart isn't rendering"

2. Gather diagnostics:
   "Take a screenshot"
   "Show console errors"
   "Show network requests"

3. Analyze with context:
   Claude sees: Screenshot + Errors + Network + Your Code
   Claude suggests: Specific fix with context

4. Apply fix and verify:
   "Apply the fix to line 45"
   "Refresh and take a new screenshot"
   "Verify the chart now renders correctly"

5. Document the fix:
   Screenshot before/after for reference
```

### Efficient Testing Patterns for Streamlit

#### Pattern: Fast Iteration Testing

```markdown
# After each code change:
1. Save file
2. "Refresh the Streamlit app and take a screenshot"
3. "Check console for any new errors"
4. If issues → debug and fix
5. If good → continue to next change
```

#### Pattern: Widget State Testing Matrix

```markdown
# Create a systematic test of all widget combinations:

| Dropdown A | Dropdown B | Checkbox | Expected Result |
|------------|------------|----------|-----------------|
| Option 1   | Option X   | ☑        | Chart type A    |
| Option 1   | Option Y   | ☐        | Chart type B    |
| Option 2   | Option X   | ☑        | Chart type C    |
| Option 2   | Option Y   | ☐        | Chart type D    |

For each row:
1. Set widget states
2. Verify expected result
3. Take screenshot
4. Document pass/fail
```

#### Pattern: Session State Verification

```markdown
# Test session state persistence:

1. Set initial state:
   "Fill the form with test data"
   "Take screenshot as 'state-initial'"

2. Trigger rerun:
   "Click a button that causes rerun"
   "Wait for rerun to complete"

3. Verify persistence:
   "Take screenshot as 'state-after-rerun'"
   "Compare with initial - form data should persist"

4. Test refresh:
   "Refresh the page"
   "Take screenshot as 'state-after-refresh'"
   "Compare - what survives the refresh?"
```

### Streamlit Component Reference

#### Testing `st.button()`
```javascript
// Click a Streamlit button
mcp__playwright__browser_click({ selector: "button:has-text('Submit')" })
mcp__playwright__browser_wait_for({ selector: ".stSpinner", state: "hidden" })
```

#### Testing `st.text_input()`
```javascript
// Fill a text input (find by label)
mcp__playwright__browser_snapshot()  // Find the input ref
mcp__playwright__browser_type({ selector: "input[aria-label='Name']", text: "Test Value" })
```

#### Testing `st.selectbox()`
```javascript
// Select from a Streamlit selectbox
mcp__playwright__browser_click({ selector: "[data-testid='stSelectbox']" })
mcp__playwright__browser_click({ selector: "[role='option']:has-text('Option B')" })
```

#### Testing `st.slider()`
```javascript
// Adjust slider (use keyboard for precision)
mcp__playwright__browser_click({ selector: "[data-testid='stSlider']" })
mcp__playwright__browser_press_key({ key: "ArrowRight" })  // Increment
mcp__playwright__browser_press_key({ key: "ArrowRight" })  // Increment again
```

#### Testing `st.file_uploader()`
```javascript
// Upload a file
mcp__playwright__browser_file_upload({
  selector: "[data-testid='stFileUploader'] input[type='file']",
  paths: ["/path/to/test-file.csv"]
})
mcp__playwright__browser_wait_for({ selector: ".uploaded-file", state: "visible" })
```

#### Testing `st.dataframe()`
```javascript
// Verify dataframe content
mcp__playwright__browser_evaluate({
  script: `
    const df = document.querySelector('[data-testid="stDataFrame"]');
    const rows = df.querySelectorAll('tr').length;
    const cols = df.querySelectorAll('th').length;
    return { rows, cols };
  `
})
```

#### Testing `st.plotly_chart()`
```javascript
// Wait for Plotly chart to render
mcp__playwright__browser_wait_for({ selector: ".js-plotly-plot", state: "visible" })
mcp__playwright__browser_take_screenshot({ selector: ".js-plotly-plot", fullPage: false })

// Test chart interactivity
mcp__playwright__browser_hover({ selector: ".js-plotly-plot .trace" })
mcp__playwright__browser_snapshot()  // Check for tooltip
```

#### Testing Multi-Page Apps
```javascript
// Navigate between pages
mcp__playwright__browser_click({ selector: "[data-testid='stSidebar'] a:has-text('Page 2')" })
mcp__playwright__browser_wait_for({ selector: "[data-testid='stAppViewContainer']", state: "visible" })
```

### Streamlit-Specific Wait Strategies

```javascript
// Wait for Streamlit app to be ready
mcp__playwright__browser_wait_for({
  selector: "[data-testid='stAppViewContainer']",
  state: "visible"
})

// Wait for rerun to complete (spinner disappears)
mcp__playwright__browser_wait_for({
  selector: ".stSpinner",
  state: "hidden"
})

// Wait for data to load
mcp__playwright__browser_wait_for({
  selector: "[data-testid='stDataFrame']",
  state: "visible"
})

// Wait for chart to render
mcp__playwright__browser_evaluate({
  script: `
    new Promise(resolve => {
      const check = () => {
        if (document.querySelector('.js-plotly-plot')) resolve(true);
        else setTimeout(check, 100);
      };
      check();
    })
  `
})
```

### Performance Optimization Workflow

When your Streamlit app feels slow:

```markdown
1. Baseline measurement:
   "Navigate to the app and monitor network requests"
   "Note total load time and number of requests"

2. Identify bottlenecks:
   "Which API calls take longest?"
   "Are there unnecessary re-renders?"
   "Check console for performance warnings"

3. Optimize and measure:
   "Apply caching with @st.cache_data"
   "Navigate to app and compare load time"
   "Take before/after screenshots"

4. Verify improvements:
   "Perform the slow action 3 times"
   "Document average response time"
   "Confirm no functionality regression"
```

### Continuous Improvement Workflow

```markdown
## Daily Development Pattern

Morning:
1. Start Streamlit app
2. Run smoke tests:
   "Navigate to app, verify all pages load, no console errors"
3. Screenshot current state as baseline

During Development:
1. Make code changes
2. Test immediately:
   "Refresh and verify the change works"
3. Fix issues in real-time with visual context

Before Commit:
1. Full test pass:
   "Test all major user flows"
   "Verify responsive layout at 3 sizes"
   "Check accessibility snapshot"
2. Screenshot key states for documentation
3. Commit with confidence
```

---

## Quick Reference Card

### Essential Commands

| Action | Command |
|--------|---------|
| Open page | Navigate to http://localhost:8501 |
| Screenshot | Take a screenshot |
| See structure | Take accessibility snapshot |
| Click | Click the "Button Text" button |
| Type | Type "text" in the input field |
| Select | Select "Option" from dropdown |
| Wait | Wait for the element to appear |
| Debug | Show console messages |
| Network | Show network requests |
| Resize | Resize to 375x667 |
| Close | Close the browser |

### Streamlit Wait Patterns

```
Wait for the "Running..." text to disappear
Wait for the spinner to stop
Wait for the dataframe to appear
Wait for the chart to render
```

### Common Debugging Checks

```
Check console for errors
Check network for failed requests
Take accessibility snapshot
Get the page title
Show all buttons on the page
```

---

## Streamlit Cheat Sheet

### Common Selectors

| Streamlit Widget | Playwright Selector |
|-----------------|---------------------|
| Any button | `button:has-text('Button Label')` |
| Text input | `input[aria-label='Input Label']` |
| Number input | `input[type='number']` |
| Text area | `textarea[aria-label='Area Label']` |
| Selectbox | `[data-testid='stSelectbox']` |
| Multiselect | `[data-testid='stMultiSelect']` |
| Checkbox | `[data-testid='stCheckbox']` |
| Radio | `[role='radiogroup']` |
| Slider | `[data-testid='stSlider']` |
| Date input | `[data-testid='stDateInput']` |
| File uploader | `[data-testid='stFileUploader']` |
| Dataframe | `[data-testid='stDataFrame']` |
| Sidebar | `[data-testid='stSidebar']` |
| Main container | `[data-testid='stAppViewContainer']` |
| Expander | `[data-testid='stExpander']` |
| Tabs | `[data-testid='stTabs']` |
| Metric | `[data-testid='stMetric']` |

### Natural Language Commands for Claude

```markdown
# Navigation
"Navigate to my Streamlit app at localhost:8501"
"Go to the Analytics page"
"Click the sidebar link for Settings"

# Interaction
"Click the Submit button"
"Enter 'test@email.com' in the email field"
"Select 'Category B' from the dropdown"
"Check the 'Enable feature' checkbox"
"Set the slider to 75"
"Upload the file data.csv"

# Verification
"Take a screenshot of the current page"
"Check if the success message appeared"
"Verify the chart displays 5 data points"
"Confirm there are no console errors"

# Debugging
"Show me all network requests"
"Display console messages"
"What's the page title?"
"Get the text content of the results section"

# Responsive
"Resize to mobile view (375x667)"
"Take screenshots at desktop, tablet, and mobile sizes"
"Check if the menu becomes a hamburger on mobile"
```

### One-Line Test Sequences

```markdown
# Quick smoke test
Navigate to localhost:8501, wait for load, take screenshot, check console for errors

# Form submission test
Navigate to form, fill name with "Test", fill email with "test@test.com", click submit, wait for success message

# Responsive check
Navigate to app, screenshot at 1920x1080, resize to 768x1024, screenshot, resize to 375x667, screenshot

# Widget interaction
Navigate to app, select "Option B" from filter, wait for chart update, take screenshot

# Debug session
Navigate to page, show console errors, show failed network requests, take screenshot
```

### MCP Tool Syntax Quick Reference

```javascript
// Navigate
mcp__playwright__browser_navigate({ url: "http://localhost:8501" })

// Screenshot
mcp__playwright__browser_take_screenshot({ fullPage: true })
mcp__playwright__browser_take_screenshot({ selector: ".chart", fullPage: false })

// Click
mcp__playwright__browser_click({ selector: "button:has-text('Submit')" })

// Type
mcp__playwright__browser_type({ selector: "input[name='email']", text: "test@example.com" })

// Select
mcp__playwright__browser_select_option({ selector: "select", value: "option_value" })

// Wait
mcp__playwright__browser_wait_for({ selector: ".result", state: "visible" })
mcp__playwright__browser_wait_for({ selector: ".spinner", state: "hidden" })

// Resize
mcp__playwright__browser_resize({ width: 375, height: 667 })

// Evaluate
mcp__playwright__browser_evaluate({ script: "document.title" })

// Debug
mcp__playwright__browser_console_messages()
mcp__playwright__browser_network_requests()
mcp__playwright__browser_snapshot()

// Cleanup
mcp__playwright__browser_close()
```

---

## Conclusion

Playwright MCP transforms how you develop and test Streamlit applications by:

1. **Eliminating context switching** - Stay in Claude Code for both coding and testing
2. **Enabling visual debugging** - See exactly what users see through screenshots
3. **Automating repetitive tests** - Run consistent test flows quickly
4. **Catching regressions early** - Visual comparison catches unintended changes
5. **Improving accessibility** - Built-in accessibility snapshots reveal issues
6. **Accelerating iteration** - Test changes immediately without leaving the terminal

### Development Workflow Summary

```
┌────────────────────────────────────────────────────────────┐
│  1. WRITE CODE    → Claude edits your Streamlit app       │
│  2. RUN APP       → streamlit run app.py                  │
│  3. TEST VISUALLY → Navigate & screenshot with Playwright │
│  4. DEBUG         → Console/network inspection            │
│  5. FIX & REPEAT  → Apply fixes, test immediately         │
└────────────────────────────────────────────────────────────┘
```

Start with simple navigation and screenshots, then progressively add more sophisticated testing patterns as you become comfortable with the tools.

Remember: The goal is to build better apps faster. Use Playwright MCP as a tool to validate your work continuously throughout development, not just at the end.

---

## Related Files

- [PLAYWRIGHT-MCP-README.md](PLAYWRIGHT-MCP-README.md) - Quick reference documentation
- [config.json](config.json) - Test configuration settings
- [fixtures/test-data.json](fixtures/test-data.json) - Test data and viewports
- [helpers/common-actions.md](helpers/common-actions.md) - Common action patterns
- [ui-tests/smoke/](ui-tests/smoke/) - Smoke test scenarios
- [ui-tests/regression/](ui-tests/regression/) - Regression test scenarios
- [ui-tests/visual/](ui-tests/visual/) - Visual regression tests
- [ui-tests/accessibility/](ui-tests/accessibility/) - Accessibility tests

---

*Last updated: December 2024*
