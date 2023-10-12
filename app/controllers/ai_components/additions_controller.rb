class AiComponents::AdditionsController < ApplicationController
  before_action :set_ai_component, :authenticate_user_free_trys

  def create
    TailwindComponentJob.perform_later(@ai_component.id, prompt: params[:ai_component][:ai_prompt])
    @ai_component.broadcast_update_to(@ai_component, target: ActionView::RecordIdentifier.dom_id(@ai_component), partial: "shared/loader")
    redirect_to ai_component_path(@ai_component)
  end

  private

  def set_ai_component
    @ai_component = AiComponent.find(params[:ai_component_id])
  end
end