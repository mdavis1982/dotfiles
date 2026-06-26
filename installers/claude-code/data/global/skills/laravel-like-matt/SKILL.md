---
name: laravel-like-matt
description: Applies PHP and Laravel conventions in the same way that Matt would. Use when writing or changing PHP or Laravel code to enforce a consistent style.
when_to_use: Use when making any changes to a Laravel project, including creating, updating, deleting and auditing code.
---

# Laravel Like Matt

## General rules
- Always use strict types. Start every PHP file with `declare(strict_types=1)`.
- Type every parameter, return type, and property - including void types.
- Use short nullable notation: `?string` not `string|null`.
- Prefer `final` classes. Favour immutability.
- Keep classes small and single-purpose, with clear, unabbreviated names.
- Let the linter own formatting. Don't hand-format code.

## Reference files
Before doing any of the work below, read the matching reference file and follow it.

| Reference                                  | When to use                                             |
|--------------------------------------------|---------------------------------------------------------|
| [Migrations](references/migrations.md)     | Writing or updating a database migration.               |
| [Models](references/models.md)             | Creating, editing or updating a model.                  |
| [Enums](references/enums.md)               | Creating, editing or updating enums.                    |
| [Verification](references/verification.md) | Verifying a change. Running the test and quality suite. |
