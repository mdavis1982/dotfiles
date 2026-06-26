# Migrations
These are conventions for writing and updating migration files.

## General rules
- Always use the anonymous-class form (`return new class extends Migration { ... };`)
- Type-hint the closure: `function (Blueprint $table): void`
- `down()` reverses `up()`

## Formatting
- Group columns under comment headers, always in this order: `// ID`, `// Relationships`, `// Data`, `// Indexes`:

```php
Schema::create('{table}', function (Blueprint $table): void {
    // ID
    $table->id();

    // Relationships
    $table->foreignIdFor({Related}::class)->constrained()->cascadeOnDelete();

    // Data
    $table->string('title');
    $table->string('subtitle')->nullable();

    $table->timestamp('opens_at');
    $table->timestamp('closes_at');

    $table->timestamps();
});
```

- If a section does not have any content, the header should stay in place and the body of that section should be `// ...`:

```php
Schema::create('{table}', function (Blueprint $table): void {
    // ID
    $table->id();

    // Relationships
    // ...

    // Data
    $table->string('name');

    $table->timestamps();
});
```

- **`// ID`** - the primary key (`$table->id()`)
- **`// Relationships`** - foreign keys (see **Foreign keys** below)
- **`// Data`** - the table's own columns
- **`// Indexes`** - any explicit indexes. Omitted if not required
- Group semantically related columns with blank lines. The date pair in the example above sits apart from the strings
- Use blank lines liberally within a section to show where one logical group ends and the next begins
- A blank line always precedes `$table->timestamps();`
- A blank line always precedes each heading, apart from the first

## Column-specific rules
- Mark optional columns with `->nullable()`
- Never use `unsigned` shorthand methods. Compose the base type with the `->unsigned()` modifier instead:

```php
// YES
$table->integer('order')->unsigned();
$table->bigInteger('views')->unsigned();

// NO
$table->unsignedInteger('order');
$table->unsignedBigInteger('views');
```

## Foreign keys
- Prefer `foreignIdFor({Related}::class)` over a handwritten `{related}_id` column. Let the column name be derived from the model class automatically
- Choose the on-delete behaviour deliberately. If you're unsure, ask the user to clarify:

| Behaviour | Use when                                          | Modifier                                      |
|-----------|---------------------------------------------------|-----------------------------------------------|
| Cascade   | The child cannot exist without its parent         | `->constrained()->cascadeOnDelete()`          |
| Null      | The parent is optional                            | `->nullable()->constrained()->nullOnDelete()` |
| Restrict  | Deleting a parent with children should be blocked | `->constrained()->restrictOnDelete()`         |

```php
// Cascade: children are deleted with the parent
$table->foreignIdFor({Parent}::class)->constrained()->cascadeOnDelete();

// Null: the column is nulled when the optional parent is deleted
$table->foreignIdFor({Parent}::class)->nullable()->constrained()->nullOnDelete();

// Restrict: the parent cannot be deleted while children exist
$table->foreignIdFor({Parent}::class)->constrained()->restrictOnDelete();
```

## Pivot tables
- Pivot tables have no `id()` but keep the `// ID` heading with a `// ...` body to keep migrations consistent
- Both foreign keys cascade so the link disappears with either side
- Timestamps should be added like any other table
- The table name is the two singular model names in alphabetical order, joined with `_`

```php
Schema::create('{model_a}_{model_b}', function (Blueprint $table): void {
    // ID
    // ...

    // Relationships
    $table->foreignIdFor({ModelA}::class)->constrained()->cascadeOnDelete();
    $table->foreignIdFor({ModelB}::class)->constrained()->cascadeOnDelete();

    // Data
    $table->timestamps();
});
```

- Any pivot table extra columns (e.g. `order` for sorting) are added under the `// Data` heading
