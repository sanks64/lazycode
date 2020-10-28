require "yaml"

module LazyCode
  struct Config
    include YAML::Serializable

    getter bot : Bot

    def self.parse_file(path : String)
      self.from_yaml File.open(path)
    end
  end

  struct Config::Bot
    include YAML::Serializable

    getter token : String
  end
end
