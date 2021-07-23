class ItemsRevenueSerializer
  include JSONAPI::Serializer

  set_type 'item_revenue'
  attributes :name, :description, :unit_price, :merchant_id, :revenue
end
