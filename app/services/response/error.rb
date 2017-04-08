module Response
  # Error Response Service
  # - should either be initialized with an array of messages or a single string message
  class Error < Response::Base
    def response
      { json: { data: "There was an issue with your request: #{format_error_text(data)}" }, status: :bad_request }
    end

    private

    def format_error_text(error)
      return error unless error.class == Array
      error.join(', ')
    end
  end
end
