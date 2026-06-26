# One-to-many
These are the conventions for implementing a one-to-many relationship. The examples below use a `Company` that has many `Employee`s.

## Migration
The child table holds the foreign key. See [Migrations](../../migrations.md) to implement the foreign key correctly and to choose the correct deletion behaviour.

## Model methods
- Define a typed method on each side of the relationship
- Import the `BelongsTo` / `HasMany` relation classes
- Ensure generics are documented in the docblock to keep PHPStan happy

The child `belongsTo` relationship:

```php
/**
 * @return BelongsTo<Company, $this>
 */
public function company(): BelongsTo
{
    return $this->belongsTo(Company::class);
}
```

The parent `hasMany` relationship:

```php
/**
 * @return HasMany<Employee, $this>
 */
public function employees(): HasMany
{
    return $this->hasMany(Employee::class);
}
```

## Factory
- Set the parent in the **child** factory so every child is created with one. See [Model factories](../model-factories.md).
- The parent factory needs nothing. Attach children at creation with `->has()`

## Tests
- Test **both sides** of the relationship

### Child side (`belongsTo`)
- The child belongs to its parent:

```php
it('belongs to a company', function (): void {
    $employee = Employee::factory()->create();

    expect($employee->company)
        ->toBeInstanceOf(Company::class);
});
```

- Test the deletion cascade rule. Choose the correct type of test:

```php
// Cascade on delete
it('is deleted when its company is deleted', function (): void {
    $employee = Employee::factory()->create();

    $employee->company->delete();

    expect(Employee::query()->count())
        ->toBe(0);
});

// Set null on delete
it('is orphaned when its company is deleted', function (): void {
    $employee = Employee::factory()->create();

    $employee->company->delete();

    expect($employee->refresh()->company)
        ->toBeNull();
});

// Restrict on delete
it('prevents its company from being deleted', function (): void {
    $employee = Employee::factory()->create();

    expect(fn (): bool => $employee->company->delete())
        ->toThrow(QueryException::class);
});
```

- The restrict on delete test needs `use Illuminate\Database\QueryException;` at the top of the file

### Parent side (`hasMany`)
- The parent can have none, one, or many children. Test each case:

```php
it('can have no employees', function (): void {
    $company = Company::factory()->create();

    expect($company->employees)
        ->toBeEmpty();
});

it('can have an employee', function (): void {
    $company = Company::factory()
        ->has(Employee::factory())
        ->create();

    expect($company->employees)
        ->toHaveCount(1);
});

it('can have many employees', function (): void {
    $company = Company::factory()
        ->has(Employee::factory()->count(3))
        ->create();

    expect($company->employees)
        ->toHaveCount(3);
});
```
