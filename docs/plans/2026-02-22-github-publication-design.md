# GTI MCP Standalone - GitHub Publication Design

**Date:** 2026-02-22
**Author:** Claude Code
**Status:** Approved

## Overview

Prepare the `gti-mcp-standalone` project for public GitHub publication by cleaning up unnecessary files, consolidating documentation, and creating a professional README that serves both local developers and cloud deployment teams.

## Goals

1. Create a clean, professional repository ready for public consumption
2. Provide clear dual-path documentation (Local Development vs Production Deployment)
3. Merge frontend integration guidance into the main README
4. Add architecture diagrams for visual clarity
5. Maintain Google attribution and licensing
6. Provide working deployment script as a template

## Target Audience

**Dual audience approach:**
- **Developers** building AI applications that need threat intelligence (local MCP setup)
- **Security teams** deploying a centralized threat intel service (Cloud Run deployment)

Both audiences are equally important and should have clear, dedicated paths through the documentation.

## Design Decisions

### 1. File Cleanup

**Files to Delete:**
- `setup.py` - Redundant with `pyproject.toml` (modern Python packaging standard PEP 517/518)
- `frontend_integration_guide.md` - Content will be merged into README

**Rationale:** Modern Python projects use `pyproject.toml` exclusively. The frontend guide duplicates content that belongs in the main README for better discoverability.

**Files to Update:**
- `README.md` - Complete rewrite with dual-path structure
- `gti-remotemcp-deploy.sh` - Update with comment-based placeholders

**Files to Keep (Unchanged):**
- `pyproject.toml` - Maintain Google branding and repository references
- `Dockerfile` - Required for Cloud Run deployment
- `.gcloudignore` - Required for Cloud Run deployment
- `.gitignore` - Standard Python gitignore
- `LICENSE` - Apache 2.0 license
- `gti_mcp/` - All source code
- `tests/` - All test files

### 2. README Structure

**New README.md organization:**

```
# Google Threat Intelligence MCP Server (Standalone)

1. Overview
   - Project description
   - MCP protocol link
   - Statement about local and cloud deployment support

2. Architecture
   - Component Overview (Mermaid diagram)
   - Local Deployment Flow (Mermaid sequence diagram)
   - Cloud Deployment Flow (Mermaid sequence diagram)
   - Authentication & API Key Handling explanation

3. Features
   - Organized by capability (Collections, Files, Intelligence Search, etc.)
   - Comprehensive tool listing (keep current structure)

4. Quick Start (Local Development)
   - Prerequisites
   - Installation with uv
   - API Key Setup (VT_APIKEY environment variable)
   - MCP Client Configuration (Claude Desktop, Cline, Cursor examples)
   - Verification steps

5. Production Deployment (Cloud Run)
   - Overview and use case
   - Prerequisites (GCP account, gcloud CLI)
   - Deployment steps using gti-remotemcp-deploy.sh
   - Architecture explanation (SSE transport, auth flow)
   - Security considerations

6. Frontend Integration
   - Connection details (SSE transport)
   - Configuration parameters
   - Complete React/TypeScript example with SSEClientTransport
   - Tool invocation with api_key parameter
   - CORS considerations

7. Development
   - Project structure
   - Running tests
   - Contributing guidelines

8. License & Attribution
   - Apache 2.0 license
   - Attribution to Google SecOps team
   - Link to original mcp-security repository

9. Support
   - Link to original repository issues
   - Note about standalone extraction
```

**Key Design Principles:**
- **Dual-path clarity:** Local and Cloud sections are peers, not nested
- **Visual first:** Architecture diagrams appear early, before detailed setup
- **Complete examples:** No "see elsewhere" references
- **Security awareness:** Explicit sections on authentication and API key management
- **Copy-paste ready:** Working code examples for all scenarios

### 3. Architecture Section Details

**Three Mermaid diagrams:**

1. **Component Overview**
   - Shows: MCP Clients → Transport Layer → GTI MCP Server → VirusTotal API
   - Clarifies: Different client types and transport modes

2. **Local Deployment Flow (Sequence)**
   - Shows: Client launches server via stdio → env var VT_APIKEY → tool call → VT API → response
   - Clarifies: Server-side API key management

3. **Cloud Deployment Flow (Sequence)**
   - Shows: Frontend → SSE endpoint → MCP_AUTH_TOKEN validation → tool call with api_key → VT API → response
   - Clarifies: Client-side API key management and dual authentication

**Why these diagrams:**
- Visual learners understand system architecture immediately
- Clarifies the critical difference between local (env var) and cloud (per-call) API key handling
- Shows authentication flow for cloud deployment
- Renders natively on GitHub

### 4. Deployment Script Update

**Changes to `gti-remotemcp-deploy.sh`:**

