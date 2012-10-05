require 'test_helper'

class OnlineCvFieldsControllerTest < ActionController::TestCase
  setup do
    @online_cv_field = online_cv_fields(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:online_cv_fields)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create online_cv_field" do
    assert_difference('OnlineCvField.count') do
      post :create, :online_cv_field => @online_cv_field.attributes
    end

    assert_redirected_to online_cv_field_path(assigns(:online_cv_field))
  end

  test "should show online_cv_field" do
    get :show, :id => @online_cv_field.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @online_cv_field.to_param
    assert_response :success
  end

  test "should update online_cv_field" do
    put :update, :id => @online_cv_field.to_param, :online_cv_field => @online_cv_field.attributes
    assert_redirected_to online_cv_field_path(assigns(:online_cv_field))
  end

  test "should destroy online_cv_field" do
    assert_difference('OnlineCvField.count', -1) do
      delete :destroy, :id => @online_cv_field.to_param
    end

    assert_redirected_to online_cv_fields_path
  end
end
