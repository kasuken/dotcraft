<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="assets/logo-dark.svg">
    <img src="assets/logo-light.svg" alt="dotcraft" width="340">
  </picture>
</p>

<p align="center">
  <strong>Skills and agents for crafting .NET products with Blazor and MudBlazor.</strong><br>
  One plugin for Claude Code, GitHub Copilot and Codex.
</p>

<p align="center">
  <a href="https://github.com/kasuken/dotcraft/actions/workflows/validate.yml"><img alt="Validate" src="https://github.com/kasuken/dotcraft/actions/workflows/validate.yml/badge.svg"></a>
  <a href=".claude-plugin/plugin.json"><img alt="Version" src="https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2Fkasuken%2Fdotcraft%2Fmain%2F.claude-plugin%2Fplugin.json&query=%24.version&label=version&color=512BD4"></a>
  <a href="LICENSE"><img alt="MIT licence" src="https://img.shields.io/github/license/kasuken/dotcraft?color=512BD4"></a>
  <img alt="Claude Code, GitHub Copilot and Codex" src="https://img.shields.io/badge/works%20with-Claude%20Code%20%C2%B7%20Copilot%20%C2%B7%20Codex-1F2328">
</p>

---

AI coding agents write better .NET when they know how good .NET looks: how a Blazor component should load its data, why a page fetches twice under prerendering, what a MudBlazor theme should own, when an EF Core query will fall over, and what an accessible, well-animated interface needs. dotcraft packages that knowledge as skills and agents, and installs it the same way in Claude Code, GitHub Copilot and Codex, so every tool you open follows the same playbook.

