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
      redirect_to @link, notice: "Link was successfully shortened." # Redirect on success
    #   THIS WAS FAILING because default for @link without more is ->> /links/:id
    #   :id was not being supported below in the SHOW method
    # if @link.save
    #   redirect_to short_link_path(@link.short_code), notice: 'Link was successfully shortened.'
    else
      render :new # Render the new template on failure (shows errors)
    end
  end

  def show
    @link = if params[:short_code]
      Link.find_by!(short_code: params[:short_code])
    else
      Link.find_by!(id: params[:id])
    end
  end


  private # Use private for helper methods not exposed as actions

  # Validation method to make sure we are given a URL in the input
  def link_params
    params.require(:link).permit(:original_url) # Strong parameters
    # TODO investigate further
  end
end
