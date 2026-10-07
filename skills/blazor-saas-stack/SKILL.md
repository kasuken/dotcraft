---
name: blazor-saas-stack
description: Default architecture and conventions for products built on a .NET 10 Blazor Web App with MudBlazor, EF Core on SQL Server and ASP.NET Core Identity. Use when starting a new Blazor product, adding a feature that crosses the UI, application and data layers, deciding where code belongs, or when a repository has no stack instructions of its own.
---

# Blazor SaaS stack

These are the defaults behind a family of .NET 10 Blazor products. A repository's own `AGENTS.md`, `CLAUDE.md` or `.github/instructions` always win over this skill; use it to fill gaps, not to override decisions already written down.

## Stack

| Concern | Default |
|---|---|
| Runtime | .NET 10, C# latest, nullable reference types on, `global.json` pins the SDK |
| UI | Blazor Web App, Interactive Server render mode by default |
| Components | MudBlazor for every UI component. Do not add another UI library or CSS framework. |
| Data | EF Core, SQL Server (SQLite allowed for local or single-user tools), code first with migrations |
| Auth | ASP.NET Core Identity with local accounts |
| AI | `Microsoft.Extensions.AI` abstractions, provider chosen in configuration |
| Payments | Stripe (see `stripe-best-practices`) |
| Tests | xUnit, AwesomeAssertions or FluentAssertions (whichever the repo already uses), bUnit, Playwright |
| Build | `.slnx` solution, `Directory.Build.props`, Central Package Management when the repo has it |

## Solution layout

```
Product.slnx
Product.Domain/                  entities, value objects, invariants; no dependencies
Product.Application/             use cases, service interfaces, DTOs
Product.Data/                    DbContext, IEntityTypeConfiguration<T>, migrations
Product.Web/                     Blazor UI, Identity, hosting, health checks
Product.Application.Tests/       unit tests for use cases
Product.Data.IntegrationTests/   real SQL Server (Testcontainers), migrations, constraints
Product.Web.Tests/               bUnit component tests
Product.Web.E2ETests/            Playwright end-to-end tests
```

Namespaces follow the project: `Product.Domain.*`, `Product.Application.*`, and so on.

## Where code belongs

- Business rules live in Domain or Application, never in a `.razor` file.
- Razor components never touch `DbContext`. Pages stay thin: they call an application service and render the result.
- Get the current user through an abstraction such as `ICurrentUser`, never `HttpContext` inside services.
- Only add a Minimal API endpoint when something outside the Blazor circuit needs HTTP (webhooks, file downloads, health checks).
- Background work (reminders, emails, imports) runs in hosted services that are idempotent and safe to restart.
- Add an interface only when there is a second implementation or a test seam that needs it. Prefer composition to inheritance.

## Blazor and MudBlazor

- Every page handles three states explicitly: loading (`MudProgressLinear` or skeletons), empty (an invitation to act) and error (what went wrong and what to do).
- Repeated UI becomes a reusable component: selectors, filters, dialogs, forms, tables.
- Tables use `MudDataGrid` or `MudTable` with server-side paging, sorting and filtering (`ServerData`). Never load a whole table into memory.
- Forms use `EditForm` or `MudForm` with validation messages next to the field.
- Destructive actions ask for confirmation in a `MudDialog` and say exactly what will be deleted.
- Keyboard-first: every action reachable by keyboard, focus moved into dialogs and back out, short click paths.
- Look and feel come from one `MudTheme` built from design tokens (see `mudblazor-design-system`). Motion and accessibility rules are in that skill too.
- For component-level work use the Blazor skills: `author-component`, `collect-user-input`, `coordinate-components`, `fetch-and-send-data`, `support-prerendering`, `use-js-interop`, `configure-auth`, `plan-ui-change`. For MudBlazor component APIs and pitfalls use `mudblazor`.

## Data

- Configure entities with `IEntityTypeConfiguration<T>`; no data annotations on domain types.
- All queries are async. Read-only queries use `AsNoTracking()`. Project to DTOs with `Select` instead of loading full graphs.
- Index the columns behind lists, dashboards and search. Use a rowversion concurrency token where two people can edit the same row.
- Every schema change ships with a migration; `dotnet ef migrations has-pending-model-changes` must pass (see `dotnet-validate`).
- No Dapper, raw SQL or stored procedures unless a measured performance problem justifies it, and then record the decision in an ADR.
- See `ef-core`, `efcore-patterns` and `optimizing-ef-core-queries` for detail.

## Multi-user data and privacy

- Every row a user owns carries the owner's id, and every query filters by it. Prefer one place that applies the filter (a repository method or an EF global query filter) over remembering it in each query.
- Tests must prove that user A cannot read or change user B's data.
- Never log personal content (notes, messages, financial data). Log ids and outcomes instead.
- No secrets in `appsettings*.json`: user secrets locally, app settings or Key Vault in hosting.
- Apply `gdpr-compliant` when a feature stores, exports or deletes personal data.

## AI features

- Business logic depends on `IChatClient` and related `Microsoft.Extensions.AI` abstractions, never on a vendor SDK directly.
- The provider (OpenAI, Azure OpenAI, a local model) is chosen in configuration.
- Version prompts, store which model and prompt produced a result, and validate structured output before it reaches the domain.

## Done means

Run `dotnet-validate` before handing off. For user-visible or security-sensitive flows, add a test at the boundary where the defect would be seen: a bUnit test for component behaviour, a Playwright test for a flow, an integration test against SQL Server for data rules. EF Core's in-memory provider does not prove constraints, transactions, migrations or rowversion behaviour.
