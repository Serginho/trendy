#!/bin/env ruby
# encoding: utf-8

class SessionsController < ApplicationController

  def create
    user = User.authenticate(params[:username], params[:password])

    if user
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Has iniciado sesión."
    else
      flash.now.alert = "Email o password inválidos."
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Hasta la próxima, te estaremos esperando."
  end
end