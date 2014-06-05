#!/bin/env ruby
# encoding: utf-8

class RatesController < ApplicationController

  def create
    if session[:user_id] then
      if params[:post_id] && params[:score] then
        p = Post.find params[:post_id]

        rt = Rate.create post_id: p.id, user_id: session[:user_id], score: params[:score]

        if rt.save then
          render nothing: true, status: 200
        else
          render nothing: true, status: 409 #Conflict
        end
      else
        render nothing: true, status: 400
      end
    else
      render nothing: true, status: 401
    end
  end
end