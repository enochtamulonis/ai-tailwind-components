require "application_system_test_case"

class AiComponentsTest < ApplicationSystemTestCase
  setup do
    @ai_component = ai_components(:one)
  end

  test "visiting the index" do
    visit ai_components_url
    assert_selector "h1", text: "Ai components"
  end

  test "should create ai component" do
    visit ai_components_url
    click_on "New ai component"

    fill_in "Html content", with: @ai_component.html_content
    fill_in "Name", with: @ai_component.name
    click_on "Create Ai component"

    assert_text "Ai component was successfully created"
    click_on "Back"
  end

  test "should update Ai component" do
    visit ai_component_url(@ai_component)
    click_on "Edit this ai component", match: :first

    fill_in "Html content", with: @ai_component.html_content
    fill_in "Name", with: @ai_component.name
    click_on "Update Ai component"

    assert_text "Ai component was successfully updated"
    click_on "Back"
  end

  test "should destroy Ai component" do
    visit ai_component_url(@ai_component)
    click_on "Destroy this ai component", match: :first

    assert_text "Ai component was successfully destroyed"
  end
end
