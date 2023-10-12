module Admins::ComponentPacks
  class AiComponentsController < Admins::BaseController
    def create
      @component_pack = ComponentPack.find(params[:component_pack_id])
      @ai_component = @component_pack.ai_components.new
      @ai_component.broadcast_update_to(@component_pack, partial: "shared/loader", target: "ai-component-form")
      if params[:ai_component][:ai_prompt].present?
        prompt = params[:ai_component][:ai_prompt]
        prompt += "make it a #{@ai_component.name} component "
        service = TailwindComponentService.new(prompt)
        service.call
        @ai_component.update(html_content: service.html, ai_results: service.ai_results)
      end
      if @ai_component.save
        redirect_to ai_component_url(@ai_component), notice: "Ai component was successfully created."
      else
        redirect_to admins_component_packs_path, alert: "That component did not save"
      end
    end
  end
end