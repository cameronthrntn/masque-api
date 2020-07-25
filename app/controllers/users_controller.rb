class UsersController < ApplicationController
  before_action :set_user, only: [:show, :destroy]

  def index
    unless params['access']
      json_response({ message: 'An access key is required' }, :not_found)
    else
      @user = User.find_by!(access: params['access'])
      json_response(@user)
    end
  end

  def create
    if(validate_access(params['word'], params['number'], params['pin'])) 
      @user = User.create!({ access: params['word'] + params['number']+ params['pin']})
      json_response(@user, :created)
    else 
      json_response({ message: 'Invalid user' }, :unprocessable_entity)
    end
  end

  def destroy
    @user.destroy
    head :no_content
  end

  private

  def user_params
    params.permit(:word, :number, :pin,)
    return params.permitted?
  end

  def set_user
    @user = User.find_by(params[:access])
  end

  def validate_access(word, num, pin)
    return num.length < 5 && pin.length < 10 && pin.split('').uniq.length == pin.split('').uniq.length
  end

end
