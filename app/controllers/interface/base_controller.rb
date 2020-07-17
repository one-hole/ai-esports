class Interface::BaseController < ApplicationController
  before_action :authenticate
  before_action :validate_request

  protected

  def authenticate
    raise AuthenticateError unless current_tenant
  end

  def current_tenant
    api_key = request.headers['Authorization'].presence
    @current_tenant ||= ::Tenant.find_by(api_key: api_key)
  end

  def validate_request
    validate_expire
  end

  def validate_expire
    raise ApiKeyExpiredError if current_tenant.expired?
  end

  def current_page
    params.fetch(:page, 1)
  end

  def per_page
    params.fetch(:per_page, 30)
  end

  def game
    params.fetch(:game, 1).to_i
  end

  def basic_meta
    {
      api_key_will_expired_at: current_tenant.expire_time.strftime("%F %T")
    }
  end
end