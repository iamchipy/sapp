class LinksController < ApplicationController
  def index
    @links = Link.all # Active Record query
  end

  def new
    @link = Link.new # Create a new Link object for the form
  end

  def create
    @link = Link.find_by(original_url: link_params[:original_url]) || Link.new(link_params)

    if @link.persisted?
      redirect_to @link, alert: "This URL has already been shortened."
    elsif @link.save
      redirect_to @link, notice: "Link was successfully shortened."
    else
      flash.now[:alert] = @link.errors.full_messages.to_sentence
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

  # extract the link params
  def link_params
    params.require(:link).permit(:original_url)
  end
end
