class Widget < ActiveRecord::Base
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
end
