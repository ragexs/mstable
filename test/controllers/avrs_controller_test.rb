require 'test_helper'

class AvrsControllerTest < ActionController::TestCase
  setup do
    @avr = avrs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:avrs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create avr" do
    assert_difference('Avr.count') do
      post :create, avr: { comment: @avr.comment, date_off: @avr.date_off, date_on: @avr.date_on, material: @avr.material, mmm_id: @avr.mmm_id, type_avr: @avr.type_avr, user_id: @avr.user_id }
    end

    assert_redirected_to avr_path(assigns(:avr))
  end

  test "should show avr" do
    get :show, id: @avr
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @avr
    assert_response :success
  end

  test "should update avr" do
    patch :update, id: @avr, avr: { comment: @avr.comment, date_off: @avr.date_off, date_on: @avr.date_on, material: @avr.material, mmm_id: @avr.mmm_id, type_avr: @avr.type_avr, user_id: @avr.user_id }
    assert_redirected_to avr_path(assigns(:avr))
  end

  test "should destroy avr" do
    assert_difference('Avr.count', -1) do
      delete :destroy, id: @avr
    end

    assert_redirected_to avrs_path
  end
end
