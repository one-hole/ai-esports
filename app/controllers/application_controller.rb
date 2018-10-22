class ApplicationController < ActionController::API
  rescue_from ::ApiError, with: :handle_error

  def handle_error(e)
    render json: { error_code: e.code, error_message: e.text }, status: e.status
  end

end
