#!/bin/env ruby
# encoding: utf-8

class SharesController < ApplicationController

  def create
    if session[:user_id] then
      if params[:post_id] && params[:site] then
        p = Post.find params[:post_id]
        s = Site.find_by name: params[:site]
        sh = Share.create post_id: p.id, user_id: session[:user_id], site_id: s.id

        if sh.save then
          render json: {url: s.url, post_url: p.url}, status: 200
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