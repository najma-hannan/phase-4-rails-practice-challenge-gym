class GymsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_error
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_params
  wrap_parameters format: []

  def index
    render json: Gym.all, status: :ok
  end

  def show
    gym = find_gym
    render json: gym, status: :ok
  end

  def update
    gym = find_gym
    gym.update!(gym_params)
    render json: gym, status: :ok
  end

  def destroy
    gym = find_gym
    gym.destroy
    head :no_content
  end

  private

  def find_gym
    Gym.find(params[:id])
  end

  def not_found_error
    render json: {error: "Gym not found"}, status: :not_found
  end

  def gym_params
    params.permit(:name, :address)
  end

  def invalid_params(invalid)
    render json: {errors: invalid.record.errors}, status: :unprocessable_entity
  end

end
