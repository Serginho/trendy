class Source < ActiveRecord::Base
  has_many :posts

  validates_presence_of :name, :url, message: 'Este campo es requerido.'
  validates_format_of :url, :with => URI.regexp(['http'])
end
