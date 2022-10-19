class ApplicationController < ActionController::API
    def not_found
        respond_with '{"error": "not found"}', status: :not_found
    end
end
