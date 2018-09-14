class Ingredient < ApplicationRecord
  #validates :name, {presence: true}
  #validates :quantity, {presence: true}

  def self.nameSearch(search)
    where("name LIKE ?", "%#{search}%")
  end

end
