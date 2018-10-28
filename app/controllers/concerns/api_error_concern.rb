# 1xxx: Authentication errors               没有认证
# 2xxx: HTTP params validation errors       参数错误
# 3xxx: Authorization errors                没有权限
# 4xxx: Domain errors
# 5xxx: Other errors
# 9xxx: Record errors                       Record not Found not Updated not Deleted

module ApiErrorConcern

  class AuthenticateError < ApiError
    def initialize
      super code: 1001, text: '无法拿到商户APi令牌', status: 401
    end
  end

  class ApiKeyExpiredError < ApiError
    def initialize
      super code: 1002, text: '商户的APi令牌已经过期', status: 403
    end
  end

  class HttpHeaderError < ApiError
    def initialize
      super code: 2001, text: '请求头参数错误', status: 403
    end
  end

  class TeamNotFoundError < ApiError
    def initialize
      super code: 5000, text: '查询的队伍没有找到', status: 404
    end
  end

end
