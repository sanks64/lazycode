require "tourmaline"

require "./lazycode/bot"
require "./lazycode/config"

config = LazyCode::Config.parse_file("src/config.yml")
bot = LazyCode::Bot.new(config.bot.token)
bot.poll
