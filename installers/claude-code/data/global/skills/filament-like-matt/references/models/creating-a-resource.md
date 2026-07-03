# Creating a resource
This guide walks through adding a new Filament resource end to end.

## 1. Scaffold the resource
Generate the resource with default Filament stubs, and with no generation.

```bash
php artisan filament:resource --record-title-attribute=<attribute> --view --no-interaction <ModelName>
```

This uses the default Filament resource stubs. Never hand-write these files from scratch.

## 2. Add more information to the List<ModelName> page
In the generated List page (located in `app/Filament/Resources/<ModelName>/Pages/List<ModelName>.php`), retitle the create button and add an icon:

```php
protected function getHeaderActions(): array
{
    return [
        CreateAction::make()
            ->label('Create <model name>')
            ->icon(Lucide::Plus),
    ];
}
```

- Replace `<model name>` with a singular, lowercase, human readable version of the model name.
- Remember to import `FuzzyFox\Lucide\Lucide`

## 3. Update the main resource file
In the `app/Filament/Resources/<ModelName>/<ModelName>Resource.php` file:

- Add a navigation group to the resource before the `$navigationIcon` property, selected from the `app/Filament/Enums/NavigationGroup.php` enum:

```php
protected static string|UnitEnum|null $navigationGroup = NavigationGroup::Content;

protected static string|BackedEnum|null $navigationIcon = Heroicon::OutlinedRectangleStack;
```

- Update the navigation icon to an appropriate Lucide icon, remembering to import `FuzzyFox\Lucide\Lucide`

## 4. Update the table
In the `app/Filament/Resources/<ModelName>/Tables/<ModelName>Table.php` file:

- Add a pretty empty state after the `toolbarActions` section:

```php
->emptyStateHeading('No <models> yet')
->emptyStateDescription('Once you create your first <model> it will appear here.')
->emptyStateIcon(<ModelName>Resource::getNavigationIcon())
->emptyStateActions([
    CreateAction::make()
        ->label('Create <model>')
        ->icon(Lucide::Plus),
]);
```

- Group the record actions into a group:

```php
->recordActions([
    ActionGroup::make([
        ViewAction::make(),
        EditAction::make(),
    ]),
])
```

## 5. Format and verify
Run the test and quality suite once everything is in place. See the Verification section in the `laravel-like-matt` skill if it is available for specific instructions. If not, run `composer test` and fix any issues.
