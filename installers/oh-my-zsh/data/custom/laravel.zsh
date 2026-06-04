# Shorthand for running Artisan commands
alias pa="php artisan"

# Launch the Laravel Tinker REPL
alias tinker="php artisan tinker"

# Tail the Laravel log file, highlighting timestamped entries and exception chains
alias llog='tail -f -n 450 storage/logs/laravel*.log | grep -i -E "^\[\d{4}\-\d{2}\-\d{2} \d{2}:\d{2}:\d{2}\]|Next [\w\W]+?\:" --color'

# Run composer test
alias ct='composer test'
