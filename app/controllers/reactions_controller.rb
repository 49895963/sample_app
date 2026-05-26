class ReactionsController < ApplicationController
  before_action :logged_in_user

  def create
    micropost = Micropost.find(params[:micropost_id])
    current_user.react(micropost)
    redirect_back fallback_location: root_url, status: :see_other
  end

  def destroy
    reaction = current_user.reactions.find(params[:id])
    reaction.destroy
    redirect_back fallback_location: root_url, status: :see_other
  end
end
