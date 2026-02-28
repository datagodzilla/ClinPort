# Common Test Command Patterns

Quick reference for Playwright MCP commands in Claude Code.

## Navigation Commands

### Basic Navigation
```
Navigate to https://example.com
```

### Navigate and Wait
```
Navigate to https://example.com and wait for the page to fully load
```

### Navigate Back
```
Navigate back to the previous page
```

## Screenshot Commands

### Full Page Screenshot
```
Take a full-page screenshot
```

### Element Screenshot
```
Take a screenshot of the header element
```

### Named Screenshot
```
Take a screenshot and save it as "homepage-desktop"
```

## Interaction Commands

### Click Element
```
Click the button with text "Submit"
Click the element with selector "#login-btn"
```

### Fill Form Fields
```
Fill the email field with "test@example.com"
Type "Hello World" into the search input
```

### Select Options
```
Select "Option 2" from the dropdown menu
```

### Keyboard Actions
```
Press Enter key
Press Tab to move to next field
Press Escape to close the modal
```

## Wait Commands

### Wait for Element
```
Wait for the loading spinner to disappear
Wait for the results list to appear
```

### Wait for Network
```
Wait for all network requests to complete
Wait for the API response
```

## Debugging Commands

### Console Messages
```
Show me the console messages from the page
Check for any JavaScript errors in console
```

### Network Monitoring
```
Show me all network requests made by the page
Check for any failed network requests
```

### Page Snapshot
```
Take an accessibility snapshot of the current page
Get the DOM structure of the page
```

## Viewport Commands

### Resize Browser
```
Resize the browser to mobile size (375x667)
Resize to desktop view (1280x800)
```

## Multi-Step Test Patterns

### Login Flow
```
1. Navigate to the login page
2. Fill email with "user@example.com"
3. Fill password with "password123"
4. Click the login button
5. Wait for dashboard to load
6. Verify the welcome message appears
7. Take a screenshot
```

### Form Submission
```
1. Navigate to the contact form
2. Fill name with "Test User"
3. Fill email with "test@example.com"
4. Fill message with "Test message"
5. Click submit
6. Wait for success message
7. Verify confirmation appears
```

### Responsive Testing
```
1. Navigate to homepage
2. Take screenshot at desktop size
3. Resize to tablet (768x1024)
4. Take screenshot
5. Resize to mobile (375x667)
6. Take screenshot
7. Compare layouts
```

### Accessibility Check
```
1. Navigate to the page
2. Take accessibility snapshot
3. List all interactive elements
4. Check for missing alt text on images
5. Verify proper heading hierarchy
```

## Error Handling

### Check for Errors
```
Check if there are any console errors
Look for any 404 or 500 errors in network requests
```

### Handle Dialogs
```
Accept the confirmation dialog
Dismiss the alert popup
Enter "confirm" in the prompt dialog
```

## Cleanup

### Close Browser
```
Close the browser when done
```
