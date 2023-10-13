class AiComponents::EditCodeController < ApplicationController
  before_action :set_component
  def new
  end

  def create
    @ai_component.update(html_content: ai_component_params[:html_content])
    if @ai_component.save
      @ai_component.broadcast_update_to(@ai_component, html: @ai_component.html_content, target: ActionView::RecordIdentifier.dom_id(@ai_component))
      redirect_to @ai_component
    else
      render :new
    end
  end

  private

  def set_component
    @ai_component = AiComponent.find(params[:ai_component_id])
  end

  def ai_component_params
    params.require(:ai_component).permit(:html_content)
  end
end