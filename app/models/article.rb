class Article < ActiveRecord::Base
  belongs_to :member
  has_many :comments
  has_many :members, through: :comments
end
