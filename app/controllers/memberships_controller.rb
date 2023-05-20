class MembershipsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_params
  wrap_parameters format: []

  def create
    membership = Membership.create!(membership_params)
    render json: membership, status: :created
  end

  private

  def membership_params
    params.permit(:charge, :gym_id, :client_id)
  end

  def invalid_params(invalid)
    render json: {errors: invalid.record.errors}, status: :unprocessable_entity
  end
end
