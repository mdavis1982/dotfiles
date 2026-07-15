# Actions
These are conventions for writing, updating and maintaining reusable actions.

## General rules
- Actions should always have a corresponding interface
- Actions needs to be registered in the `$bindings` property of the `ActionsServiceProvider`
- Actions should always be invokable using an `__invoke` method

## Interfaces
- **Every** action must have a corresponding interface. The interface should be a plural version of the implementation class:

```php
// app/Contracts/Actions/User/CreatesUser.php
interface CreatesUser
{
    /**
     * @param  array<string, string>  $input
     */
    public function __invoke(array $input): User;
}
```

```php
// app/Actions/User/CreateUser.php
final class CreateUser implements CreatesUser
{
    /**
     * @param  array<string, string>  $input
     */
    public function __invoke(array $input): User
    {
        // Do the work
    }
}
```

## Testing
- Actions should always be tested
- If there is validation, use the `->toBeInvalid()` custom Pest assertion to test it:

```php
it('validates data correctly', function (array $data, array $errors): void {
    $user = User::factory()->create();

    $action = resolve(CreatesUser::class);

    expect(fn () => $action($data))
        ->toBeInvalid($errors);
})->with([
    'name missing' => [['name' => null], ['name' => 'required']],
    'name not a string' => [['name' => 123], ['name' => 'string']],
    'name too short' => [['name' => 'a'], ['name' => 'at least']],
    'name too long' => [['name' => Str::repeat('a', 256)], ['name' => 'greater than']],

    'email missing' => [['email' => null], ['email' => 'required']],
    'email not a string' => [['email' => 123], ['email' => 'string']],
    'email too short' => [['email' => 'a'], ['email' => 'at least']],
    'email too long' => [['email' => Str::repeat('a', 256)], ['email' => 'greater than']],
]);
```
