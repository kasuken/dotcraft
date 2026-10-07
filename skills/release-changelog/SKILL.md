---
name: release-changelog
description: Prepare a release - work out the next semantic version from the commits since the last release, bump the version in the project files, and write the CHANGELOG.md entry and release notes. Use when asked to update the changelog, bump or increase the version, cut a release, or write release notes.
---

# Release and changelog

## 1. Find what changed

1. Find the last release: the newest heading in `CHANGELOG.md`, the latest tag (`git describe --tags --abbrev=0`), or the version in the project files. If they disagree, say so and ask which is right.
2. List the commits since then: `git log <last-tag>..HEAD --no-merges --format="%h %s%n%b"`. Also read merged PR titles and descriptions if the repository uses pull requests.
3. Group the changes by what a user or operator notices, not by commit. Several commits for one feature become one entry; refactors, test-only and CI-only changes are left out unless they matter to someone running the software.

## 2. Choose the version

Use semantic versioning, `MAJOR.MINOR.PATCH`:

- **MAJOR**: a breaking change for users, API clients, configuration or stored data that needs manual action.
- **MINOR**: a new feature or a visible improvement that is backwards compatible.
- **PATCH**: fixes only.

State the version you chose and why in one line. If the user named a version, use theirs.

## 3. Bump the version

Update it everywhere the repository keeps it, and nowhere else. Check, in this order: `Directory.Build.props` (`<Version>` or `<VersionPrefix>`), the web project's `.csproj`, `version.json` (Nerdbank.GitVersioning: change `version`, and don't edit generated values), `package.json`, and any `AppVersion` constant or `appsettings.json` value the UI shows. Search for the old version string to catch the rest.

## 4. Write the changelog entry

Add the new entry at the top of `CHANGELOG.md`, following the format the file already uses. If there is no file yet, use [Keep a Changelog](https://keepachangelog.com/en/1.1.0/):

```markdown
## [1.4.0] - 2026-10-07

### Added

- **Saved views** — save a filtered task list and reopen it from the sidebar.

### Changed

- **Faster Today screen** — the dashboard loads in one query instead of six.

### Fixed

- **Billing webhooks** — events from another product on the same Stripe account are ignored instead of failing with a 500.

### Security

- Upgraded `System.Text.Json` to fix CVE-XXXX-YYYY.
```

Rules:

- Sections in this order, only when non-empty: Added, Changed, Deprecated, Removed, Fixed, Security. Put **Breaking changes** first, with migration steps, when there are any.
- Each entry starts with a short bold name, then says what changed for the reader and, for fixes, what used to go wrong.
- Write for people using or running the software. Plain language, active voice, no commit hashes, no internal class names unless the reader configures them.
- Use today's date in ISO format.
- Add a `---` separator between entries if the file already does.

## 5. Release notes

If asked for release notes (for a GitHub release or an announcement), reuse the changelog entry and add, only when there is something to say:

- a one-paragraph summary of the release's theme at the top
- upgrade or migration steps
- configuration changes and new settings
- thanks to contributors

Don't add sections with nothing in them.

## 6. Finish

Show the version bump and the changelog diff. Don't create tags, commits or GitHub releases unless the user asks; when they do, use `git tag v<version>` and `gh release create v<version> --notes-file <file>`.
