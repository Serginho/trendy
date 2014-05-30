class Share < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  belongs_to :site

  validates_presence_of :post_id, :user_id, :site_id, message: "Este campo es requerido."
  validates :post_id, :site_id, :user_id, numericality: true, allow_nil: false
  validates_uniqueness_of :post_id, scope: [:user_id, :site_id]
end
