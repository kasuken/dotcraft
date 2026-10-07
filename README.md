# dotcraft

**Skills and agents for building .NET products with Blazor and MudBlazor, for Claude Code, GitHub Copilot and Codex.**

dotcraft gathers the skills used every day to build .NET 10 products: C# and EF Core, Blazor and MudBlazor, tests at every level, accessible UI with considered motion, design systems, Stripe and GDPR. It is one plugin that installs the same way in all three coding agents, so the guidance stays identical whichever tool you open.

- **53 skills**: 5 written for dotcraft, 10 adapted from awesome-copilot and Anthropic, and 38 pinned from the best sources on [skills.sh](https://skills.sh)
- **3 agents**: `csharp-expert`, `code-reviewer`, `janitor`
- **2 MCP servers**: Microsoft Learn and Context7, both remote, no keys needed

> [!NOTE]
> Skills load on demand. Each agent only sees a skill's short description until a task needs it, so having many installed costs little context.

## Install

### Claude Code

```text
/plugin marketplace add kasuken/dotcraft
/plugin install dotcraft@dotcraft
```

### GitHub Copilot CLI

```bash
copilot plugin marketplace add kasuken/dotcraft
copilot plugin install dotcraft@dotcraft
```

Inside a session you can use `/plugin marketplace add` and `/plugin install` instead.

### GitHub Copilot in VS Code

Add the repository as a plugin marketplace in your settings, then search `@agentPlugins` in the Extensions view and install **dotcraft**:

```json
"chat.plugins.marketplaces": ["kasuken/dotcraft"]
```

### Codex

```bash
codex plugin marketplace add kasuken/dotcraft
codex plugin add dotcraft@dotcraft
```

Codex plugins can't include agents, so the agents are also published as Codex custom agents. To install them, clone the repository and run:

```powershell
./scripts/Export-CodexAgents.ps1 -Install
```

This copies `codex/agents/*.toml` to `~/.codex/agents/`.

### Companion: impeccable

[impeccable](https://github.com/pbakaus/impeccable) is the design-engineering suite behind `/impeccable audit`, `polish`, `animate`, `typeset` and more. It ships its own installer with harness-specific skills, agents and hooks, so dotcraft doesn't bundle a copy. Install it next to dotcraft:

```bash
npx impeccable install --providers=claude,github,codex --scope=global
```

> [!IMPORTANT]
> impeccable's launcher downloads a platform binary the first time it runs. Codex users must approve its hook in `/hooks`.

## What's inside

### .NET and C#

| Skill | Use it for |
|---|---|
| `blazor-saas-stack` | Default architecture for Blazor + MudBlazor + EF Core + Identity products and where code belongs |
| `dotnet-validate` | The pre-handoff gate: restore, Release build, tests, vulnerable packages, pending EF migrations |
| `modern-csharp-coding-standards` | Records, pattern matching, value objects, `Span<T>`, API design |
| `csharp-async` | Async/await best practices |
| `dotnet-timezone` | `DateTimeOffset`, `TimeZoneInfo`, NodaTime, DST and Windows/IANA ids |
| `dotnet-webapi` | Minimal API and controller endpoints with correct HTTP semantics, OpenAPI and ProblemDetails |
| `aspnetcore-authentication` | Cookie, OpenID Connect and JWT Bearer configuration |
| `aspnetcore-authorization` | Policies, requirements and handlers |
| `aspire` | .NET Aspire AppHost guidance |
| `containerize-aspnetcore` | Dockerfiles for ASP.NET Core on .NET 10 base images |
| `create-architectural-decision-record` | ADRs |

### Data

| Skill | Use it for |
|---|---|
| `ef-core` | EF Core essentials |
| `efcore-patterns` | No-tracking by default, split queries, migration practices |
| `optimizing-ef-core-queries` | Diagnosing slow queries from the generated SQL: N+1, cartesian explosion, paging |

### Blazor and MudBlazor

| Skill | Use it for |
|---|---|
| `create-blazor-project` | New Blazor Web App, render mode and interactivity choices |
| `plan-ui-change` | Breaking a complex UI feature into components |
| `author-component` | Writing and reviewing `.razor` components |
| `collect-user-input` | Forms, validation and input handling |
| `fetch-and-send-data` | Loading data and the async component lifecycle |
| `coordinate-components` | Sharing state across components |
| `support-prerendering` | Double loads, flicker and state loss with prerendering |
| `use-js-interop` | JavaScript interop and its lifecycle |
| `configure-auth` | Auth that works with each render mode |
| `mudblazor` | MudBlazor setup, providers, components, DataGrid and known pitfalls |
| `mudblazor-design-system` | One `MudTheme` from design tokens, dark mode, elevation, focus and motion rules |

### Testing

| Skill | Use it for |
|---|---|
| `csharp-xunit` | xUnit tests and data-driven tests |
| `migrate-xunit-to-xunit-v3` | Moving to xUnit v3 |
| `run-tests` | Running and filtering tests on VSTest or Microsoft.Testing.Platform |
| `bunit-testing` | Component tests with bUnit 2, including MudBlazor, auth and JS interop |
| `playwright-blazor-testing` | End-to-end tests for Blazor in C# |
| `testcontainers-integration-tests` | Integration tests against a real SQL Server |
| `test-anti-patterns` | Finding tests that can't fail, flaky tests and other smells |
| `dotnet-slopwatch` | Catching disabled tests, suppressed warnings and other shortcuts in AI-written changes |

### UI, accessibility and motion

| Skill | Use it for |
|---|---|
| `frontend-design` | A distinctive visual direction, with a MudBlazor section added by dotcraft |
| `web-design-guidelines` | Reviewing UI code against the Web Interface Guidelines |
| `better-accessibility` | WCAG 2.2 AA review and fixes: keyboard, focus, names, forms, announcements |
| `accessibility` | WCAG 2.2 audits with Lighthouse and axe checklists |
| `fixing-accessibility` | Targeted ARIA, focus and contrast fixes |
| `screen-reader-testing` | Testing with NVDA, JAWS and VoiceOver |
| `better-typography` | Type scale, spacing, font features and wrapping |
| `better-colors` | Palettes, semantic tokens and contrast checks |
| `better-layout` | Grouping, alignment, reading order and responsive structure |
| `review-animations` | Strict review of easing, duration, interruption and performance (run it explicitly) |
| `improve-animations` | Auditing a codebase's motion and planning improvements |
| `animate` | Building an animation from scratch |
| `design-motion-principles` | Creating and auditing motion |
| `fixing-motion-performance` | Layout thrashing, compositor-only properties, scroll-linked motion |

### Product and delivery

| Skill | Use it for |
|---|---|
| `stripe-best-practices` | Checkout vs PaymentIntents, Billing, webhooks, keys and sandboxes |
| `gdpr-compliant` | Privacy by design: data models, logging, retention and deletion |
| `github-actions-hardening` | Reviewing workflows for the Actions threat model |
| `gha-security-review` | Finding exploitable workflow vulnerabilities such as pwn requests and injection |
| `create-readme` | Writing a README that is accurate and easy to scan |
| `release-changelog` | Choosing the next version, bumping it and writing the changelog |

### Agents

| Agent | What it does |
|---|---|
| `csharp-expert` | Implements .NET changes with tests, runs `dotnet-validate`, then hands off to `code-reviewer` |
| `code-reviewer` | Read-only review: correctness, security and per-user data isolation, EF performance, Blazor lifecycle, accessibility, motion, tests |
| `janitor` | Removes dead code, needless abstractions and unused packages in small verified steps |

In Claude Code and Copilot the agents come with the plugin. In Codex, install them with `Export-CodexAgents.ps1 -Install` (see above).

### MCP servers

| Server | Why |
|---|---|
| `microsoft-learn` | Current .NET, ASP.NET Core and Azure documentation and code samples |
| `context7` | Up-to-date docs for third-party libraries such as MudBlazor and Stripe.net |

## Use it in a project

Skills work without any setup. To get the most out of the Blazor skills, describe your app in the project's `AGENTS.md` (render mode, solution layout, test stack and validation commands). The `dotnet/skills` Blazor skills read the render mode from there, and a project's own rules always take precedence over `blazor-saas-stack`.

## Repository layout

```text
.claude-plugin/      plugin.json and marketplace.json, read by Claude Code, Copilot and Codex
skills/<name>/       one folder per skill (Agent Skills format)
agents/<name>.md     agents for Claude Code and Copilot
codex/agents/        the same agents as Codex TOML, generated
.mcp.json            MCP servers
vendor.json          where every third-party skill comes from, pinned to a commit
licenses/            upstream licence texts
scripts/             sync, export and check scripts
```

## Updating third-party skills

Skills from other repositories are copied verbatim from a pinned commit listed in [`vendor.json`](vendor.json). Don't edit them by hand. To move them to the latest upstream versions:

```powershell
./scripts/Sync-Vendored.ps1 -Update            # all sources
./scripts/Sync-Vendored.ps1 -Update -Repo dotnet/skills
./scripts/Test-Plugin.ps1
```

Review the diff, bump the version in both manifests, and add a changelog entry.

To add a skill from another repository, add it to `vendor.json` and run `Sync-Vendored.ps1`. To change an agent, edit `agents/<name>.md` and run `Export-CodexAgents.ps1` so the Codex copy stays in step.

## Credits

dotcraft stands on work by the .NET team ([dotnet/skills](https://github.com/dotnet/skills)), Aaron Stannard ([dotnet-skills](https://github.com/aaronontheweb/dotnet-skills)), Duende Software, Microsoft, Stripe, Sentry, markheydon, Vercel, Jakub Krehel, Addy Osmani, ibelick, Seth Hobson, Emil Kowalski, kylezantos, the [awesome-copilot](https://github.com/github/awesome-copilot) community and Anthropic. See [THIRD-PARTY-NOTICES.md](THIRD-PARTY-NOTICES.md) for sources, commits and licences.

dotcraft's own files are released under the [MIT licence](LICENSE). Third-party skills keep their original licences.
