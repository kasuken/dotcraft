# SEO Agent Skill

A self-contained, Google-focused SEO skill using the
[Agent Skills standard](https://agentskills.io/specification). The same folder works
with **Claude Code, Codex, and GitHub Copilot** without rewriting its instructions.
Claude interfaces that support custom skill uploads can use the packaged ZIP.

## Contents

| File or directory | Purpose |
| --- | --- |
| [SKILL.md](SKILL.md) | Trigger description and evidence-first workflows |
| `references` | Ten focused SEO topic guides plus the complete 56-entry source map |
| [Output templates](assets/output-templates.md) | Audit, diagnosis, implementation, brief, and migration formats |
| [Evaluation scenarios](assets/evaluation-scenarios.md) | Behavioral acceptance cases and packaging criteria |

The skill covers technical SEO, content/intent and E-E-A-T, policies, indexing,
Core Web Vitals, schema/titles, JavaScript/links/media, international sites,
ecommerce, Discover, AI Search, and diagnostics.

It requires no scripts, package installation, account credentials, or particular
MCP server. A host with file access can use the bundled references offline.
Live auditing, current policy verification, and private reports require the
corresponding tools and explicit authorization. Offline advice is labeled with
the knowledge snapshot rather than presented as live evidence.

## Install the same folder in the client of your choice

Copy **the entire `seo` directory**, not just SKILL.md, into a supported skills
location in your target project or home directory. Windows paths are shown below.

| Client | Project destination | Personal destination |
| --- | --- | --- |
| Claude Code | `.claude\skills\seo` | `$HOME\.claude\skills\seo` |
| Codex CLI / IDE | `.agents\skills\seo` | `$HOME\.agents\skills\seo` |
| GitHub Copilot | `.github\skills\seo` | `$HOME\.copilot\skills\seo` for CLI |

Current Copilot documentation also supports project `.claude\skills` and
`.agents\skills`, and personal `.agents\skills`. Thus Codex and Copilot can share
one `.agents\skills\seo` installation. Claude Code's documented project location
is `.claude\skills\seo`; the portable format does not imply every client scans
the same directories.

Avoid installing duplicate copies into every folder a single client scans.
For non-Windows hosts, use the equivalent directory hierarchy in that host's
native path syntax. Do not change bundled Markdown links.

### PowerShell example

From the knowledge-base root, choose **one** destination for your target client.
This example installs a project skill for Claude Code into this workspace:

```powershell
$skillsDirectory = '.\.claude\skills'
$target = Join-Path $skillsDirectory 'seo'
if (Test-Path -LiteralPath $target) {
    throw "An SEO skill already exists at $target. Review it before replacing."
}
New-Item -ItemType Directory -Path $skillsDirectory -Force | Out-Null
Copy-Item -LiteralPath '.\skills\seo' -Destination $skillsDirectory -Recurse
```

For Codex/shared Copilot, change `$skillsDirectory` to `'.\.agents\skills'`.
For Copilot-only project use, choose `'.\.github\skills'`. For another repository,
use its absolute destination; for personal Claude Code use
`(Join-Path $HOME '.claude\skills')`, and similarly for the other clients.

### Claude custom-skill upload

For a Claude interface/account that offers custom Skills uploads, upload
`dist\seo.zip` from the knowledge-base root through its skill-management interface
and enable the skill. The ZIP contains one `seo` folder with SKILL.md and all
supporting files. Interface availability, enabled capabilities, and upload
requirements depend on the product/account; follow the current
[Claude help](https://support.claude.com/en/articles/12512180-use-skills-in-claude).

For filesystem clients, unzip and place the `seo` folder at the selected location.
The original `resources` directory and PDF are not required.

## Invoke

| Client | Example |
| --- | --- |
| Claude Code | `/seo Audit this site and prioritize evidence-backed fixes.` |
| Codex | `$seo Audit this site and prioritize evidence-backed fixes.` |
| Copilot CLI | `Use the /seo skill to audit this site and prioritize evidence-backed fixes.` |
| Other supported Copilot agent interfaces | Ask to use the SEO skill; relevant requests can trigger it automatically |
| Claude custom-skill interface | Enable the skill and request an SEO audit or other matching task |

The description also enables automatic matching for relevant requests.

After installation, start a new session if needed. Claude Code exposes `/seo`.
Codex detects local skill changes automatically according to its documentation;
restart if the skill is missing. In Copilot CLI, use `/skills reload`, then
`/skills info seo` to check discovery. These commands are not identical across
clients.

## Evidence and maintenance

The **2026-10-11 review** covered all 56 local Markdown entries, equivalent HTML
archives, and every page of the **182-page September 2025 quality-rater PDF**.
The source map documents exact duplicates, redirected/mislabeled entries,
historical statements, generated secondary dossiers, and supplemental official
guidance. In particular, it does not teach obsolete FAQ rich-result eligibility
or treat leak analyses as confirmed ranking formulas.

References are original summaries with source attribution, not redistributed
copies of Google's manual or HTML. No license is inferred for the source corpus,
and no platform-specific permissions or automatic tool approvals are declared.

When maintaining the skill, recheck current official destinations, feature
support, policy dates, and reporting behavior; update the provenance map and
affected guides together. Refreshing the original corpus does not automatically
regenerate this skill.

Regenerate the archive from the knowledge-base root after intentional changes:

```powershell
New-Item -ItemType Directory -Path '.\dist' -Force | Out-Null
Compress-Archive -LiteralPath '.\skills\seo' -DestinationPath '.\dist\seo.zip' -Force
```

Use the bundled evaluation scenarios to check guardrails. Frontmatter and
package integrity checks establish format compatibility, not that every model
client has been executed or that future search outcomes are guaranteed.

## Platform format and installation references

- [Agent Skills specification](https://agentskills.io/specification)
- [Claude Code skills](https://code.claude.com/docs/en/skills)
- [Codex skills](https://developers.openai.com/codex/skills)
- [Copilot agent skills](https://docs.github.com/en/copilot/concepts/agents/about-agent-skills)
- [Copilot CLI skills](https://docs.github.com/en/copilot/how-tos/copilot-cli/customize-copilot/add-skills)
