# Model factories
These are the conventions for writing model factories. They keep factories consistent with the migration, model and tests.

## Generating a factory
- If you are generating a model from scratch, scaffold the factory rather than hand writing it:

```bash
php artisan make:model -mf <ModelName>
```

- If you are writing a factory for an existing model, use the artisan command to generate it:

```bash
php artisan make:factory -m <ModelName> <ModelName>Factory
```

Generating factories in this way ensures that the customised `factory.stub` in `stubs/` is used. Don't write the file from scratch.

## The `definition()` method
- Populate **all** columns with real values, including optional ones. Tests create models via the factory and assert each column's type, so optional columns must **not** be `null` by default
- Generate values with the `fake()` helper
- Mirror the model's migration column order. The model's migration order is canonical

```php
/**
 * Define the model's default state.
 *
 * @return array<string, mixed>
 */
public function definition(): array
{
    return [
        'name' => fake()->company(),
        'url' => fake()->url(),
        'logo_path' => fake()->slug() . '.png',
    ];
}
```

## State methods
- Add a state method **only when useful**. Don't add them speculatively. Some examples of useful states:
    - to `null` an optional field
    - to represent a meaningful variant
    - to set status columns
- Give every state method a docblock in the form `Indicate that the <model> ...`
- Return `static`, mutating attributes through `->state()`
- **DO NOT** write tests for state methods. They exist to compose models in other tests, not to be tested themselves, so they never appear in the model's unit test

```php
/**
 * Indicate that the product has no image.
 */
public function withoutImage(): static
{
    return $this->state(fn (array $attributes): array => [
        'image' => null,
    ]);
}
```

## Relationships
- Wire relationships through the factory so created models are valid:

```php
'{parent}_id' => {Parent}::factory(),
```

- In tests, compose factories with `->for()` and `->has()` / `->hasAttached()`
