class FreeComponentPacksController < ApplicationController
  def show
    @component_pack = ComponentPack.find(params[:id])
  end
end