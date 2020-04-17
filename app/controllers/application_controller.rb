class ApplicationController < ActionController::Base
  def index
    render text: "hello"
  end
end
