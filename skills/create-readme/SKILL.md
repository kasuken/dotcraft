---
name: create-readme
description: Write or rewrite a project's README.md so it is appealing, accurate and easy to scan. Use when asked to create, rewrite or improve a README, or when a repository has no README or an outdated one.
---

# Create a README

Write the README as a senior engineer with long experience of open-source projects would: appealing, informative and quick to read.

## Steps

1. Review the whole repository before writing: solution and project files, `Program.cs`, configuration, docs, CI workflows, `CHANGELOG.md` and the existing README. Every command and claim in the README must be true for this code.
2. Look for a logo or icon (in `docs/`, `assets/`, `wwwroot/` or the repository root). If there is one, use it in the header.
3. Draft with this structure, dropping any section that has nothing true to say:
   - Name, one-sentence description and, if useful, badges (build, licence, version)
   - A screenshot or short GIF for anything with a UI
   - What it does: three to six bullets about outcomes, not implementation
   - Getting started: prerequisites with versions, then copy-pasteable steps to run it locally
   - Configuration: settings, secrets (and where they go; never real values), environment variables
   - Usage: the main tasks, with short examples
   - Architecture: a short overview of the projects or folders, only if it helps a newcomer
   - Development: build, test and validate commands
   - Deployment, if the repository deploys somewhere
4. Use GitHub Flavored Markdown and GitHub admonitions (`> [!NOTE]`, `> [!TIP]`, `> [!IMPORTANT]`, `> [!WARNING]`) where they help.
5. Keep it concise. Don't overuse emojis.
6. Don't add LICENSE, CONTRIBUTING or CHANGELOG sections; those have their own files. Link to them in one line at most.

## Style references

For structure and tone, these READMEs are good models:

- https://raw.githubusercontent.com/Azure-Samples/serverless-chat-langchainjs/refs/heads/main/README.md
- https://raw.githubusercontent.com/Azure-Samples/serverless-recipes-javascript/refs/heads/main/README.md
- https://raw.githubusercontent.com/sinedied/run-on-output/refs/heads/main/README.md
- https://raw.githubusercontent.com/sinedied/smoke/refs/heads/main/README.md

## Before finishing

- Run the getting-started commands, or check them against the project files, so a newcomer can follow them exactly.
- Check every link and image path.
- Make sure no secret, connection string or personal data appears in examples.
