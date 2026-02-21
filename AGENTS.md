<!-- nx configuration start-->
<!-- Leave the start & end comments to automatically receive updates. -->

# General Guidelines for working with Nx

- When running tasks (for example build, lint, test, e2e, etc.), always prefer running the task through `nx` (i.e. `nx run`, `nx run-many`, `nx affected`) instead of using the underlying tooling directly
- Avoid jest's --testPathPattern, it is unpredictable and ends up running the full suite more often than not
- Avoid "as any", and "as unknown" casts wherever possible.
- Avoid "any" and "unknown" types wherever possible
- when running tests with nx/jest, favor prefixing NX_TUI=false and adding --outputStyle=stream to the arguments
- You have access to the Nx MCP server and its tools, use them to help the user
- When answering questions about the repository, use the `nx_workspace` tool first to gain an understanding of the workspace architecture where applicable.
- When working in individual projects, use the `nx_project_details` mcp tool to analyze and understand the specific project structure and dependencies
- For questions around nx configuration, best practices or if you're unsure, use the `nx_docs` tool to get relevant, up-to-date docs. Always use this instead of assuming things about nx configuration
- If the user needs help with an Nx configuration or project graph error, use the `nx_workspace` tool to get any errors

<!-- nx configuration end-->

- In general, whether an error is viewed as 'pre-existing' or not, unless otherwise specified, we generally want to fix it. If it is a large task, prompt the user.

- Prefer creating .ts or .js files over executing node statements raw on the console.