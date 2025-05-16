require 'swagger_helper'

RSpec.describe 'api/v1/links', type: :request do
  path '/api/v1/links' do
    get('list links') do
      tags 'Links'
      produces 'application/json'

      response(200, 'successful') do
        run_test!
      end
    end

    post('create link') do
      tags 'Links'
      consumes 'application/json'
      parameter name: :link, in: :body, schema: {
        type: :object,
        properties: {
          url: { type: :string },
          description: { type: :string }
        },
        required: ['url']
      }

      response(201, 'created') do
        let(:link) { { url: 'https://example.com', description: 'Example site' } }
        run_test!
      end
    end
  end

  path '/api/v1/links/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show link') do
      tags 'Links'
      produces 'application/json'
      response(200, 'successful') do
        let(:id) { Link.create(url: 'https://example.com', description: 'Example').id }
        run_test!
      end
    end

    patch('update link') do
      tags 'Links'
      consumes 'application/json'
      parameter name: :link, in: :body, schema: {
        type: :object,
        properties: {
          url: { type: :string },
          description: { type: :string }
        }
      }

      response(200, 'updated') do
        let(:id) { Link.create(url: 'https://example.com').id }
        let(:link) { { description: 'Updated description' } }
        run_test!
      end
    end

    delete('delete link') do
      tags 'Links'
      response(204, 'no content') do
        let(:id) { Link.create(url: 'https://example.com').id }
        run_test!
      end
    end
  end
end
