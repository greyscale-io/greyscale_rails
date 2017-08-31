require 'test_helper'

class FixtureConfigTest < ActionDispatch::IntegrationTest

  ORIGINAL_PAYLOAD= "[{\"first_name\":\"Greg\",\"last_name\":\"Orlov\",\"github\":\"gaorlov\",\"id\":\"greg\"}]"
  REVISED_PAYLOAD = "[{\"first_name\":\"Greg\",\"last_name\":\"Orlov\",\"github\":\"gaorlov\",\"id\":\"greg\"},{\"id\":\"mike\",\"first_name\":\"Mike\",\"last_name\":\"Uchman\",\"github\":\"muchman\"}]"

  def test_fixtures_load
    get "/users"
    assert_equal 200, status

    assert_equal ORIGINAL_PAYLOAD, @response.body
  end

  def test_revisions_load

    get "/users?revision=add_mike"

    assert_equal 200, status

    assert_equal REVISED_PAYLOAD, @response.body
  end

  def test_revisions_revert

    test_fixtures_load
    test_revisions_load
    test_fixtures_load
  end

end

