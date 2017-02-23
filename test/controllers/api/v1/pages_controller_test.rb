# frozen_string_literal: true
require 'test_helper'

# Pages controller test class
class PagesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get '/api/v1/pages', as: :json
    assert_response :success
    assert_equal response.content_type, 'application/json'
    (0..1).each do |index|
      page = Page.find(index)
      body_response = JSON.parse(response.body)
      assert_equal page.id, body_response[index]['id']
      assert_equal page.url, body_response[index]['url']
      assert_equal page.contents, body_response[index]['contents']
    end
  end

  test 'should get index with paginations' do
    get '/api/v1/pages?page[number]=1&page[size]=1', as: :json
    assert_response :success
    assert_equal response.content_type, 'application/json'
    page = Page.first
    body_response = JSON.parse(response.body)
    assert_equal 1, body_response.count
    assert_equal page.id, body_response[0]['id']
    assert_equal page.url, body_response[0]['url']
    assert_equal page.contents, body_response[0]['contents']
  end

  test 'should create page' do
    url = "#{ENV['HOST']}/test_url.html"
    assert_difference('Page.count') do
      post '/api/v1/pages', params: { page: { url: url } }, as: :json
    end
    assert_response 201
    assert_equal response.content_type, 'application/json'
    body_response = JSON.parse(response.body)
    assert_equal url, body_response['url']
    assert_equal ['H1 title'], body_response['contents']['h1']
    assert_equal ['H2 title'], body_response['contents']['h2']
    assert_equal ['H3 title'], body_response['contents']['h3']
    assert_equal ['http://test_link.com'], body_response['contents']['a']
  end

  test 'should create page with only the tags sent' do
    url = "#{ENV['HOST']}/test_url.html"
    assert_difference('Page.count') do
      post '/api/v1/pages', params: { page: { url: url, tags: ['h1'] } }, as: :json
    end
    assert_response 201
    assert_equal response.content_type, 'application/json'
    body_response = JSON.parse(response.body)
    assert_equal url, body_response['url']
    assert_equal ['h1'], body_response['contents'].keys
    assert_equal ['H1 title'], body_response['contents']['h1']
  end
end
