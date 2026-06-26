# Creating a model
This guide walks through adding a new Eloquent model end to end.

## 1. Scaffold with the customised stubs
Generate the model, migration and factory together:

```bash
php artisan make:model -mf <ModelName>
```

This uses the customised stubs in `stubs/`. Never hand-write these files from scratch.

## 2. Define the migration
Add the table's columns to the generated migration. See [Migrations](../migrations.md) for the structure, column types and foreign-key
conventions.

## 3. Complete the model
- Add a cast for every non-string column to `casts()`. Don't cast strings or foreign IDs
- Register the model in the morph map
- Add any relationship methods. See [Model relationships](model-relationships.md)

See [Models](../models.md) for the casting and morph-map rules.

## 4. Fill in the factory
Populate the model factory. See [Model factories](model-factories.md).

## 5. Write the unit test
Every model has a test at `tests/Unit/Models/<ModelName>Test.php`, using the custom expectations defined in `tests/Pest.php`. Start with these two:

1. `it('has the correct columns')`. Assert the table's columns with `toHaveColumns`:

```php
it('has the correct columns', function (): void {
    expect('companies')->toHaveColumns([
        'id',
        'name',
        'url',
        'logo_path',
        'created_at',
        'updated_at',
    ]);
});
```

2. `it('casts columns to the correct types')`. Create a model via the factory and assert each column's type with `toBeOfType`, parameterised with `->with()`:

```php
it('casts columns to the correct types', function (string $column, string $type): void {
    $company = Company::factory()->create();

    expect($company->$column)
        ->toBeOfType($type);
})->with([
    ['id', 'int'],
    ['name', 'string'],
    ['url', 'string'],
    ['logo_path', 'string'],
    ['created_at', CarbonImmutable::class],
    ['updated_at', CarbonImmutable::class],
]);
```

- Use `'int'` / `'string'` for primitives and `CarbonImmutable::class` for timestamps; foreign IDs are
`'int'`.
- Add a test for each relationship, too. See [Model relationships](model-relationships.md).
- **DO NOT** write tests for factory state methods. The model unit test covers columns, casts and relationships only. State methods are not unit-tested.

## 6. Keep column order in sync
The migration's column order is canonical. Mirror it in `casts()`, the factory `definition()` and both column lists in the test. See [Models](../models.md).

## 7. Verify
Run the test and quality suite once everything is in place. See [Verification](../verification.md).
