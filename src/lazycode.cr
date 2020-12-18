require "tourmaline"

require "./lazycode/bot"
require "./lazycode/config"

config = LazyCode::Config.parse_file("src/config.yml")
bot = LazyCode::Bot.new(config.token)
bot.poll
