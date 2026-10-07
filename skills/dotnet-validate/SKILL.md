---
name: dotnet-validate
description: Run the verification gate for a .NET solution before calling a change done - restore, Release build, tests, vulnerable package scan, pending EF Core model changes and a whitespace check - and report the results. Use before saying a .NET change is finished, before committing or opening a pull request, or when asked to validate, verify or check the build.
---

# .NET validation gate

Run these checks in order and stop at the first failure that blocks the next step. Report what ran, what passed and what failed, with the relevant output. Never describe a change as done while a check is failing or was skipped without saying so.

## 1. Find the solution

Prefer the repository's own instructions: if `AGENTS.md`, `CLAUDE.md` or `README.md` lists validation commands, run those instead of the defaults below.

Otherwise use the `.slnx` (or `.sln`) at the repository root. If there are several, ask which one, or use the one named after the repository.

## 2. Run the gate

```bash
dotnet restore <Solution>.slnx
dotnet build <Solution>.slnx --configuration Release --no-restore
dotnet test <Solution>.slnx --configuration Release --no-build
dotnet list <Solution>.slnx package --vulnerable --include-transitive
git diff --check
```

If the solution has an EF Core data project, also run:

```bash
dotnet ef migrations has-pending-model-changes --project <Product>.Data --startup-project <Product>.Web --no-build --configuration Release
```

Find the data project by looking for a class deriving from `DbContext` and a `Migrations` folder. The startup project is the web host that registers the context. If `dotnet ef` is missing, check for `dotnet-tools.json` and run `dotnet tool restore` first.

## 3. Read the results

| Check | Passes when | If it fails |
|---|---|---|
| restore | exit code 0 | Check the package source and Central Package Management versions |
| build | 0 errors; warnings reviewed | Fix errors. Don't suppress warnings to get green (see `dotnet-slopwatch`) |
| test | every test passes | Read the first failure. Don't skip or delete tests to pass (see `test-anti-patterns`) |
| vulnerable packages | "no vulnerable packages" for every project | Upgrade the package, including transitive ones through a direct reference, and re-run |
| pending model changes | "No changes have been made to the model" | Add a migration with a descriptive name, review the generated code, re-run |
| `git diff --check` | no output | Remove trailing whitespace and conflict markers |

Long test runs: for filtering, blame-hang and test-platform detail, use the `run-tests` skill.

## 4. Beyond the gate

The gate proves the code builds and existing tests pass. It does not prove the change works. For anything a user can see or anything security-sensitive, also make sure a test covers the boundary where the bug would appear:

- component behaviour → bUnit (`bunit-testing`)
- a full flow in the browser → Playwright (`playwright-blazor-testing`)
- database rules, constraints, migrations, concurrency → integration tests against real SQL Server (`testcontainers-integration-tests`); EF Core's in-memory provider does not prove these

## Report format

```
Validation for Product.slnx
- restore: passed
- build (Release): passed, 0 warnings
- test: 214 passed, 0 failed
- vulnerable packages: none
- pending EF model changes: none
- git diff --check: clean
```

List failures first, with the command and the key lines of output.
