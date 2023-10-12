class AiComponentsController < ApplicationController
  before_action :set_ai_component, only: %i[ show edit update destroy ]
  # GET /ai_components or /ai_components.json
  def index
    @ai_components = current_user.ai_components.order(created_at: :desc)
  end

  # GET /ai_components/1 or /ai_components/1.json
  def show
    if @ai_component.user
      if !current_user ||  (current_user != @ai_component.user)
        return redirect_to root_path, alert: "You are not authorized to view this page"
      end
    end
  end

  # POST /ai_components or /ai_components.json
  def create
    if current_user
      if !current_user.active_subscription
        if current_user.daily_trys == 0
          return redirect_to new_subscription_path, alert: "Purchase a membership to create unlimited components"
        end
      end
    else
      if session[:free_try].present?
        return redirect_to new_user_session_path(more_info: true), alert: "Create an account to continue using Tailwind Genius"
      end
    end
    @klass = current_user ? current_user.ai_components : AiComponent
    @uniq_id = params[:uniq_id]
    @ai_component = @klass.new(ai_component_params)
    @ai_component.update(guest_token: @uniq_id)
    @ai_component.broadcast_replace_to(@uniq_id, partial: "shared/loader", target: "#{@uniq_id}-container")
    if ai_component_params[:ai_prompt].present?
      service = TailwindComponentService.new(ai_component_params[:ai_prompt])
      service.call
      @ai_component.update(html_content: service.html, ai_results: service.ai_results)
    end
    if @ai_component.save
      if current_user
        current_user.update(daily_trys: current_user.daily_trys - 1)
      else
        session[:free_try] = true
      end
      redirect_to ai_component_url(@ai_component), notice: "Ai component was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /ai_components/1 or /ai_components/1.json
  def destroy
    if !current_user.admin?
      redirect_to root_path, alert: "You are not authorized for this"
    end
    @ai_component.destroy

    respond_to do |format|
      format.html { redirect_to admin_component_pack(@ai_component), notice: "Ai component was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_ai_component
      @ai_component = AiComponent.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ai_component_params
      params.require(:ai_component).permit(:html_content, :name, :css_content, :ai_prompt)
    end
end
