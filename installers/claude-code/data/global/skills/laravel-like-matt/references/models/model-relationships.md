# Model relationships
These are the conventions for wiring relationships between Eloquent models.

## General rules
- Define each relationship as a typed method on the model (e.g. `public function shows(): HasMany`)
- Wire **both** sides of the relationship, and add a test for each side
- Set the matching foreign key or pivot table in a migration. See [Migrations](../migrations.md)

## Where to go next
For each different type of relationship, read the matching guide and follow it.

| Reference                                     | When to use                                                  |
|-----------------------------------------------|--------------------------------------------------------------|
| [One-to-many](relationships/one-to-many.md)   | A `belongsTo` / `hasMany` pair; the child owns a foreign key |
| [Many-to-many](relationships/many-to-many.md) | A `belongsToMany` pair joined through a pivot table          |
