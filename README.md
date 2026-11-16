# .github

Community health files and the organization profile for [Zadrya](https://github.com/Zadrya).

| File | Purpose |
| --- | --- |
| `profile/README.md` | Organization profile shown at github.com/Zadrya |
| `SECURITY.md` | How to report a vulnerability privately |
| `CONTRIBUTING.md` | How to contribute to any Zadrya repository |
| `CODE_OF_CONDUCT.md` | Contributor Covenant 2.1 |
| `.github/PULL_REQUEST_TEMPLATE.md`, `.github/ISSUE_TEMPLATE/` | Default templates for every repository |

These files apply to every repository in the organization that does not define its own.

## Development

```sh
make setup   # install the git hooks, once per clone
make check   # before every commit
make ci      # before opening a pull request
```

## License

GPL-3.0-or-later. See [LICENSE](LICENSE).
