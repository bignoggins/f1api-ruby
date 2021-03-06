require "#{File.dirname(__FILE__)}/../../lib/f1api/oauth/credentials_authentication"

class CredentialsAuthenticationTest
  include FellowshipOneAPI::OAuth::CredentialsAuthentication
  attr_accessor :oauth_consumer
end

class CredentialsTest < Test::Unit::TestCase
  include FellowshipOneAPI
  def setup
    Configuration.environment = "test"
    Configuration.file_path = "#{File.dirname(__FILE__)}/../../config/f1-oauth.yml"

    @test_username = "testuser"
    @test_password = "testpass"

    @cred_test = CredentialsAuthenticationTest.new
    @cred_test.load_consumer_config
    @mocked_access_token = AccessTokenFixture.get(@cred_test.oauth_consumer)
    @mocked_request_token = RequestTokenFixture.get(@cred_test.oauth_consumer)
    cred = URI.encode(Base64.encode64("#{@test_username} #{@test_password}"))

    @mocked_user_uri = "#{Configuration.site_url}/V1/People/123456"

    @cred_test.oauth_consumer.stubs(:get_request_token).returns(@mocked_request_token)
    
    @cred_test.oauth_consumer.stubs(:request).with(:post, ::FellowshipOneAPI::Configuration.portal_credential_token_path,
                                                      nil, {}, "ec=#{cred}", {'Content-Type' => 'application/x-www-form-urlencoded'}).
                                                      returns(HttpFixture.new)
  end
  
  def test_portal_authorize!
    actual = @cred_test.authorize! @test_username, @test_password
    
    assert_equal(@mocked_user_uri, actual)
  end
  
  def test_weblink_authorize!
    cred = URI.encode(Base64.encode64("#{@test_username} #{@test_password}"))
    @cred_test.oauth_consumer = nil
    @cred_test.load_consumer_config(:weblink)
    @cred_test.oauth_consumer.expects(:request).with(:post, ::FellowshipOneAPI::Configuration.weblink_credential_token_path,
                                                      nil, {}, "ec=#{cred}", {'Content-Type' => 'application/x-www-form-urlencoded'}).returns(
                                                      HttpFixture.new).at_least_once
    @cred_test.authorize! @test_username, @test_password, :weblink
  end
  
  def test_get_access_token
    @cred_test.authorize! @test_username, @test_password
    
    assert_equal("access", @cred_test.access_token.token)
    assert_equal("token", @cred_test.access_token.secret)
  end
  
  def test_authorized_user_uri
    @cred_test.authorize! @test_username, @test_password
    
    assert_equal(@mocked_user_uri, @cred_test.authenticated_user_uri)
  end

  def test_bool_authenticate_with_valid_creds
    val = @cred_test.authenticate @test_username, @test_password

    assert(val)
  end

  def test_bool_authenticate_with_invalid_creds
    @cred_test.oauth_consumer.unstub(:request)
    @cred_test.oauth_consumer.unstub(:get_request_token)
    cred = URI.encode(Base64.encode64("#{@test_username} badpassword"))

    @cred_test.oauth_consumer.expects(:request).with(:post, ::FellowshipOneAPI::Configuration.portal_credential_token_path,
                                                      nil, {}, "ec=#{cred}", {'Content-Type' => 'application/x-www-form-urlencoded'}).returns(
                                                      HttpFixture.new("400")).at_least_once
    val = @cred_test.authenticate @test_username, "badpassword"
    assert val == false
  end

  def test_site_url
    @cred_test.load_consumer_config :portal, "http://foo.com"

    assert_equal "http://foo.com", @cred_test.oauth_consumer.site
  end
end
