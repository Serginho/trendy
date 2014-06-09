#!/bin/env ruby
# encoding: utf-8

class CustomizesController < ApplicationController

  def edit
    @customizes = Customize.includes(:category).where(user_id: session[:user_id])
    @categories = Category.all
  end

  def create
    $state = true;
    c = Category.all
    Customize.transaction do
      c.each do |category|
        if params[category.id.to_s] then
          if Customize.where(category_id: category.id, user_id: session[:user_id]).exists? then
            c = Customize.where(category_id: category.id, user_id: session[:user_id]).first
            unless Customize.update(c.id, rank: params[category.id.to_s]) then
              $state = false
              redirect_to settings_edit_path, alert: 'Error al actualizar las opciones del usuario.'
              raise ActiveRecord::Rollback
            end
          else

            c = Customize.create category_id: category.id, user_id: session[:user_id], rank: params[category.id.to_s]
            unless c.save then
              $state = false
              redirect_to settings_edit_path, alert: 'Error al crear las opciones del usuario.'
              raise ActiveRecord::Rollback
            end
          end
        else
          $state = false
          redirect_to settings_edit_path, alert: 'Error de parámetros.'
          raise ActiveRecord::Rollback
        end
      end
    end
    redirect_to settings_edit_path, notice: 'Opciones actualizadas correctamente.' if $state
  end
end
