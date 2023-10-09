class AiComponent < ApplicationRecord
  def get_tailwind_code_from_ai
    ai_prompt_service = AiPrompt.new(ai_prompt)
    ai_prompt_service.call
    if ai_prompt_service.success
      pieces = ai_prompt_service.results.split("```html").last
      html = pieces.split("```")[0].gsub("`", "")
      # Save the file locally so tailwind compile loads classes for development
      if Rails.env.development?
        file_path = Rails.root.join('tmp', "classes", "tailwind-component-#{SecureRandom.hex(6)}.txt")

        File.open(file_path, 'w') do |file|
          # Add text to the file
          file.puts(html)
        end
        puts "SAVED THE FILE"
      end

      update(html_content: html, ai_results: ai_prompt_service.results)
    end
  end
end
