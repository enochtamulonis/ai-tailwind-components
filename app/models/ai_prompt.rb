class AiPrompt
  attr_reader :ai_prompt, :success, :results
  def initialize(ai_prompt)
      @success = false
      @ai_prompt = ai_prompt
  end

  def call
      client = OpenAI::Client.new
      question = "Make me a tailwindcss component #{ai_prompt}. "
      question += "Make it look pretty "
      question += "only return the html don't include any javascript code or cdns or css"
      response = client.chat(
          parameters: { 
              model: "gpt-3.5-turbo", # Required.
              messages: [{ role: "user", content: question}], # Required.
              temperature: 0.7,
          })
      if response["error"].present?
          return 
      end
      @success = true
      @results = response['choices'][0]['message']['content']
  end
end