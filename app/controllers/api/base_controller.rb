class Api::BaseController < ApplicationController

  before_action :authenticate, :validate_request

  protected
    def authenticate
      raise AuthenticateError unless current_tenant
    end

    def current_tenant
      api_key = request.headers['Authorization'].presence
      @current_tenant ||= ::Tenant.find_by(api_key: api_key)
    end

    def validate_request
      validate_api_version
      validate_expire
    end

    def validate_expire
      raise ApiKeyExpiredError if current_tenant.expired?
    end

    def validate_api_version
      raise HttpHeaderError unless request.headers['Api-Version'].present?
    end

    def current_page
      params.fetch(:page, 1)
    end

    def per_page
      params.fetch(:per_page, 10)
    end
end
