# Verification
**A task is not complete until `composer test` runs with every element passing.**

```bash
composer test
```

If any single element fails, the task is **not** done. The underlying problem must be fixed and `composer test` re-run. Keep going around this loop until `composer test` reports no problems at all.

## What `composer test` runs
`composer test` first clears the configuration cache, and then chains the checks below. Each has a specific, required response when it fails.

### Type coverage - `pest --type-coverage --min=100`
If type coverage checks fail, **add the missing types**. Every parameter, return type and property must be typed so coverage stays at 100%. This includes `void` types.

### Unit tests - `pest --parallel`
If unit tests fail, **fix the code** so the tests pass. Only change the tests if the test itself is genuinely wrong - the default response is to fix the code under test.

### Pint - `pint --test`
If Pint fails, run it with no arguments to fix the problems automatically:

```bash
pint
```

### Prettier - `npm run test:lint`
If Prettier fails, run the lint script to fix the issues automatically:

```bash
npm run lint
```

### PHPStan - `phpstan`
If PHPStan fails, **make changes to the code** so that PHPStan is happy. Fix the code properly.

**DO NOT** add `@phpstan-ignore` or any similar suppression / baseline entry to silence an error. Address the root cause.

### Rector - `rector --dry-run`
If Rector fails, run it without arguments to apply the refactoring fixes automatically:

```bash
rector
```

## The verification loop
1. Run `composer test`
2. For the first failing element, apply the required response from the section above
3. Re-run `composer test`
4. Repeat until `composer test` passes with no problems reported
