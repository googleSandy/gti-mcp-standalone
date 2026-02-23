FROM python:3.11-slim

# Install uv for fast package management
COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/uv

WORKDIR /app

# Copy the application code
COPY . /app

# Install dependencies using uv
# --no-dev: Exclude development dependencies (test, etc) if any
# --system: Install into system python or create venv? 
# uv sync creates a .venv by default. We use that.
RUN uv sync --no-dev

# Expose the port
EXPOSE 8080

# Run the application using uvicorn found in the virtual environment
# We use 'uv run' to ensure we use the environment created by 'uv sync'
CMD ["uv", "run", "uvicorn", "gti_mcp.server:app", "--host", "0.0.0.0", "--port", "8080"]
