require 'test_helper'

module MobiCms
  class DataContentsControllerTest < ActionController::TestCase
    setup do
      @data_content = data_contents(:one)
    end
  
    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:data_contents)
    end
  
    test "should get new" do
      get :new
      assert_response :success
    end
  
    test "should create data_content" do
      assert_difference('DataContent.count') do
        post :create, data_content: { content_type: @data_content.content_type, values: @data_content.values }
      end
  
      assert_redirected_to data_content_path(assigns(:data_content))
    end
  
    test "should show data_content" do
      get :show, id: @data_content
      assert_response :success
    end
  
    test "should get edit" do
      get :edit, id: @data_content
      assert_response :success
    end
  
    test "should update data_content" do
      put :update, id: @data_content, data_content: { content_type: @data_content.content_type, values: @data_content.values }
      assert_redirected_to data_content_path(assigns(:data_content))
    end
  
    test "should destroy data_content" do
      assert_difference('DataContent.count', -1) do
        delete :destroy, id: @data_content
      end
  
      assert_redirected_to data_contents_path
    end
  end
end
