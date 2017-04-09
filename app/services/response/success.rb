module Response
  # Success Response Service
  # - should be initialized with a data value
  class Success < Response::Base
    def response
      { json: { data: data }, status: :ok }
    end
  end
end
