class TailwindComponentService
  attr_accessor :ai_prompt, :html, :ai_results
  def initialize(ai_prompt, old_results = nil)
    @ai_prompt = if old_results.present?
      "use these additions #{ai_prompt} and add to this tailwind code #{old_results}"
    else
      ai_prompt
    end
  end

  def call
    ai_prompt_service = AiPrompt.new(ai_prompt)
    ai_prompt_service.call
    if ai_prompt_service.success
      @html = extract_html(ai_prompt_service)
      # Save the file locally so tailwind compile loads classes for development
      if Rails.env.development?
        file_path = Rails.root.join('tmp', "classes", "tailwind-component-#{SecureRandom.hex(6)}.txt")

        File.open(file_path, 'w') do |file|
          # Add text to the file
          file.puts(html)
        end
        puts "SAVED THE FILE"
      end

      @ai_results = ai_prompt_service.results
    end
  end

  def extract_html(ai_prompt_service)
    pieces = ai_prompt_service.results.split("```html").last
    pieces.split("```")[0].gsub("`", "")
  end
end