require "json"
require "http/client"
require "uri"

require "./errors"
require "./models"

class LazyCode::Carcin
  API_URL      = "https://carc.in/"
  HTTP_HEADERS = HTTP::Headers{"Content-Type" => "application/json"}

  def initialize(api_url : String = API_URL, @http_headers : HTTP::Headers = HTTP_HEADERS)
    @client = HTTP::Client.new URI.parse(api_url)
  end

  private def remove_ansi_colors(text : String) : String
    text.gsub(/\e\[[0-9;]*m/, "")
  end

  def run_request(language : String, version : String, code : String) : String
    body = {
      "run_request": {
        "language": language,
        "version":  version,
        "code":     code,
      },
    }.to_json

    response = @client.post("/run_requests", @http_headers, body)

    if response.success?
      response_content = Models::SuccessfulResponse.from_json(response.body).run_request.run
      if response_content.stderr.empty?
        response_content.stdout
      else
        remove_ansi_colors response_content.stderr.lines[..-2].join("\n")
      end
    else
      response_content = Models::FailedResponse.from_json(response.body).error.message
      raise Errors::RequestError.new(response_content)
    end
  end
end
