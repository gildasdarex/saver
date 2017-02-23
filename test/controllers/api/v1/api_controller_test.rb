# frozen_string_literal: true
require 'test_helper'

# Pages controller test class
class ApiControllerTest < ActionDispatch::IntegrationTest
  test 'should get 401 when request content type not json' do
    get '/api/v1/pages', as: :xml
    assert_response :not_acceptable
  end
end
