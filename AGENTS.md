# Development Guide

## Nix

Use `nix flake` for environment setup. Benefits:
- **Reproducibility**: Exact same environment across machines
- **Isolation**: Dependencies don't interfere with system
- **Declarative**: Version all tools in `flake.nix`

```bash
nix flake show       # View available environments
nix develop          # Enter development shell
nix run .#<command>  # Run a flake command
```

## Test-Driven Development

Write tests first. Benefits:
- **Clear requirements**: Tests define expected behavior
- **Confidence**: Changes don't break existing functionality
- **Design**: Encourages modular, testable code

Run tests frequently during development.

## Functional Programming

Separate pure and impure code:

**Pure functions** (no side-effects):
- Same input → same output
- Testable, composable, predictable

**Impure code** (with side-effects):
- I/O, mutations, randomness
- Isolate at boundaries
- Keep minimal

Structure: Pure logic + thin impure wrapper.

## Workflow Best Practices

### Branching

- Work in feature branches off `main`
- Use descriptive branch names: `feature/add-user-auth`, `fix/login-redirect`

### Commits

- Use [conventional commits](https://www.conventionalcommits.org/):
  - `feat:` new feature
  - `fix:` bug fix
  - `refactor:` code reorganization
  - `test:` test additions/updates
  - `docs:` documentation changes
- Example: `feat: add email verification to user signup`
- Use `git commit` to create commits, then `gh pr create` to open PRs

### Pull Requests

- Keep descriptions short but informative
- Format: 1-2 bullet points explaining *why* not *what*
- Use `gh pr create --title "..." --body "..."` to create PRs
- Example body:
  ```
  - Add email verification step to improve security
  - Prevent unverified accounts from accessing paid features
  ```
