# GitHub Publication Instructions (Updated)

Your repository is ready to publish! Follow these steps:

## Step 1: Install GitHub CLI

```bash
# Install the gh binary (requires password)
sudo mv /tmp/gh_2.42.1_macOS_amd64/bin/gh /usr/local/bin/

# Verify installation
gh --version
```

## Step 2: Authenticate with GitHub

```bash
gh auth login
```

Follow the prompts:
- What account do you want to log into? **GitHub.com**
- What is your preferred protocol? **HTTPS**
- Authenticate Git with your GitHub credentials? **Yes**
- How would you like to authenticate? **Login with a web browser**

Copy the one-time code shown and press Enter. Your browser will open - paste the code there.

## Step 3: Create Repository on GitHub

```bash
gh repo create googleSandy/gti-mcp-standalone \
    --public \
    --description "Standalone MCP server for Google Threat Intelligence" \
    --source=. \
    --remote=origin
```

## Step 4: Push Code

```bash
# Push all commits to GitHub
git push -u origin main
```

## Step 5: Add Repository Topics

```bash
gh repo edit googleSandy/gti-mcp-standalone \
    --add-topic mcp \
    --add-topic model-context-protocol \
    --add-topic threat-intelligence \
    --add-topic virustotal \
    --add-topic google-threat-intelligence \
    --add-topic security \
    --add-topic python \
    --add-topic mcp-server
```

## Step 6: Create Initial Release

```bash
# Create and push git tag
git tag -a v0.1.2 -m "Initial public release"
git push origin v0.1.2

# Create GitHub release with notes from file
gh release create v0.1.2 \
    --title "v0.1.2 - Initial Public Release" \
    --notes-file RELEASE_NOTES.md
```

## Done! 🎉

Your repository will be live at:
**https://github.com/googleSandy/gti-mcp-standalone**

### Next Steps

1. Visit the repository and verify everything looks good
2. Check that Mermaid diagrams render correctly in the README
3. Review the release notes
4. Share with your team!

---

**Note:** All commands are ready to copy-paste. Just run them in order from the `gti-mcp-standalone` directory.
