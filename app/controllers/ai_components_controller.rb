class AiComponentsController < ApplicationController
  before_action :set_ai_component, only: %i[ show edit update destroy ]
  before_action :authenticate_user_free_trys, except: :show
  before_action :ensure_subscription
  # GET /ai_components or /ai_components.json
  def index
    @ai_components = current_user.ai_components.all
  end

  # GET /ai_components/1 or /ai_components/1.json
  def show
  end

  # GET /ai_components/new
  def new
    @ai_component = AiComponent.new
  end

  # GET /ai_components/1/edit
  def edit
  end

  # POST /ai_components or /ai_components.json
  def create
    @klass = current_user ? current_user.ai_components : AiComponent
    @ai_component = @klass.new(ai_component_params)
    @uniq_id = params[:uniq_id]
    @ai_component.broadcast_replace_to(@uniq_id, partial: "shared/loader", target: "#{@uniq_id}-container")
    if ai_component_params[:ai_prompt].present?
      service = TailwindComponentService.new(ai_component_params[:ai_prompt])
      service.call
      session[:free_trys] = 0
      @ai_component.update(html_content: service.html, ai_results: service.ai_results)
    end
    respond_to do |format|
      if @ai_component.save
        format.html { redirect_to ai_component_url(@ai_component), notice: "Ai component was successfully created." }
        format.json { render :show, status: :created, location: @ai_component }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ai_component.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ai_components/1 or /ai_components/1.json
  def update
    respond_to do |format|
      if @ai_component.update(ai_component_params)
        format.html { redirect_to ai_component_url(@ai_component), notice: "Ai component was successfully updated." }
        format.json { render :show, status: :ok, location: @ai_component }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ai_component.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ai_components/1 or /ai_components/1.json
  def destroy
    @ai_component.destroy

    respond_to do |format|
      format.html { redirect_to ai_components_url, notice: "Ai component was successfully destroyed." }
      format.json { head :no_content }
    end
  end

    # Use callbacks to share common setup or constraints between actions.
    def set_ai_component
      @ai_component = AiComponent.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ai_component_params
      params.require(:ai_component).permit(:html_content, :name, :css_content, :ai_prompt)
    end
end
