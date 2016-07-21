require 'test_helper'

class IsbnsControllerTest < ActionController::TestCase
  setup do
    @isbn = isbns(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:isbns)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create isbn" do
    assert_difference('Isbn.count') do
      post :create, isbn: { isbn: @isbn.isbn }
    end

    assert_redirected_to isbn_path(assigns(:isbn))
  end

  test "should show isbn" do
    get :show, id: @isbn
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @isbn
    assert_response :success
  end

  test "should update isbn" do
    patch :update, id: @isbn, isbn: { isbn: @isbn.isbn }
    assert_redirected_to isbn_path(assigns(:isbn))
  end

  test "should destroy isbn" do
    assert_difference('Isbn.count', -1) do
      delete :destroy, id: @isbn
    end

    assert_redirected_to isbns_path
  end
end
