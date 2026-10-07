# Changelog

## [1.0.0] - 2026-10-07

### Added

- **One plugin for three agents** — installs in Claude Code, GitHub Copilot (CLI and VS Code) and Codex from the same repository.
- **53 skills** for .NET 10, Blazor and MudBlazor product work:
  - 5 written for dotcraft: `blazor-saas-stack`, `dotnet-validate`, `mudblazor-design-system`, `bunit-testing`, `release-changelog`.
  - 10 adapted from awesome-copilot and Anthropic, including `frontend-design` with a new MudBlazor section.
  - 38 pinned from dotnet/skills, aaronontheweb/dotnet-skills, Duende, Microsoft Aspire, Stripe, Sentry, Vercel, Jakub Krehel, Addy Osmani, ibelick, Seth Hobson, Emil Kowalski, kylezantos and markheydon.
- **Agents** — `csharp-expert`, `code-reviewer` and `janitor`, with generated Codex versions.
- **MCP servers** — Microsoft Learn and Context7.
- **Maintenance scripts** — `Sync-Vendored.ps1` to update third-party skills from pinned commits, `Export-CodexAgents.ps1` and `Test-Plugin.ps1`, plus a CI check.
