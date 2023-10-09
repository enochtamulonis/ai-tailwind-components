class AiComponents::AdditionsController < ApplicationController
  before_action :set_ai_component, :authenticate_user_free_trys

  def create
    TailwindComponentJob.perform_later(@ai_component.id, prompt: params[:ai_component][:ai_prompt])
    render turbo_stream: turbo_stream.update(ActionView::RecordIdentifier.dom_id(@ai_component), partial: "shared/loader")
  end

  private

  def set_ai_component
    @ai_component = AiComponent.find(params[:ai_component_id])
  end
end