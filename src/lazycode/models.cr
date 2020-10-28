module LazyCode::Models
  struct SuccessfulResponse
    include JSON::Serializable

    getter run_request : RunRequest
  end

  struct SuccessfulResponse::RunRequest
    include JSON::Serializable

    getter run : Run
  end

  struct SuccessfulResponse::RunRequest::Run
    include JSON::Serializable

    getter stdout : String
    getter stderr : String
  end

  struct FailedResponse
    include JSON::Serializable

    getter error : Error
  end

  struct FailedResponse::Error
    include JSON::Serializable

    getter message : String
  end
end
