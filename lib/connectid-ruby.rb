require 'rails'
require 'oauth2'

class ConnectID
  @@client = nil
  #
  # Config
  #
  mattr_accessor :client_id
  @@client_id = nil
  #
  #
  #
  mattr_accessor :client_secret
  @@client_secret = nil
  #
  #
  #
  def self.setup
    yield self
    @@client = OAuth2::Client.new(@@client_id, @@client_secret,
      :site => 'https://connectid.no',
      authorize_url: "/user/oauth/authorize",
      token_url: "/user/oauth/token")
  end

  def self.get_products
    token = @@client.client_credentials.get_token
    Hash.from_xml token.get('https://api.mediaconnect.no/capi/v1/client/product/subscription').body
  end

  def self.get_coupons(product)
    token = @@client.client_credentials.get_token
    JSON.parse token.get("https://api.mediaconnect.no/capi/v1/client/coupon/#{product}").body
  end

  def self.get_token(auth_code, params)
    @@client.auth_code.get_token(auth_code, params)
  end

  def self.create_user_url(params)
    "https://connectid.no/user/createUser?clientId=#{@@client.id}" +
    "&returnUrl=#{params[:return_url]}" +
    "&errorUrl=#{params[:error_url]}" +
    "&credential=#{params[:credential]}" +
    "&credentialSubmit=true"
  end

  def self.authorize_url(params)
    @@client.auth_code.authorize_url(params)
  end

  def self.fulfillment_url(order_id, return_url)
    "https://login.mediaconnect.no/fulfillment?orderId=#{order_id}&returnUrl=#{return_url}"
  end

  def self.order(token, params)
    result = token.post "https://api.mediaconnect.no/capi/v1/order", {} do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['Accept'] = 'application/json'
      req.body = params.to_json
    end
    JSON.parse(result.body)
  end
end
