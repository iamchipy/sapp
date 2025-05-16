class Api::V1::LinksController < ApplicationController
  # You might want to skip authenticity token for API calls
  skip_before_action :verify_authenticity_token
  before_action :set_link, only: [:show, :update, :destroy]

  def index
    @links = Link.all
    render json: @links
  end

  def show
    render json: @link
  end

  def update
    if @link.update(link_params)
      render json: @link
    else
      render json: { errors: @link.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @link.destroy
    head :no_content
  end

  def create
    @link = Link.find_by(original_url: link_params[:original_url]) || Link.new(link_params)

    # Since API skips validation unless behaving like a form we need to manually validate
    # @link.generate_short_code if @link.short_code.blank?

    if @link.persisted?
      render json: { link: @link, message: "This URL has already been shortened." }, status: :ok
    elsif @link.save
      render json: { link: @link, message: "Link was successfully shortened." }, status: :created
    else
      render json: { errors: @link.errors.full_messages }, status: :unprocessable_entity
    end
  end


  private

  def set_link
    @link = Link.find_by(id: params[:id])
    render json: { error: "Link not found" }, status: :not_found unless @link
  end

  def link_params
    # API often uses a root key like the web form, but might be different
    # Adjust require(:link) based on expected JSON structure from third party
    params.require(:link).permit(:original_url)
    # Or if they just send { "original_url": "..." }:
    # params.permit(:original_url)
  end
end
