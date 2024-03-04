class OrderAddress
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :post_code, :prefecture_id, :municipalities, :block_number, :building_name, :phone_number, :order_id

  with_options presence: true do
    validates :item_id
    validates :user_id
    validates :post_code, format: { with: /\A\d{3}[-]\d{4}\z/, message: "はハイフンを含む半角数字で登録してください" }
    validates :municipalities
    validates :block_number
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: "は10桁または11桁の半角数字で登録してください" }
    validates :order_id
  end
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Address.create(post_code: post_code, prefecture_id: prefecture_id, municipalities: municipalities, block_number: block_number, building_name: building_name, phone_number: phone_number, order_id: order.id)
  end
end