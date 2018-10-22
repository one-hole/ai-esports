module Push
  class Request

    attr_accessor :tenant, :method, :params, :body

    def initialize(tenant, method, params, body)
      self.tenant, self.method, self.params, self.body = tenant, method, params, body
    end

    def exec
      request = Typhoeus::Request.new(
        @tenant.api_path,
        method:   @method,
        body:     encrypted_body,                      # string
        params:   { encrypted: encrypted_params },     # hash
        headers:  headers                              # hash
      )
      request.run
    end

    private
      def encrypted_body
        return "" if @body.blank?
      end

      def encrypted_params
        Rsa::Tools.pub_encrypt(@tenant.public_key, @params.merge(base_params).to_json)
      end

      def base_params
        {
          timestamp: Time.now.strftime("%F %T")
        }
      end

      def headers
        {
          "Api-Version":  "1.0",
          "Content-type": "application/json"
        }
      end
  end
end

# 需要知道是谁 （这样也同时知道了对方的 公钥）
# Rsa::Tools.pub_encrypt(pub_key, data)
