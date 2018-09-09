class Like < ApplicationRecord
  validates :user_id, {presence: true}
  validates :recipe_id, {presence: true}
end
