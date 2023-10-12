class AiComponents::AdditionsController < ApplicationController
  before_action :set_ai_component

  def create
    if current_user
      if !current_user.active_subscription
        if @ai_component.free_additions == 0
          return redirect_to new_subscription_path, alert: "Purchase a membership for unlimited additions and components"
        end
      end
    else
      return redirect_to new_user_session_path(more_info: true), alert: "Create an account to continue using Tailwind Genius"
    end

    TailwindComponentJob.perform_later(@ai_component.id, prompt: params[:ai_component][:ai_prompt])
    @ai_component.update(free_additions: @ai_component.free_additions - 1) if !current_user.active_subscription
    @ai_component.broadcast_update_to(@ai_component, target: ActionView::RecordIdentifier.dom_id(@ai_component), partial: "shared/loader")
    redirect_to ai_component_path(@ai_component)
  end

  private

  def set_ai_component
    @ai_component = AiComponent.find(params[:ai_component_id])
  end
end