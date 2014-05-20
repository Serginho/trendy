class Post < ActiveRecord::Base
  belongs_to :category

  validates_presence_of :title, :content, :url, :category_id , message: 'Este campo es requerido.'
  validates_length_of :content, minimum: 20, message: 'Debe ser mayor de 20 caracteres'
  validates_uniqueness_of :title, message: 'Este post ya existe.'
  validates_format_of :url, :with => URI.regexp(['http'])
  validates_format_of :image, :with => URI.regexp(['http']), allow_blank: true
end
