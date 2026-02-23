# Google Threat Intelligence MCP Server (Standalone)

This is a standalone MCP (Model Context Protocol) server for interacting with Google's Threat Intelligence suite. It provides AI assistants like Claude with access to comprehensive threat intelligence capabilities through both **local development** and **production cloud deployment** modes.

**Key Capabilities:**
- 🔍 Threat intelligence search (campaigns, threat actors, malware families)
- 📁 File analysis and behavior reports
- 🌐 Domain, IP, and URL reputation checking
- 🎯 IOC (Indicator of Compromise) search
- 📊 Threat profiles and hunting rulesets

[Learn more about MCP](https://modelcontextprotocol.io/introduction)

## Architecture

Understanding how GTI MCP Server works in different deployment modes:

### Component Overview

```mermaid
graph TB
    subgraph "MCP Clients"
        A1[Claude Desktop]
        A2[Cline]
        A3[Cursor]
        A4[Custom Frontend]
    end

    subgraph "Transport Layer"
        B1[stdio - Local]
        B2[SSE/HTTP - Remote]
    end

    subgraph "GTI MCP Server"
        C1[MCP Tools]
        C2[VT API Client]
    end

    D[VirusTotal/GTI API]

    A1 --> B1
    A2 --> B1
    A3 --> B1
    A4 --> B2

    B1 --> C1
    B2 --> C1

    C1 --> C2
    C2 --> D

    style C1 fill:#e1f5ff
    style C2 fill:#e1f5ff
```

### Local Deployment Flow

For individual developers running the MCP server locally:

```mermaid
sequenceDiagram
    participant Client as MCP Client
    participant Server as GTI MCP Server
    participant Env as Environment
    participant VT as VirusTotal API

    Client->>Server: Launch via stdio
    Server->>Env: Read VT_APIKEY
    Env-->>Server: API Key
    Client->>Server: Call tool (e.g., get_file_report)
    Server->>VT: API Request with VT_APIKEY
    VT-->>Server: Response
    Server-->>Client: Tool Result
```

**API Key Management:** Server reads `VT_APIKEY` from environment variables at startup.

### Cloud Deployment Flow

For teams deploying a centralized service:

```mermaid
sequenceDiagram
    participant Frontend as Frontend Client
    participant CloudRun as Cloud Run (SSE)
    participant Auth as Auth Middleware
    participant Server as GTI MCP Server
    participant VT as VirusTotal API

    Frontend->>CloudRun: Connect to /sse endpoint
    CloudRun->>Auth: Validate X-Mcp-Authorization header
    Auth-->>CloudRun: Authorized
    CloudRun-->>Frontend: SSE Connection Established

    Frontend->>CloudRun: Call tool with api_key parameter
    CloudRun->>Server: Execute tool
    Server->>VT: API Request with client-provided api_key
    VT-->>Server: Response
    Server-->>CloudRun: Tool Result
    CloudRun-->>Frontend: SSE Event with Result
```

**API Key Management:** Clients pass `api_key` parameter with each tool call. Server authenticates connection via `MCP_AUTH_TOKEN` but uses client-provided API keys for VirusTotal requests.

**Security Note:** This architecture allows teams to deploy a shared MCP server while maintaining individual user API quotas and access controls.
