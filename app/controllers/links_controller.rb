class LinksController < ApplicationController
  def index
    @links = Link.all # Active Record query
  end

  def new
    @link = Link.new # Create a new Link object for the form
  end

  def create
    begin
      original_url = link_params[:original_url]

      if original_url.blank?
        flash.now[:alert] = "Original URL can't be blank."
        return render :new
      end

      @link = Link.find_by(original_url: original_url)

      if @link
        redirect_to @link, notice: "This URL has already been shortened."
      else
        @link = Link.new(link_params)

        if @link.save
          redirect_to @link, notice: "Link was successfully shortened."
        else
          flash.now[:alert] = "There was a problem shortening the URL."
          render :new
        end
      end

    rescue => e
      logger.error "Error creating link: #{e.message}"
      flash.now[:alert] = "An unexpected error occurred. Please try again."
      render :new
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
