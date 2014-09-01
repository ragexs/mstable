require 'test_helper'

class MmmsControllerTest < ActionController::TestCase
  setup do
    @mmm = mmms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mmms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mmm" do
    assert_difference('Mmm.count') do
      post :create, mmm: { adress: @mmm.adress, ingress: @mmm.ingress, ip: @mmm.ip, mdu: @mmm.mdu, mod: @mmm.mod, porch: @mmm.porch, sys_name: @mmm.sys_name }
    end

    assert_redirected_to mmm_path(assigns(:mmm))
  end

  test "should show mmm" do
    get :show, id: @mmm
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mmm
    assert_response :success
  end

  test "should update mmm" do
    patch :update, id: @mmm, mmm: { adress: @mmm.adress, ingress: @mmm.ingress, ip: @mmm.ip, mdu: @mmm.mdu, mod: @mmm.mod, porch: @mmm.porch, sys_name: @mmm.sys_name }
    assert_redirected_to mmm_path(assigns(:mmm))
  end

  test "should destroy mmm" do
    assert_difference('Mmm.count', -1) do
      delete :destroy, id: @mmm
    end

    assert_redirected_to mmms_path
  end
end
