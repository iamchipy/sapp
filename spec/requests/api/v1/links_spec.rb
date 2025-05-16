require 'swagger_helper'

RSpec.describe 'API::V1::Links', type: :request do
  path '/api/v1/links' do
    get('List all links') do
      tags 'Links'
      produces 'application/json'

      response(200, 'successful') do
        # Optional: create test data with FactoryBot or fixtures
        # before do
        #   create_list(:link, 3)
        # end

        run_test!
      end
    end
  end
end
