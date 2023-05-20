class ClientTotalSerializer < ActiveModel::Serializer
  attributes :name, :age, :total_memberships_amount

  def total_memberships_amount
    self.object.memberships.map {|membership| membership.charge }.sum
  end
end
