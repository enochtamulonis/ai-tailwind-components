module Admins
  class AiComponentsController < Admins::BaseController
    def index
      if params[:date]
        @ai_components = AiComponent.where("created_at > ?", params[:date]).order(created_at: :desc)
      else
        @ai_components = AiComponent.all.order(created_at: :desc)
      end
    end

    def show
      @ai_component = AiComponent.find(params[:id])
    end
  end
end