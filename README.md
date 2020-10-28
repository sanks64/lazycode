# LazyCode

## About

A Telegram bot that runs code.

I made this because I'm too lazy to code from my phone using web interfaces.

## Installation

1. Create a bot using [the official instructions](https://core.telegram.org/bots).
2. Copy the config file from `src/config.example.yml` to `src/config.yml` and adjust the values.
3. Resolve dependencies using `shards update`.
4. Run `crystal src/lazycode.cr --release`.

## Contributing

1. Make the changes.
2. Add additional specs if needed.
3. Format your code using `bin/ameba`.
4. Create a new pull request.
