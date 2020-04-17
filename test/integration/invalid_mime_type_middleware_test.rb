require 'test_helper'

class InvalidMimeTypeMiddlewareTest < ActionDispatch::IntegrationTest
  test 'invalid mime type should 406' do
    get '/', headers: { accept: "../../../etc/passwd" }
    assert_response :not_acceptable
  end
end
