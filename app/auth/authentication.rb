class Authentication
  def initialize(user_object)
    puts 'initialize begin'
    @email = user_object[:email]
    @password = user_object[:password]
    @user = User.find_by(email: @email)
    puts 'initialize complete'
  end

  def authenticate
    puts 'auth begin'
    @user && @user.authenticate(@password)
  end

  def generate_token
    'puts token gen'
    JsonWebToken.encode(user_id: @user.id)
  end
end