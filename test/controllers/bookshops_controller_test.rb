require 'test_helper'

class BookshopsControllerTest < ActionController::TestCase
  setup do
    @bookshop = bookshops(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bookshops)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bookshop" do
    assert_difference('Bookshop.count') do
      post :create, bookshop: { shopname: @bookshop.shopname }
    end

    assert_redirected_to bookshop_path(assigns(:bookshop))
  end

  test "should show bookshop" do
    get :show, id: @bookshop
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bookshop
    assert_response :success
  end

  test "should update bookshop" do
    patch :update, id: @bookshop, bookshop: { shopname: @bookshop.shopname }
    assert_redirected_to bookshop_path(assigns(:bookshop))
  end

  test "should destroy bookshop" do
    assert_difference('Bookshop.count', -1) do
      delete :destroy, id: @bookshop
    end

    assert_redirected_to bookshops_path
  end
end
