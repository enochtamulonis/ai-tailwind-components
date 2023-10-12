module Admins
  class ComponentPacksController < Admins::BaseController
    def index
      @component_packs = ComponentPack.all
    end

    def new
      @component_pack = ComponentPack.new
    end

    def create
      @component_pack = ComponentPack.create(component_pack_params)
      if @component_pack.save
        redirect_to admins_component_pack_path(@component_pack)
      else
        render :new
      end
    end

    def show
      @component_pack = ComponentPack.find(params[:id])
    end
    private

    def component_pack_params
      params.require(:component_pack).permit(:name, :description)
    end
  end
end