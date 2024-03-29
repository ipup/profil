require 'test_helper'

class UserContentsControllerTest < ActionController::TestCase
  setup do
    @user_content = user_contents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_contents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_content" do
    assert_difference('UserContent.count') do
      post :create, :user_content => @user_content.attributes
    end

    assert_redirected_to user_content_path(assigns(:user_content))
  end

  test "should show user_content" do
    get :show, :id => @user_content.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @user_content.to_param
    assert_response :success
  end

  test "should update user_content" do
    put :update, :id => @user_content.to_param, :user_content => @user_content.attributes
    assert_redirected_to user_content_path(assigns(:user_content))
  end

  test "should destroy user_content" do
    assert_difference('UserContent.count', -1) do
      delete :destroy, :id => @user_content.to_param
    end

    assert_redirected_to user_contents_path
  end
end
