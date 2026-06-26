# Enums
These are conventions for writing and updating enums.

## General rules
- Enums should live in the `app/Enums` directory
- Enums should use PascalCase for their cases
- Always implement a `label()` method for an enum:

```php
enum Status
{
    case Pending;
    case InProgress;
    case Completed;

    public function label(): string
    {
        return match ($this) {
            self::Pending => 'Pending',
            self::InProgress => 'In Progress',
            self::Completed => 'Completed',
        };
    }
}
```

## Backed enums
- Ask the user if an enum should be backed. If so, add the correct backing type and values
- If the backing type is a string, the values should be a lowercase, kebab-case version of the case:

```php
enum Status: string
{
    case Pending = 'pending';
    case InProgress = 'in-progress';
    case Completed = 'completed';

    public function label(): string
    {
        return match ($this) {
            self::Pending => 'Pending',
            self::InProgress => 'In Progress',
            self::Completed => 'Completed',
        };
    }
}
```

## Testing
- When creating or updating an enum, also implement a unit test for it:

```php
it('has the correct number of cases', function (): void {
    expect(Status::cases())
        ->toHaveCount(3);
});

it('contains the correct cases', function (Status $status): void {
    expect(Status::cases())
        ->toContain($status);
})->with([
    Status::Pending,
    Status::InProgress,
    Status::Completed,
]);

it('returns the correct labels', function (Status $status, string $label): void {
    expect($status->label())
        ->toBe($label);
})->with([
    [Status::Pending, 'Pending'],
    [Status::InProgress, 'In Progress'],
    [Status::Completed, 'Completed'],
]);
```

- If an enum is a backed enum, then also add a unit test to verify the values:

```php
it('has the correct string values', function (Status $status, string $value): void {
    expect($status->value)
        ->toBe($value);
})->with([
    [Status::Pending, 'pending'],
    [Status::InProgress, 'in-progress'],
    [Status::Completed, 'completed'],
]);
```

## Filament
- When creating an enum, ask the user if they want to implement the Filament interfaces `HasColor`, `HasIcon` and `HasLabel`. Allow the user to choose none, one or many.

### `HasColor` conformance
- If the user wants `HasColor` conformance, add the `use Filament\Support\Contracts\HasColor;` and implement:

```php
use Filament\Support\Contracts\HasColor;

enum Status: string implements HasColor
{
    case Pending = 'pending';
    case InProgress = 'in-progress';
    case Completed = 'completed';

    public function label(): string
    {
        return match ($this) {
            self::Pending => 'Pending',
            self::InProgress => 'In Progress',
            self::Completed => 'Completed',
        };
    }

    public function getColor(): string
    {
        return match ($this) {
            self::Pending => 'blue',
            self::InProgress => 'warning',
            self::Completed => 'success',
        };
    }
}
```

- Also add a unit test to check for conformance:

```php
it('implements the Filament HasColor contract', function (): void {
    expect(Status::class)
        ->toImplement(HasColor::class);
});
```

### `HasIcon` conformance
- If the user wants `HasIcon` conformance, add the `use Filament\Support\Contracts\HasIcon;` and implement the method, returning a suitable Lucide icon:

```php
use Filament\Support\Contracts\HasIcon;
use FuzzyFox\Lucide\Lucide;

enum Status: string implements HasIcon
{
    case Pending = 'pending';
    case InProgress = 'in-progress';
    case Completed = 'completed';

    public function label(): string
    {
        return match ($this) {
            self::Pending => 'Pending',
            self::InProgress => 'In Progress',
            self::Completed => 'Completed',
        };
    }

    public function getIcon(): Lucide
    {
        return match ($this) {
            self::Pending => Lucide::PencilLine,
            self::InProgress => Lucide::Clock,
            self::Completed => Lucide::Check,
        };
    }
}
```

- Also add a unit test to check for conformance:

```php
it('implements the Filament HasIcon contract', function (): void {
    expect(Status::class)
        ->toImplement(HasIcon::class);
});
```

### `HasLabel` conformance
- If the user wants `HasLabel` conformance, add the `use Filament\Support\Contracts\HasLabel;` and delegate to the `label()` method:

```php
use Filament\Support\Contracts\HasLabel;

enum Status: string implements HasLabel
{
    case Pending = 'pending';
    case InProgress = 'in-progress';
    case Completed = 'completed';

    public function label(): string
    {
        return match ($this) {
            self::Pending => 'Pending',
            self::InProgress => 'In Progress',
            self::Completed => 'Completed',
        };
    }

    public function getLabel(): string
    {
        return $this->label();
    }
}
```

- Also add a unit test to check for conformance:

```php
it('implements the Filament HasLabel contract', function (): void {
    expect(Status::class)
        ->toImplement(HasLabel::class);
});
```
