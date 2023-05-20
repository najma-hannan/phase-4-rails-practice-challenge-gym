class ClientsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_error
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_params
  wrap_parameters format: []

  def index
    render json: Client.all, status: :ok
  end

  def show
    client = find_client
    render json: client, serializer: ClientTotalSerializer, status: :ok
  end

  def update
    client = find_client
    client.update!(client_params)
    render json: client, serializer: ClientTotalSerializer, status: :ok
  end

  private

  def find_client
    Client.find(params[:id])
  end

  def client_params
    params.permit(:name, :age)
  end


  def not_found_error
    render json: {error: "Client not found"}, status: :not_found
  end

  def invalid_params(invalid)
    render json: {errors: invalid.record.errors}, status: :unprocessable_entity
  end

end
