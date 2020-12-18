require "yaml"

module LazyCode
  struct Config
    include YAML::Serializable

    getter token : String

    def self.parse_file(path : String)
      self.from_yaml File.open(path)
    end
  end
end
