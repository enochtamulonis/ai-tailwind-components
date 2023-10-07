class AiComponent < ApplicationRecord
  def get_tailwind_code_from_ai
    ai_prompt_service = AiPrompt.new(ai_prompt)
    ai_prompt_service.call
    if ai_prompt_service.success
      pieces = ai_prompt_service.results.split("```html").last
      html = pieces.split("```")[0].gsub("`", "")
      update(html_content: html, ai_results: ai_prompt_service.results)
    end
  end
end
