# Many-to-many
These are the conventions for implementing a many-to-many relationship. The examples below use a `Playlist` and a `Song` joined through a `playlist_song` pivot.

## Migration
- The two models are joined by a pivot table that holds both foreign keys
- The pivot table also holds any extra pivot columns

See [Migrations](../../migrations.md) to implement the pivot table.

## Model methods
- Define a typed `belongsToMany` method on each side of the relationship
- Import the `BelongsToMany` relation class
- Ensure generics are documented in the docblock to keep PHPStan happy
- Expose pivot columns with `->withPivot()`
- Add `->withTimestamps()` to maintain the pivot's timestamps
- Add `->orderByPivot()` only on the side where ordering is meaningful and only if ordering is required. In this example a playlist's songs are ordered but a song's playlists are not.

The `Playlist` side:

```php
/**
 * @return BelongsToMany<Song, $this>
 */
public function songs(): BelongsToMany
{
    return $this->belongsToMany(Song::class)
        ->withPivot('order')
        ->withTimestamps()
        ->orderByPivot('order');
}
```

The `Song` side:

```php
/**
 * @return BelongsToMany<Playlist, $this>
 */
public function playlists(): BelongsToMany
{
    return $this->belongsToMany(Playlist::class)
        ->withPivot('order')
        ->withTimestamps();
}
```

## Factory
- Neither model's factory sets the relationship. The link lives in the pivot. See [Model factories](../model-factories.md)
- Attach related models at creation with `->hasAttached()`, passing any needed pivot data (e.g. `['order' => 1]`)

## Tests
- Test **both sides** of the relationship

### Playlist side
- A playlist can have none, one or many songs, in order. Test each case:

```php
it('can have no songs', function (): void {
    $playlist = Playlist::factory()->create();

    expect($playlist->songs)
        ->toBeEmpty();
});

it('can have a song', function (): void {
    $playlist = Playlist::factory()
        ->hasAttached(Song::factory(), ['order' => 1])
        ->create();

    expect($playlist->songs)
        ->toHaveCount(1);
});

it('can have many songs', function (): void {
    $playlist = Playlist::factory()
        ->hasAttached(Song::factory()->count(3), ['order' => 1])
        ->create();

    expect($playlist->songs)
        ->toHaveCount(3);
});

it('orders songs correctly', function (): void {
    $playlist = Playlist::factory()->create();

    $first = Song::factory()->create();
    $second = Song::factory()->create();
    $third = Song::factory()->create();

    $playlist->songs()->attach([
        $second->id => ['order' => 2],
        $third->id => ['order' => 3],
        $first->id => ['order' => 1],
    ]);

    expect($playlist->songs->pluck('id')->all())
        ->toBe([
            $first->id,
            $second->id,
            $third->id,
        ]);
});
```

- Both pivot foreign keys cascade, so deleting a song removes the link but leaves the playlist:

```php
it('keeps the playlist when one of its songs is deleted', function (): void {
    $playlist = Playlist::factory()
        ->hasAttached(Song::factory(), ['order' => 1])
        ->create();

    $playlist->songs->first()->delete();

    expect($playlist->refresh()->songs)
        ->toBeEmpty();
});
```

### Song side
- A song can belong to one or many playlists. Test each case:

```php
it('can belong to a playlist', function (): void {
    $song = Song::factory()
        ->hasAttached(Playlist::factory(), ['order' => 1])
        ->create();

    expect($song->playlists)
        ->toHaveCount(1);
});

it('can belong to multiple playlists', function (): void {
    $song = Song::factory()
        ->hasAttached(Playlist::factory()->count(3), ['order' => 1])
        ->create();

    expect($song->playlists)
        ->toHaveCount(3);
});
```
