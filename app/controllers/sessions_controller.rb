class SessionsController < ApplicationController
  def create
    @user = User.find_or_create_by_oauth(auth_hash)
    unless @user.persisted?
      flash[:error] = 'Unable to login at this time.'
      redirect_to :root_path and return
    end
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
