# Models
These are conventions for writing, updating and maintaining Eloquent models. This file also serves as an index to detailed guides for specific model operations.

## General rules
- **DO NOT** add `$fillable` or `$guarded`. `Model::unguard()` is applied globally in `AppServiceProvider::configureModels()`
- Cast **every property that is not a string** in the `casts()` method. String columns need no cast. Don't cast foreign IDs
- Cast timestamps to `immutable_datetime`. The project uses `CarbonImmutable` for all dates
- Use attributes (e.g. `#[Hidden([...])]`) rather than class properties where an equivalent attribute exists

## Morph map
- **Every** model must be registered in the morph map, even if it is never used as a morph target. In `AppServiceProvider::configureMorphMap()`, add an entry to `Relation::enforceMorphMap([...])` keyed by a lowercase singular alias, kept in alphabetical order (and add the `use App\Models\<ModelName>;` import):

```php
Relation::enforceMorphMap([
    'company' => Company::class,
    'user' => User::class,
]);
```

## Keeping column order in sync
- Treat the migration's column order as canonical
- Mirror the canonical order everywhere: the model's `casts()`, the factory `definition()`, and any list of columns in the model's unit tests
- If a column is renamed or reordered, update it everywhere

## Where to go next
For anything beyond these general rules, read the matching guide and follow it.

| Reference                                            | When to use                                         |
|------------------------------------------------------|-----------------------------------------------------|
| [Creating a model](models/creating-a-model.md)       | Creating a new model in the application.            |
| [Model relationships](models/model-relationships.md) | Creating, updating or testing a model relationship. |
| [Model factories](models/model-factories.md)         | Creating or updating a model's factory.             |
