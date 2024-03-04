class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_one :order

  with_options presence: true do
    validates :name
    validates :content
    validates :image
    validates :price,
              numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,
                              message: 'は300~9,999,999(半角数値)の範囲内で設定してください' }
  end

  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :category_id
    validates :prefecture_id
    validates :condition_id
    validates :ship_day_id
    validates :shipping_fee_id
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :prefecture
  belongs_to :condition
  belongs_to :ship_day
  belongs_to :shipping_fee
end
