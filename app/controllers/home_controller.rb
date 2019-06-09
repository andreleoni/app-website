class HomeController < ApplicationController
  def index
    @messages = load_messages
  end

  private

  def load_messages
    RestClient.get("#{ENV["MESSAGES_MS_URL"]}/v1/messages")
  rescue
    "Service unavailable"
  end
end
