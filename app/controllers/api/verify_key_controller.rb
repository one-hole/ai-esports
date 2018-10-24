module Api
  class VerifyKeyController < BaseController

    skip_before_action :validate_request

    def index
      if verify?
        render json: { message: 'success' }, status: 200
      else
        render json: { message: 'failed' }, status: 400
      end
    end

    protected
      def verify?
        decrypt = Rsa::Tools.pri_decrypt(current_tenant.private_key, sign)
        return decrypt == original_data
      end

      def authenticate
        raise AuthenticateError unless current_tenant
      end

      def current_tenant
        api_key = request.headers['Authorization'].presence
        @current_tenant ||= ::Tenant.find_by(api_key: api_key)
      end

      def sign
        params.fetch(:sign, '')
      end

      def original_data
        "a=1"
      end
  end
end

# GET origin_data="source=risewinter"

# 1. 商户需要加密数据
# 2. 我们解析数据即可
