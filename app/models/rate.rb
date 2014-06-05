class Rate < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  validates_presence_of :post_id, :user_id, :score, message: "Este campo es requerido."
  validates :post_id, :user_id, :score, numericality: true, allow_nil: false
  validates_uniqueness_of :post_id, scope: :user_id
end
