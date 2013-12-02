require 'test_helper'

class ApiScreencastsTest < ActionDispatch::IntegrationTest
  test "get /screencasts.json" do
    get "/screencasts.json"
    assert_response :success
    assert body == Screencast.all.to_json
    screencasts = JSON.parse(response.body)
    assert screencasts.size == 3 # because there are three fixtures (see screencasts.yml)
    assert screencasts.any? { |s| s["title"] == screencasts(:fast_rails_commands).title }
  end

  test "get /screencasts/:id" do
    screencast = screencasts(:fast_rails_commands)
    get "/screencasts/#{screencast.id}.json"
    assert_response :success
    assert body == screencast.to_json
    assert JSON.parse(response.body)["title"] == screencast.title
  end
end