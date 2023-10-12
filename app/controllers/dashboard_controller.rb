class DashboardController < ApplicationController
  
  def show
    @component_packs = ComponentPack.where(featured: true)
  end
end
