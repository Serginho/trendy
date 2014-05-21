class TrainingPost < ActiveRecord::Base
  belongs_to :category

  validates_presence_of :title, :content, :category_id, message: 'Este campo es requerido.'
  validates :category_id, numericality: true, allow_nil: false
  validates_length_of :content, minimum: 20, message: 'Debe ser mayor de 20 caracteres'
  validates_uniqueness_of :title, message: 'Este post ya existe.'

end
