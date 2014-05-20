class Category < ActiveRecord::Base
  has_many :posts

  validates_presence_of :name, message: 'Este campo es requerido.'
  validates_format_of :name, with: /\A[a-zA-Z]+\z/, message: 'Solo se permiten letras.', on: :create

  validates_length_of :description, minimum: 10, message: 'Debe ser mayor de 10 caracteres.'
end
