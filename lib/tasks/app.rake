#!/bin/env ruby
# encoding: utf-8

namespace :app do
  desc "Initialize app"
  task init: :environment do
    c = Category.create id: 24, name: 'Deportes', description: 'Esto es una descripción para deportes'
    c.save
    c = Category.create id: 25, name: 'Economia', description:'Esto es una descripción para economía'
    c.save
    c = Category.create id: 26, name: 'Ciencia y tecnologia', description: 'Esto es una descripción para ciencia y tecnología'
    c.save
    c = Category.create id: 28, name: 'Sociedad', description: 'Esto es una descripción para sociedad'
    c.save
    c = Category.create id: 29, name: 'Politica', description: 'Esto es una descripción para política'
    c.save
    c = Category.create id: 30, name: 'Cultura', description: 'Esto es una descripción para cultura'
    c.save
    c = Category.create id: 31, name: 'Ocio', description: 'Esto es una descripción para ocio'
    c.save
  end
end
