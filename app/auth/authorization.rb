class Authorization
  def initialize(request)
    puts("auth request")
    pattern = /^Bearer /
    header  = request.headers['Authorization']
    @token = header.gsub(pattern, '') if header && header.match(pattern)
    #puts token
    #@token = request.headers[:HTTP_TOKEN]
  end

  def current_user
    puts(@token? "token present" : "no token present")
    puts @token
    JsonWebToken.decode(@token)[:user_id] if @token
  end
end