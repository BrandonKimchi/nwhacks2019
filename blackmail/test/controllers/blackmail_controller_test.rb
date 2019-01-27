require 'test_helper'

class BlackmailControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get blackmail_index_url
    assert_response :success
  end

end
