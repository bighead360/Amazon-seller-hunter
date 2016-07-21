require 'test_helper'

class HuntersControllerTest < ActionController::TestCase
  setup do
    @hunter = hunters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hunters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hunter" do
    assert_difference('Hunter.count') do
      post :create, hunter: { condition: @hunter.condition, isbn: @hunter.isbn, status: @hunter.status }
    end

    assert_redirected_to hunter_path(assigns(:hunter))
  end

  test "should show hunter" do
    get :show, id: @hunter
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hunter
    assert_response :success
  end

  test "should update hunter" do
    patch :update, id: @hunter, hunter: { condition: @hunter.condition, isbn: @hunter.isbn, status: @hunter.status }
    assert_redirected_to hunter_path(assigns(:hunter))
  end

  test "should destroy hunter" do
    assert_difference('Hunter.count', -1) do
      delete :destroy, id: @hunter
    end

    assert_redirected_to hunters_path
  end
end
