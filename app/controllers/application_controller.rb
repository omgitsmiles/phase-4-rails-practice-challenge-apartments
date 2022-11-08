class ApplicationController < ActionController::API
    rescue_from ActiveRecord::RecordInvalid, with: :render_entity_not_processable

    private

    def render_entity_not_processable(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: 422
    end

end
