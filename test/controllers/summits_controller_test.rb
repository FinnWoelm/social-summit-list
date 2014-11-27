require 'test_helper'

class SummitsControllerTest < ActionController::TestCase
  setup do
    @summit = summits(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:summits)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create summit" do
    assert_difference('Summit.count') do
      post :create, summit: { admin_email: @summit.admin_email, admin_url: @summit.admin_url, contact_email: @summit.contact_email, contact_website: @summit.contact_website, cost: @summit.cost, currency: @summit.currency, date_end: @summit.date_end, date_start: @summit.date_start, deadline: @summit.deadline, fields: @summit.fields, idea_stage: @summit.idea_stage, implementation_stage: @summit.implementation_stage, language: @summit.language, location_city: @summit.location_city, location_country: @summit.location_country, name: @summit.name, operating_stage: @summit.operating_stage, planning_stage: @summit.planning_stage }
    end

    assert_redirected_to summit_path(assigns(:summit))
  end

  test "should show summit" do
    get :show, id: @summit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @summit
    assert_response :success
  end

  test "should update summit" do
    patch :update, id: @summit, summit: { admin_email: @summit.admin_email, admin_url: @summit.admin_url, contact_email: @summit.contact_email, contact_website: @summit.contact_website, cost: @summit.cost, currency: @summit.currency, date_end: @summit.date_end, date_start: @summit.date_start, deadline: @summit.deadline, fields: @summit.fields, idea_stage: @summit.idea_stage, implementation_stage: @summit.implementation_stage, language: @summit.language, location_city: @summit.location_city, location_country: @summit.location_country, name: @summit.name, operating_stage: @summit.operating_stage, planning_stage: @summit.planning_stage }
    assert_redirected_to summit_path(assigns(:summit))
  end

  test "should destroy summit" do
    assert_difference('Summit.count', -1) do
      delete :destroy, id: @summit
    end

    assert_redirected_to summits_path
  end
end
