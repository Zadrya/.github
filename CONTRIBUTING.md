# Contributing to Zadrya

Thank you for your interest. Zadrya is a small project with strict rules about privacy and history, so please read this before you start.

## Before you write code

- For anything larger than a small fix, open an issue first so the approach can be agreed on.
- Security problems go through private reporting, see [SECURITY.md](SECURITY.md).
- Corrections to substance data belong in [Zadrya/Data](https://github.com/Zadrya/Data).

## Principles that a change must respect

- **No data leaves the device.** No analytics, crash reporting, ads or new network connections.
- **No new dependencies with telemetry or networking.** Dependencies must be compatible with GPL-3.0-or-later.
- **Non-judgmental harm reduction.** Inform, never lecture.

## How to work

1. Create a branch named `feature/<description>` or `fix/<description>`.
2. Make small commits: one logical change each, with a [conventional commit](https://www.conventionalcommits.org) message in English.
3. Run `make check` before every commit and `make ci` before opening the pull request.
4. Open one pull request per functional slice, ideally under 400 lines of diff. Pull requests are merged by rebase.

## Commit authorship

Every commit on `main` is authored and committed by the maintainer, and CI enforces it. Contributions from other people are therefore applied by the maintainer and credited in the pull request and the changelog. Commit messages must not contain co-author trailers or AI attribution lines.

## License

By contributing you agree that your contribution is licensed under GPL-3.0-or-later.
