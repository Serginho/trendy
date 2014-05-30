# -*- encoding : utf-8 -*-
class Post < ActiveRecord::Base
  belongs_to :category
  belongs_to :source
  has_many :shares

  validates_presence_of :title, :content, :url, :category_id, :source_id , message: 'Este campo es requerido.'
  validates :category_id, numericality: true, allow_nil: false
  validates :source_id, numericality:true,  allow_nil: false
  validates_length_of :content, minimum: 20, message: 'Debe ser mayor de 20 caracteres'
  validates_uniqueness_of :title, message: 'Este post ya existe.'
  validates_format_of :url, :with => URI.regexp(['http']), message: 'Url inválida'
  validates_format_of :image, :with => URI.regexp(['http']), allow_blank: true
end
