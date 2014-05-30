# -*- encoding : utf-8 -*-
class Site < ActiveRecord::Base
  has_many :shares

  validates_presence_of :name, :url, message: "Este campo es requerido"
  validates_length_of :name, minimum: 3, message: "Longitud mínima 3 caracteres"
  validates_format_of :url, :with => URI.regexp(['http']), message: 'Url inválida'
end
