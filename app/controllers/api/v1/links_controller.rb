class Api::V1::LinksController < ApplicationController
  # You might want to skip authenticity token for API calls
  skip_before_action :verify_authenticity_token

  def create
    @link = Link.new(link_params)

    if @link.save
      render json: @link, status: :created # Success: return Link object as JSON, 201 status
    else
      render json: @link.errors, status: :unprocessable_entity # Failure: return errors as JSON, 422 status
    end
  end

  private

  def link_params
    # API often uses a root key like the web form, but might be different
    # Adjust require(:link) based on expected JSON structure from third party
    params.require(:link).permit(:original_url)
    # Or if they just send { "original_url": "..." }:
    # params.permit(:original_url)
  end
end
