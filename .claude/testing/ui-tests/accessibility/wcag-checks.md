# Accessibility Test: WCAG Compliance Checks

## Purpose
Verify pages meet WCAG 2.1 accessibility guidelines.

## Test Steps

### 1. Page Structure
```
Navigate to the page
Take accessibility snapshot
Verify heading hierarchy (h1 -> h2 -> h3)
Check for skip navigation link
```

### 2. Images
```
Find all images on page
Verify all images have alt text
Check alt text is descriptive
```

### 3. Form Labels
```
Find all form inputs
Verify each input has associated label
Check for required field indicators
```

### 4. Color Contrast
```
Take screenshot for manual review
Check text contrast ratios
Verify links are distinguishable
```

### 5. Keyboard Navigation
```
Press Tab to navigate through elements
Verify focus indicator is visible
Check all interactive elements are reachable
Press Enter to activate buttons
```

### 6. ARIA Landmarks
```
Take accessibility snapshot
Verify main, navigation, footer landmarks
Check for aria-labels on icons
```

## Expected Results
- Proper heading hierarchy
- All images have alt text
- All form inputs have labels
- Focus indicators visible
- Keyboard navigation works

## Common Issues to Check
- Missing alt text
- Low color contrast
- Missing form labels
- No focus indicators
- Inaccessible dropdown menus
