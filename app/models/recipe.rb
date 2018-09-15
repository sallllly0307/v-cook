class Recipe < ApplicationRecord
  validates :title, {presence: true}
  validates :user_id, {presence: true}

  def user
    return User.find_by(id: self.user_id)
  end

  def self.titleSearch(search)
      where("title LIKE ?", "%#{search}%")
  end


end
