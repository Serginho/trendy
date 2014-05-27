#!/bin/env ruby
# encoding: utf-8

class User < ActiveRecord::Base

  attr_accessor :password
  before_save :encrypt_password

  validates_confirmation_of :password, message: 'Las contraseñas no coinciden.'
  validates_presence_of :password, :on => :create, message: 'Inserte una contraseña.'
  validates_presence_of :username, message: 'Inserte un usuario.'
  validates_uniqueness_of :username, message: 'El usuario ya existe.'

  def self.authenticate(username, password)
    user = find_by username: username

    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end
