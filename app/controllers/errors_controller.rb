class ErrorsController < ApplicationController

  def not_found
    json_response({ message: 'route not found' }, :not_found)
  end

end