Replace hardcoded configuration values:
```bash
# OLD (hardcoded):
PROJECT_ID="raybrian-sb"
SERVICE_NAME="gti-remote-mcp-server"
REGION="us-central1"

# NEW (comment-based placeholders):
# Configuration - Edit these values before running
# Enter your Google Cloud project ID (find it at: https://console.cloud.google.com)
PROJECT_ID="your-project-id-here"

# Enter a name for your Cloud Run service
SERVICE_NAME="gti-remotemcp-server"

# Enter your preferred Google Cloud region (e.g., us-central1, us-east1, europe-west1)
REGION="us-central1"
```

**Approach:**
- Comment-based instructions (not fail-fast, not interactive, not env vars)
- Clear comments explaining what each value is
- Helpful context (where to find project ID, example regions)
- Keep auth token generation logic unchanged
- No script logic changes - still works the same way

**User Experience:**
1. User opens `gti-remotemcp-deploy.sh`
2. Reads comments, edits 2-3 values
3. Runs script - deployment handles everything automatically
4. Gets service URL and auth token in output

### 5. Frontend Integration Content Migration

**Content from `frontend_integration_guide.md` to merge:**

1. Connection details (SSE transport, authentication requirements)
2. Configuration parameters (URL structure, headers)
3. Complete React/TypeScript example:
   - SSEClientTransport setup
   - MCP Client initialization
   - Dual header configuration (X-Mcp-Authorization + Authorization)
   - Connection function
4. API key handling explanation (per-tool-call `api_key` parameter)
5. Tool call example with TypeScript
6. CORS considerations

**Adaptations:**
- Remove hardcoded example URLs and tokens
- Use placeholder environment variables (e.g., `process.env.REACT_APP_MCP_SERVER_URL`)
- Clarify when Google Identity Token is needed (strict IAM enforcement)
- Emphasize VT_APIKEY per-call requirement in cloud mode

**Integration:**
- Becomes complete copy-paste-ready section
- Links back to Production Deployment section for service URL and auth token
- Working TypeScript code users can immediately adapt

### 6. Metadata & Branding

**Decision: Keep Google branding**

Rationale:
- This is a standalone extraction of Google's original work
- Proper attribution is important
- Users should know this comes from Google SecOps team
- Links to original repository for issues and updates

**No changes to:**
- `pyproject.toml` authors field: "Google SecOps Team"
- `pyproject.toml` URLs: Point to github.com/google/mcp-security
- License: Apache 2.0 (Google's original license)

**README will include:**
- Clear attribution in License & Attribution section
- Link to original mcp-security repository
- Support section directing issues to original repo

## Implementation Checklist

1. Create architecture diagrams (3 Mermaid diagrams)
2. Write new README.md with all sections
3. Update gti-remotemcp-deploy.sh with placeholders
4. Delete setup.py
5. Delete frontend_integration_guide.md
6. Test deployment script template (verify placeholders are clear)
7. Review final repository structure

## Success Criteria

1. **Developer Quick Start:** Clone repo → local MCP setup in under 5 minutes
2. **Cloud Deployment:** Follow README → deploy to Cloud Run in under 10 minutes
3. **Frontend Integration:** Copy TypeScript example → working SSE client
4. **Professional Presentation:** Clean file structure, comprehensive docs, visual diagrams
5. **Proper Attribution:** Google branding and licensing preserved

## Non-Goals

- Not changing any source code functionality
- Not updating pyproject.toml metadata (keeping Google branding)
- Not creating additional documentation files beyond README
- Not modifying test files

## Trade-offs

**Keeping deployment script vs removal:**
- **Chosen:** Keep as template with placeholders
- **Alternative:** Remove and provide only instructions
- **Rationale:** Script provides working automation; users prefer running a script over manual gcloud commands

**Single README vs multiple docs:**
- **Chosen:** Single comprehensive README
- **Alternative:** Separate docs for local/cloud/frontend
- **Rationale:** Better discoverability; GitHub users expect README to be comprehensive; reduces navigation

**Architecture section placement:**
- **Chosen:** After Overview, before Features
- **Alternative:** At the end, or in separate ARCHITECTURE.md
- **Rationale:** Visual learners benefit from seeing system architecture early; helps users choose local vs cloud path

## Risks & Mitigations

**Risk:** Users might miss editing deployment script placeholders
**Mitigation:** Clear comment instructions, placeholder text is obviously wrong ("your-project-id-here")

**Risk:** README becomes too long
**Mitigation:** Clear table of contents structure, logical sections, Mermaid diagrams for visual breaks

**Risk:** Mermaid diagrams don't render correctly
**Mitigation:** Test on GitHub, use standard Mermaid syntax, provide text alternatives

## Future Considerations

- Could add CONTRIBUTING.md if community contributions grow
- Could add example projects in `examples/` directory
- Could add troubleshooting FAQ section
- Could add video walkthrough links

## References

- Original project: https://github.com/google/mcp-security
- MCP Protocol: https://modelcontextprotocol.io/introduction
- Google Cloud Run: https://cloud.google.com/run
- Python Packaging (PEP 517/518): https://peps.python.org/pep-0517/