- **53 skills** across C#, EF Core, Blazor, MudBlazor, testing, accessibility, motion, Stripe, GDPR and delivery
- **3 agents**: an implementer, a reviewer and a clean-up specialist
- **2 MCP servers** for current documentation: Microsoft Learn and Context7
- **Curated, pinned and credited**: 5 skills written for dotcraft, 10 adapted, and 38 from the best sources on [skills.sh](https://skills.sh), including the official .NET, Stripe and Microsoft Aspire skills

## Contents

- [Install](#install)
- [Try it](#try-it)
- [What's inside](#whats-inside)
- [Set it up for a whole repository](#set-it-up-for-a-whole-repository)
- [How it works](#how-it-works)
- [Maintaining dotcraft](#maintaining-dotcraft)
- [FAQ](#faq)
- [Credits and licence](#credits-and-licence)

## Install

| | Skills | Agents | MCP servers |
|---|:---:|:---:|:---:|
| **Claude Code** | Yes | Yes | Yes |
| **GitHub Copilot CLI** | Yes | Yes | Yes |
| **GitHub Copilot in VS Code** | Yes | Yes | Yes |
| **Codex CLI and app** | Yes | [Separate step](#codex) | Yes |

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

Inside a session, `/plugin marketplace add` and `/plugin install` do the same.

### GitHub Copilot in VS Code

Add the marketplace to your user settings, then search `@agentPlugins` in the Extensions view and install **dotcraft**:

```json
"chat.plugins.marketplaces": ["kasuken/dotcraft"]
```

### Codex

```bash
codex plugin marketplace add kasuken/dotcraft
codex plugin add dotcraft@dotcraft
```

Start a new session afterwards. Codex plugins can't carry agents, so dotcraft also publishes them as Codex custom agents. Clone this repository and run:

```powershell
./scripts/Export-CodexAgents.ps1 -Install
```

This copies `codex/agents/*.toml` to `~/.codex/agents/`. The Codex IDE extension doesn't load plugins yet; see [the FAQ](#can-i-use-the-skills-without-the-plugin-system) for a fallback.

### Recommended companion: impeccable

[impeccable](https://github.com/pbakaus/impeccable) is a design-engineering suite (`/impeccable audit`, `critique`, `polish`, `animate`, `typeset` and more). It ships its own installer with tool-specific skills, agents and hooks, so dotcraft doesn't bundle a copy. Install it alongside:

```bash
npx impeccable install --providers=claude,github,codex --scope=global
```

> [!NOTE]
> impeccable's launcher downloads a platform binary the first time it runs, and Codex asks you to approve its hook in `/hooks`.

## Try it

Skills switch on by themselves when a request matches them. Ask the way you normally would:

| Ask | What dotcraft brings in |
|---|---|
| "Add a settings page where users edit their profile" | `blazor-saas-stack`, `plan-ui-change`, `collect-user-input`, `mudblazor` |
| "This page loads its data twice and flickers" | `support-prerendering`, `fetch-and-send-data` |
| "Give the app a real dark mode and stop it looking like stock Material" | `mudblazor-design-system`, `frontend-design`, `better-colors` |
| "Audit the dashboard for accessibility" | `better-accessibility`, `accessibility`, `fixing-accessibility` |
| "Make adding a task feel smoother" | `animate`, `improve-animations`, `fixing-motion-performance` |
| "The orders query is slow" | `optimizing-ef-core-queries`, `efcore-patterns` |
| "Write tests for `TaskRow.razor`" | `bunit-testing` |
| "Add Stripe subscriptions" | `stripe-best-practices`, `gdpr-compliant` |
| "Is this ready to merge?" | `dotnet-validate` and the `code-reviewer` agent |
| "Cut a release" | `release-changelog` |

To run a skill on purpose, call it by name. In Claude Code that's `/dotcraft:<skill>`, for example `/dotcraft:review-animations`, which only runs when invoked. To use an agent, ask for it by name ("have code-reviewer look at my changes") or pick it from your tool's agent list.

## What's inside

### .NET and C#

| Skill | Use it for | From |
|---|---|---|
| `blazor-saas-stack` | Default architecture for Blazor + MudBlazor + EF Core + Identity products, and where each kind of code belongs | dotcraft |
| `dotnet-validate` | The gate before "done": restore, Release build, tests, vulnerable packages, pending EF migrations | dotcraft |
| `modern-csharp-coding-standards` | Records, pattern matching, value objects, `Span<T>`, API design | Aaron Stannard |
| `csharp-async` | Async and await without deadlocks or fire-and-forget | awesome-copilot |
| `dotnet-timezone` | `DateTimeOffset`, `TimeZoneInfo`, NodaTime, DST, Windows and IANA ids | awesome-copilot |
| `dotnet-webapi` | Endpoints with correct HTTP semantics, OpenAPI and ProblemDetails | .NET team |
| `aspnetcore-authentication` | Cookie, OpenID Connect and JWT Bearer set-up | Duende |
| `aspnetcore-authorization` | Policies, requirements and handlers | Duende |
| `aspire` | .NET Aspire AppHosts | Microsoft |
| `containerize-aspnetcore` | Dockerfiles on .NET 10 base images | awesome-copilot |
| `create-architectural-decision-record` | Architecture decision records | awesome-copilot |

### Data

| Skill | Use it for | From |
|---|---|---|
| `ef-core` | EF Core essentials | awesome-copilot |
| `efcore-patterns` | No-tracking by default, split queries, migration practice | Aaron Stannard |
| `optimizing-ef-core-queries` | Fixing slow queries from the generated SQL: N+1, cartesian explosion, paging | .NET team |

### Blazor and MudBlazor

| Skill | Use it for | From |
|---|---|---|
| `create-blazor-project` | A new Blazor Web App and its render-mode choices | .NET team |
| `plan-ui-change` | Breaking a complex screen into components | .NET team |
| `author-component` | Writing and reviewing `.razor` components | .NET team |
| `collect-user-input` | Forms, validation and input handling | .NET team |
| `fetch-and-send-data` | Loading data and the async component lifecycle | .NET team |
| `coordinate-components` | Sharing state between components | .NET team |
| `support-prerendering` | Double loads, flicker and lost state under prerendering | .NET team |
| `use-js-interop` | JavaScript interop and its lifecycle | .NET team |
| `configure-auth` | Authentication that works in every render mode | .NET team |
| `mudblazor` | Providers, components, DataGrid and known MudBlazor pitfalls | markheydon |
| `mudblazor-design-system` | One `MudTheme` from design tokens: dark mode, typography, elevation, focus and motion rules | dotcraft |

### Testing

| Skill | Use it for | From |
|---|---|---|
| `csharp-xunit` | xUnit tests and data-driven tests | awesome-copilot |
| `migrate-xunit-to-xunit-v3` | Moving to xUnit v3 | .NET team |
| `run-tests` | Running and filtering tests on VSTest or Microsoft.Testing.Platform | .NET team |
| `bunit-testing` | Component tests with bUnit 2, including MudBlazor, auth, navigation and JS interop | dotcraft |
| `playwright-blazor-testing` | End-to-end Blazor tests in C# | Aaron Stannard |
| `testcontainers-integration-tests` | Integration tests against a real SQL Server | Aaron Stannard |
| `test-anti-patterns` | Tests that can't fail, flaky tests and other smells | .NET team |
| `dotnet-slopwatch` | Disabled tests, suppressed warnings and other shortcuts in AI-written changes | Aaron Stannard |

### UI, accessibility and motion

| Skill | Use it for | From |
|---|---|---|
| `frontend-design` | A distinctive visual direction instead of a template look, with a MudBlazor section | Anthropic, dotcraft |
| `web-design-guidelines` | Reviewing UI code against the Web Interface Guidelines | Vercel |
| `better-accessibility` | WCAG 2.2 AA review and fixes: keyboard, focus, names, forms, announcements | Jakub Krehel |
| `accessibility` | WCAG 2.2 audits with Lighthouse and axe checklists | Addy Osmani |
| `fixing-accessibility` | Targeted ARIA, focus and contrast fixes | ibelick |
| `screen-reader-testing` | Testing with NVDA, JAWS and VoiceOver | Seth Hobson |
| `better-typography` | Type scale, spacing, font features and wrapping | Jakub Krehel |
| `better-colors` | Palettes, semantic tokens and contrast | Jakub Krehel |
| `better-layout` | Grouping, alignment, reading order and responsive structure | Jakub Krehel |
| `review-animations` | A strict review of easing, duration, interruption and performance (invoke it by name) | Emil Kowalski |
| `improve-animations` | Auditing a codebase's motion and planning improvements | Emil Kowalski |
| `animate` | Building an animation from scratch | Emil Kowalski |
| `design-motion-principles` | Creating and auditing motion | kylezantos |
| `fixing-motion-performance` | Layout thrashing, compositor-only properties, scroll-linked motion | ibelick |

### Product and delivery

| Skill | Use it for | From |
|---|---|---|
| `stripe-best-practices` | Checkout or PaymentIntents, Billing, webhooks, keys and sandboxes | Stripe |
| `gdpr-compliant` | Privacy by design: data models, logging, retention and deletion | awesome-copilot |
| `github-actions-hardening` | Reviewing workflows against the Actions threat model | awesome-copilot |
| `gha-security-review` | Exploitable workflow bugs such as pwn requests and expression injection | Sentry |
| `create-readme` | A README that is accurate and easy to scan | awesome-copilot |
| `release-changelog` | The next semantic version, the version bump and the changelog entry | dotcraft |

### Agents

| Agent | What it does |
|---|---|
| `csharp-expert` | Implements .NET changes with tests, runs `dotnet-validate`, then asks `code-reviewer` for a review |
| `code-reviewer` | Read-only review ranked by severity: correctness, security and per-user data isolation, EF performance, Blazor lifecycle, accessibility, motion and test gaps |
| `janitor` | Removes dead code, needless abstractions and unused packages in small, verified steps |

### MCP servers

| Server | Why |
|---|---|
| `microsoft-learn` | Current .NET, ASP.NET Core and Azure documentation and code samples |
| `context7` | Up-to-date documentation for libraries such as MudBlazor and Stripe.net |

Both are remote servers and need no API key.

## Set it up for a whole repository

So that everyone who opens a project gets dotcraft, commit these two files to the project.

`.claude/settings.json` for Claude Code:

```json
{
  "extraKnownMarketplaces": {
    "dotcraft": { "source": { "source": "github", "repo": "kasuken/dotcraft" } }
  },
  "enabledPlugins": { "dotcraft@dotcraft": true }
}
```

`.github/copilot/settings.json` for Copilot CLI and the Copilot cloud agent uses the same shape:

```json
{
  "extraKnownMarketplaces": {
    "dotcraft": { "source": { "source": "github", "repo": "kasuken/dotcraft" } }
  },
  "enabledPlugins": { "dotcraft@dotcraft": true }
}
```

Then describe the project in `AGENTS.md`. The skills read it, and the project's own rules always override dotcraft's defaults:

```markdown
## Stack
- .NET 10 Blazor Web App, Interactive Server render mode, MudBlazor 9
- EF Core on SQL Server; migrations in Product.Data
- Tests: xUnit v3 + AwesomeAssertions, bUnit, Playwright

## Validation
dotnet build Product.slnx -c Release && dotnet test Product.slnx -c Release --no-build
```

## How it works

```text
.claude-plugin/plugin.json        one manifest, read by Claude Code, Copilot and Codex
.claude-plugin/marketplace.json   the repository is its own marketplace
skills/<name>/SKILL.md            Agent Skills format, loaded on demand by every tool
agents/<name>.md                  agents for Claude Code and Copilot
codex/agents/<name>.toml          the same agents for Codex, generated
.mcp.json                         MCP servers
vendor.json                       where every third-party skill comes from, pinned to a commit
licenses/                         upstream licence texts
scripts/                          sync, export and check scripts (PowerShell 7)
```

- **One manifest.** Copilot and Codex both read Claude Code's `.claude-plugin` layout, so there is a single source of truth. A root `plugin.json` would change how Copilot loads agents, and the CI check rejects one.
- **Skills load on demand.** Every tool sees only each skill's name and one-line description until a request needs it; the full instructions and references load only then.
- **Third-party skills are pinned.** Each comes from a specific upstream commit recorded in [`vendor.json`](vendor.json), copied verbatim with its licence. Updates are a reviewed diff, never a silent change.
- **Agents are written once.** `agents/*.md` serves Claude Code and Copilot; `Export-CodexAgents.ps1` turns them into Codex TOML, and CI fails if the two drift.

## Maintaining dotcraft

You need PowerShell 7 and Git.

**Update third-party skills** to their latest upstream versions, then review the diff:

```powershell
./scripts/Sync-Vendored.ps1 -Update                    # every source
./scripts/Sync-Vendored.ps1 -Update -Repo dotnet/skills # one source
```

**Add a third-party skill**: add it to `vendor.json` and run `./scripts/Sync-Vendored.ps1`. It is copied in, its licence is saved under `licenses/`, and `THIRD-PARTY-NOTICES.md` is regenerated.

**Change an agent**: edit `agents/<name>.md`, then run `./scripts/Export-CodexAgents.ps1` so the Codex copy matches.

**Check everything** before committing; CI runs the same script:

```powershell
./scripts/Test-Plugin.ps1
```

It checks the manifests, every skill's name and description against the Agent Skills spec, agent names, licences for vendored sources, and that the Codex agents are up to date.

**Release**: bump `version` in both `.claude-plugin/plugin.json` and `.claude-plugin/marketplace.json`, and add a [changelog](CHANGELOG.md) entry. Installed copies pick it up with each tool's plugin update command.

## FAQ

### Won't 53 skills fill up my context?

No. Each tool keeps only the name and a short description of every skill in context, which is a few thousand tokens in total. The body of a skill and its reference files load only when a request needs them.

### My project does things differently. Who wins?

Your project. `blazor-saas-stack` and the agents read `AGENTS.md`, `CLAUDE.md` and `.github` instructions first and treat their own rules as defaults. Put project-specific decisions there instead of editing a skill.

### Why copy third-party skills instead of linking to them?

A plugin has to be self-contained to install from one repository in three different tools. Copying from a pinned commit also makes every upstream change a diff you can review, and keeps each skill's licence and attribution next to it. The one exception is impeccable, which needs its own installer.

### Can I use the skills without the plugin system?

Yes. Copy the folders in `skills/` to `~/.agents/skills/` (read by Copilot CLI, VS Code and Codex) and to `~/.claude/skills/` (read by Claude Code). You lose one-command updates, so prefer the plugin when your tool supports it.

### How do I report a problem with a third-party skill?

Open an issue here if it's about how dotcraft packages it. If it's about the skill's content, report it upstream (the source is linked in [`THIRD-PARTY-NOTICES.md`](THIRD-PARTY-NOTICES.md)), and the fix arrives with the next sync.

## Credits and licence

dotcraft stands on the work of the .NET team ([dotnet/skills](https://github.com/dotnet/skills)), Aaron Stannard ([dotnet-skills](https://github.com/aaronontheweb/dotnet-skills)), [Duende Software](https://github.com/duendesoftware/duende-skills), [Microsoft](https://github.com/microsoft/aspire-skills), [Stripe](https://github.com/stripe/ai), [Sentry](https://github.com/getsentry/skills), [markheydon](https://github.com/markheydon/github-workflows), [Vercel](https://github.com/vercel-labs/agent-skills), [Jakub Krehel](https://github.com/jakubkrehel/skills), [Addy Osmani](https://github.com/addyosmani/web-quality-skills), [ibelick](https://github.com/ibelick/ui-skills), [Seth Hobson](https://github.com/wshobson/agents), [Emil Kowalski](https://github.com/emilkowalski/skills), [kylezantos](https://github.com/kylezantos/design-motion-principles), the [awesome-copilot](https://github.com/github/awesome-copilot) community and [Anthropic](https://github.com/anthropics/skills). Thank you.

dotcraft's own files are released under the [MIT licence](LICENSE). Third-party skills keep their original licences; see [THIRD-PARTY-NOTICES.md](THIRD-PARTY-NOTICES.md) and [`licenses/`](licenses/).
