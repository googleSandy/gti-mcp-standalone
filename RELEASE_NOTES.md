## Google Threat Intelligence MCP Server (Standalone)

First public release of the standalone GTI MCP server.

### Features

- Threat Intelligence Search: Search campaigns, threat actors, malware families
- File Analysis: Comprehensive file reports and behavior analysis
- Network Analysis: Domain, IP, and URL reputation checking
- IOC Search: Advanced indicator of compromise searches
- Threat Profiles: Custom threat profile management
- Hunting: Threat hunting ruleset support

### Deployment Options

**Local Development:**
- Simple uv installation
- Works with Claude Desktop, Cline, Cursor
- Environment variable API key management

**Production Cloud:**
- One-command Cloud Run deployment
- SSE/HTTP transport for frontends
- Per-user API key support
- Scalable architecture

### Documentation

Complete documentation including:
- Architecture diagrams (Mermaid)
- Quick start guide
- Cloud deployment guide
- Frontend integration examples
- Contributing guidelines

### Attribution

This is a standalone extraction from Google's official [mcp-security](https://github.com/google/mcp-security) repository.

**Original Authors:** Google SecOps Team
**License:** Apache 2.0
