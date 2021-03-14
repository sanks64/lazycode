require "tourmaline"

require "./carcin"

class LazyCode::Bot < Tourmaline::Client
  @carcin = Carcin.new

  @[Command(["help", "start"])]
  def help_command(ctx)
    message = <<-MESSAGE
    Hello! This bot runs code using [carc.in](https://github.com/jhass/carc.in/).

    Command syntax:
    `/language version`
    `code`

    Example:
    `/ruby 2.7.0`
    `puts "Hello, world!"`
    MESSAGE

    ctx.message.chat.send_message(message, parse_mode: :markdown)
  end

  private def run_code(ctx : Tourmaline::CommandHandler::Context, language : String)
    version, _, code = ctx.text.partition("\n")

    if code.empty?
      message = "Invalid usage."
    else
      begin
        response = @carcin.run_request(language, version, code)
      rescue error : Errors::RequestError
        message = <<-MESSAGE
        Error!

        ```
        #{error}
        ```
        MESSAGE
      else
        message = "```\n#{response}\n```"
      end
    end

    ctx.message.chat.send_message(message, parse_mode: :markdown)
  end

  @[Command("gcc")]
  def c_command(ctx)
    run_code(ctx, "gcc")
  end

  @[Command("crystal")]
  def crystal_command(ctx)
    run_code(ctx, "crystal")
  end

  @[Command("ruby")]
  def ruby_command(ctx)
    run_code(ctx, "ruby")
  end
end
