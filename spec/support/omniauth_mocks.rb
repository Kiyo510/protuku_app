module OmniauthMocks
  def twitter_mock
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new(
      'provider' => 'twitter',
      'uid' => '12345',
      'info' => {
        'nickname' => 'Mock User',
        'image' => 'https://twitter.com/mock_image',
        'location' => '',
        'email' => 'mock_user@example.com',
        'urls' => {
          'Twitter' => 'https://twitter.com/MockUser123',
          'Website' => ''
        }
      },
      'credentials' => {
        'token' => 'mock_credentails_token',
        'secret' => 'mock_credentails_secret'
      },
      'extra' => {
        'raw_info' => {
          'name' => 'Mock User',
          'id' => '12345',
          'followers_count' => 0,
          'friends_count' => 0,
          'statuses_count' => 0
        }
      })
  end

  def twitter_invalid_mock
    OmniAuth.config.mock_auth[:twitter] = :invalid_credentails
  end
end
