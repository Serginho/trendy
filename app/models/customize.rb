class Customize < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  validates_presence_of :category_id, :user_id, :rank, message: "Este campo es requerido."
  validates :category_id, :user_id, :rank, numericality: true, allow_nil: false
  validates_uniqueness_of :category_id, scope: :user_id
end
