# Wordlit

**在语境里理解，然后继续阅读。**

Wordlit is the new public name of Dictionary. The product remains a native macOS
English reading companion: contextual word lookup, complete sentence/paragraph
translation and click-to-play American English speech.

## Visual identity

![Wordlit](wordlit-wordmark.svg)

The original mark combines a rounded W with a small warm light. Forest green
retains continuity with the previous app; ivory keeps the mark readable; a restrained
gold accent expresses “lit”. Do not add the old `d.` or change the W into text at
small sizes. The mark has a transparent margin for native app-icon placement.

| Element | Value |
| --- | --- |
| Product / application | Wordlit / `Wordlit.app` |
| Repository | [`liyunhui0707/wordlit`](https://github.com/liyunhui0707/wordlit) (renamed in place) |
| Checkout directory | `wordlit` |
| Release files since 0.11.0 | `Wordlit-<version>-macOS-<architecture>.dmg` and `.zip` |
| Companion display name | Wordlit Lookup |
| Accent | `#386751` / `#254C3B` |
| Paper / mark | `#FCFCF4` |
| Light accent | `#EBCB86` |
| Typography | Native system UI; serif word/brand display |

`scripts/generate-brand-assets.swift` is the editable, dependency-free artwork
source. Run it from the project root on macOS with `xcrun swift
scripts/generate-brand-assets.swift`. It creates the SVG marks, 1024px PNG, native
ICNS, extension icons, website favicons and a local preview under
`build/branding.noindex/`. It never opens windows, plays audio or downloads assets.
The artwork is original project material under the repository's MIT license.

## Compatibility is part of the rename

Public branding is separate from existing storage and protocol identity:

- Retain `com.liyunhui.DictionaryApp`, its testing counterpart, preference keys,
  Keychain service names, token location and local connection port. A new brand
  must not manufacture an empty user profile or ask users to pair again.
- Retain the internal `DictionaryApp` Swift module and packaged executable name.
  The Swift package/product is Wordlit; implementation namespaces are not branding.
- Retain the Obsidian plugin ID, browser command IDs and extension storage keys.
  The approved companion versions are Chromium 0.2.2 and Obsidian 0.1.1;
  this is a branding update, with no connection-protocol change.
  An already-loaded Dictionary Lookup keeps working through the unchanged protocol;
  no reload or pairing is required just to upgrade the app. Exporting to a new
  folder can create a different Chromium extension identity, so it is not claimed
  to preserve browser pairing or shortcuts. Do not force that step during the rename.
- The updater accepts only the two exact first-party repository paths and both
  artifact prefixes. Current source queries the Wordlit API first; only a 404
  tries the fixed legacy endpoint. Redirects are never followed. New artifacts
  are preferred when present. This source cleanup will ship in the next normal
  release; published 0.11.0 binaries retain their old-first, bounded fallback.
- Frozen pre-rename archives remain inspectable. Historical release notes, hashes,
  filenames, synthetic acceptance book titles and previously published assets
  stay unchanged. A historical Dictionary binary is never relabelled Wordlit.
- Use `wordlit` for the local checkout directory. Move the existing checkout as
  a whole, preserving `.git` and ignored local evidence; do not reclone or rewrite
  historical build records to change their original paths. Reopen editor/workspace
  entries at the new directory rather than keeping an old-name symlink.

## Completed public cutover

Wordlit 0.11.0 was delivered on 2026-11-18. The
[release record](../docs/releases/0.11.0.md) lists artifact verification,
both-Mac upgrade evidence and the remaining channel limits.

| Surface | Result |
| --- | --- |
| Initial source integration | [PR #15](https://github.com/liyunhui0707/wordlit/pull/15) merged after required CI; merge `2246411` contains source `f0f3483` |
| GitHub repository | Original repository renamed to `wordlit`; history, issues, tags and Releases preserved; clone remote uses the new name |
| Public download | [v0.11.0](https://github.com/liyunhui0707/wordlit/releases/tag/v0.11.0), with Wordlit ZIP, DMG, checksums and provenance manifest |
| Daily application | `Wordlit.app` on both accepted Macs; existing settings and verified 0.10.0 rollback retained |
| Website | Existing Site deployed with Wordlit identity and new repository/download links; public audience unchanged |

The existing [website address](https://dictionary-macos-liyunhui.outerepoch3.chatgpt.site)
is intentionally retained as a stable compatibility entry. Its old slug is not
an unfinished product-name replacement. Never recreate or reuse `dictionary-macos`
on GitHub: that would break the original repository redirect. Older app updaters
may reject renamed release URLs; their release notes provide the manual browser
upgrade path.

## Naming closure and retained names

The 2026-11-24 closure migrates the local checkout to `wordlit`, makes current
update/help source links canonical and fills in the delivery record. It does not
rebuild, replace or republish 0.11.0, install an app, or redeploy the website.

Remaining old names have explicit purposes:

- **User compatibility:** Bundle IDs, settings keys, Keychain service, token and
  managed-extension storage paths, plugin/command IDs and connection protocol.
- **Internal namespace:** `Sources/DictionaryApp`, `Tests/DictionaryAppTests`,
  Swift targets, executable/resource-bundle names and `DICTIONARY_*` launch/test
  variables. These are deliberately retained implementation contracts, not public
  branding; a future internal refactor must assess its own compatibility costs.
- **Historical evidence:** old release links, tags, filenames, hashes, manifests,
  synthetic book titles and ignored local acceptance/build records.
- **Compatibility coverage:** exact legacy repository URLs in updater allowlists
  and tests. Current UI examples and primary navigation use Wordlit.

New work must not reintroduce the old name into current product labels, primary
repository links or new artifact filenames. No automatic installer, model change
or permission reset is part of this closure.
