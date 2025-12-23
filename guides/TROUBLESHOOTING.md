# Troubleshooting Guide

## Common Errors

### "Email service not configured"
- **Fix**: Check all OAuth2 variables are set in `.env` and restart dev server

### "OAuth2 credentials not configured"
- **Fix**: Verify all GOOGLE_* variables are present and names match exactly (case-sensitive)

### "Failed to get OAuth2 access token"
- **Fix**: 
  - Regenerate refresh token: `node get-refresh-token.js`
  - Update `GOOGLE_REFRESH_TOKEN` in `.env`
  - Restart dev server
  - Verify Gmail API is enabled in Google Cloud Console

### "Invalid grant" error
- **Fix**: Refresh token expired or revoked - regenerate using `node get-refresh-token.js`

### "Redirect URI mismatch"
- **Fix**: Ensure OAuth client type is "Web application" with redirect URI `http://localhost:3000/callback`

### Form shows success but no email
- **Fix**: 
  - Check server logs for errors
  - Verify Gmail API is enabled
  - Check spam folder
  - Verify `CONTACT_EMAIL` matches `GOOGLE_USER_EMAIL` or is authorized

### "Username and Password not accepted"
- **Fix**: This shouldn't occur with Gmail API. Verify OAuth2 setup is correct and not using SMTP

## Quick Checklist

- [ ] `.env` file exists in project root
- [ ] All OAuth2 variables set (GOOGLE_CLIENT_ID, GOOGLE_CLIENT_SECRET, GOOGLE_REFRESH_TOKEN, GOOGLE_USER_EMAIL)
- [ ] CONTACT_EMAIL is set
- [ ] Dev server restarted after creating/updating `.env`
- [ ] Gmail API enabled in Google Cloud Console
- [ ] OAuth2 client created (type: "Web application")
- [ ] Redirect URI is `http://localhost:3000/callback`
- [ ] Refresh token is valid (test with `node get-refresh-token.js`)

## Debug Steps

1. **Check server terminal** - Error messages are logged there
2. **Check browser console** - Look for network errors (F12 → Console)
3. **Test API endpoint**:
   ```bash
   curl -X POST http://localhost:4321/api/contact \
     -H "Content-Type: application/json" \
     -d '{"name":"Test","email":"test@example.com","subject":"Test","message":"Test"}'
   ```
4. **Verify OAuth2 setup** - Run `node get-refresh-token.js` to test credentials
5. **Verify refresh token** - Check [Google Account Security](https://myaccount.google.com/security) → "Third-party apps" to ensure app is authorized
