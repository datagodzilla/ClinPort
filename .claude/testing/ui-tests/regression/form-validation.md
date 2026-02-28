# Regression Test: Form Validation

## Purpose
Verify all form validations work correctly after code changes.

## Test Scope
- Required field validation
- Email format validation
- Password requirements
- Error message display
- Success state handling

## Prerequisites
- Application running with form page accessible
- Test data from fixtures/test-data.json

## Test Cases

### TC-001: Required Fields Validation
```
Steps:
1. Navigate to form page
2. Submit empty form
3. Verify error messages appear

Actions:
mcp__playwright__browser_navigate({ url: "<BASE_URL>/form" })
mcp__playwright__browser_click({ selector: "button[type='submit']" })
mcp__playwright__browser_snapshot()

Expected:
- Error messages for each required field
- Form not submitted
- Focus on first error field
```

### TC-002: Email Validation
```
Steps:
1. Enter invalid email formats from fixtures
2. Trigger validation
3. Verify error message

Actions:
For each invalid email in fixtures.invalidInputs.emails:
  mcp__playwright__browser_type({ selector: "input[name='email']", text: "<invalid_email>" })
  mcp__playwright__browser_press_key({ key: "Tab" })
  mcp__playwright__browser_snapshot()
  Clear field and continue

Expected:
- "Invalid email format" error displayed
- Field highlighted
```

### TC-003: Password Requirements
```
Steps:
1. Enter passwords that don't meet requirements
2. Verify appropriate error messages

Actions:
mcp__playwright__browser_type({ selector: "input[name='password']", text: "abc" })
mcp__playwright__browser_snapshot()

Expected:
- "Password must be at least 8 characters" message
```

### TC-004: Successful Submission
```
Steps:
1. Fill form with valid data from fixtures
2. Submit
3. Verify success state

Actions:
mcp__playwright__browser_fill_form({
  selector: "form",
  values: fixtures.formData.signupForm
})
mcp__playwright__browser_click({ selector: "button[type='submit']" })
mcp__playwright__browser_wait_for({ selector: ".success-message", state: "visible" })
mcp__playwright__browser_take_screenshot({ fullPage: false })

Expected:
- Success message displayed
- Form cleared or redirected
- No error messages
```

### TC-005: Error Recovery
```
Steps:
1. Submit form with errors
2. Fix errors
3. Resubmit
4. Verify success

Expected:
- Error messages clear when fixed
- Form submits successfully after corrections
```

## Success Criteria
- [ ] All required fields validated
- [ ] Email format properly validated
- [ ] Password requirements enforced
- [ ] Error messages clear and helpful
- [ ] Success state displays correctly
- [ ] No JavaScript errors

## Test Data
Reference: `fixtures/test-data.json`
