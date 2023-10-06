require "test_helper"

class AiComponentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ai_component = ai_components(:one)
  end

  test "should get index" do
    get ai_components_url
    assert_response :success
  end

  test "should get new" do
    get new_ai_component_url
    assert_response :success
  end

  test "should create ai_component" do
    assert_difference("AiComponent.count") do
      post ai_components_url, params: { ai_component: { html_content: @ai_component.html_content, name: @ai_component.name } }
    end

    assert_redirected_to ai_component_url(AiComponent.last)
  end

  test "should show ai_component" do
    get ai_component_url(@ai_component)
    assert_response :success
  end

  test "should get edit" do
    get edit_ai_component_url(@ai_component)
    assert_response :success
  end

  test "should update ai_component" do
    patch ai_component_url(@ai_component), params: { ai_component: { html_content: @ai_component.html_content, name: @ai_component.name } }
    assert_redirected_to ai_component_url(@ai_component)
  end

  test "should destroy ai_component" do
    assert_difference("AiComponent.count", -1) do
      delete ai_component_url(@ai_component)
    end

    assert_redirected_to ai_components_url
  end
end
