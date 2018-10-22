class Api::BaseController < ApplicationController

  rescue_from ::ApiError, with: :handle_error

  def handle_error(e)
    render json: { error_code: e.code, error_message: e.text }, status: e.status
  end

  before_action :validate_header, :authenticate

  protected
    def authenticate
    end

    def current_tenant
    end

    def validate_header
      validate_api_version
    end

    def validate_api_version
      raise HttpHeaderError unless request.headers['Api-Version'].present?
    end
end
