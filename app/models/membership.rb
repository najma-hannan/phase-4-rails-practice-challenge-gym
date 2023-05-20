class Membership < ApplicationRecord
  belongs_to :gym
  belongs_to :client

  validates :gym_id, uniqueness: {scope: :client, message: "A client can only have one membership per gym"}
end
