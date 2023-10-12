module Admins
  class ComponentPacksController < Admins::BaseController
    before_action :set_component_pack, only: [:show, :edit, :update]
    def index
      @component_packs = ComponentPack.all
    end

    def new
      @component_pack = ComponentPack.new
    end

    def create
      @component_pack = ComponentPack.create(component_pack_params)
      if @component_pack.save
        if Rails.env.development?
          save_css_to_file(component_pack_params[:container_css])
        end
        redirect_to admins_component_pack_path(@component_pack)
      else
        render :new
      end
    end

    def edit; end

    def show; end

    def update
      if @component_pack.update(component_pack_params)
        if Rails.env.development?
          save_css_to_file(component_pack_params[:container_css])
        end
        redirect_to admins_component_pack_path(@component_pack)
      else
        render :new
      end
    end

    def make_featured
      @component_pack = ComponentPack.find(params[:component_pack_id])
      @component_pack.update(featured: true)
      render turbo_stream: turbo_stream.replace(ActionView::RecordIdentifier.dom_id(@component_pack, :dropdown), partial: "dropdown", locals: { component_pack: @component_pack })
    end

    def turn_off_featured
      @component_pack = ComponentPack.find(params[:component_pack_id])
      @component_pack.update(featured: false)
      render turbo_stream: turbo_stream.replace(ActionView::RecordIdentifier.dom_id(@component_pack, :dropdown), partial: "dropdown", locals: { component_pack: @component_pack })
    end

    private

    def set_component_pack
      @component_pack = ComponentPack.find(params[:id])
    end

    def component_pack_params
      params.require(:component_pack).permit(:name, :description, :image, :container_css)
    end

    def save_css_to_file(css)
      if Rails.env.development?
        file_path = Rails.root.join('tmp', "classes", "tailwind-component-#{SecureRandom.hex(6)}.txt")

        File.open(file_path, 'w') do |file|
          # Add text to the file
          file.puts(css)
        end
        puts "🥳🚀SAVED THE FILE"
      end
    end
  end
end