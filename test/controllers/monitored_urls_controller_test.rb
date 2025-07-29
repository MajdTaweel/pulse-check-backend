require "test_helper"

class MonitoredUrlsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @monitored_url = monitored_urls(:one)
    @user = users(:one)
    sign_in @user
  end

  test "should get index" do
    get monitored_urls_url, as: :json
    assert_response :success
  end

  test "should create monitored_url" do
    assert_difference("MonitoredUrl.count") do
      post monitored_urls_url, params: {
        monitored_url: {
          check_interval: 300,
          url: "https://unique-test-url.com",
          name: "New Test URL"
        }
      }, as: :json
    end

    assert_response :created
  end

  test "should show monitored_url" do
    get monitored_url_url(@monitored_url), as: :json
    assert_response :success
  end

  test "should update monitored_url" do
    patch monitored_url_url(@monitored_url), params: {
      monitored_url: {
        check_interval: 600,
        name: "Updated Test URL"
      }
    }, as: :json
    assert_response :success
  end

  test "should destroy monitored_url" do
    assert_difference("MonitoredUrl.count", -1) do
      delete monitored_url_url(@monitored_url), as: :json
    end

    assert_response :no_content
  end
end
