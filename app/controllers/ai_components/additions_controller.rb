class AiComponents::AdditionsController < ApplicationController
  before_action :set_ai_component

  def create
    service = TailwindComponentService.new(params[:ai_component][:ai_prompt], old_results: @ai_component.html_content)
    service.call
    @ai_component.update(html_content: service.html, ai_results: service.ai_results)
    redirect_to @ai_component
  end

  private

  def set_ai_component
    @ai_component = AiComponent.find(params[:ai_component_id])
  end
end