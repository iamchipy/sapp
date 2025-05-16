class LinksController < ApplicationController
  def index
    @links = Link.all # Active Record query
  end

  def new
    @link = Link.new # Create a new Link object for the form
  end

  def create
    @link = Link.new(link_params) # Use strong parameters

    if @link.save
      redirect_to @link, notice: 'Link was successfully shortened.' # Redirect on success
    else
      render :new # Render the new template on failure (shows errors)
    end
  end

  def show
    @link = Link.find_by!(short_code: params[:id]) # Find by short code
  end

  private # Use private for helper methods not exposed as actions

  def link_params
    params.require(:link).permit(:original_url) # Strong parameters
    # TODO investigate further
  end
end
