class TailwindComponentJob < ApplicationJob
  queue_as :default

  def perform(ai_component_id, prompt: nil)
    # Do something later
    return if prompt.nil?
    ai_component = AiComponent.find(ai_component_id)
    service = TailwindComponentService.new(prompt, old_results: ai_component.html_content)
    service.call
    ai_component.update(html_content: service.html, ai_results: service.ai_results)
    ai_component.broadcast_update_to(ai_component, html: ai_component.html_content, target: ActionView::RecordIdentifier.dom_id(ai_component))
  end
end
