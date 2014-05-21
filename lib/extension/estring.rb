#!/bin/env ruby
# encoding: utf-8

# Author::    Sergio Cancelo (mailto: yo@sergiocancelo.es)
# Copyright:: Copyright (c) 2014 Sergio Cancelo

class String

  #
  # Clean string symbols
  #
  def without_punctuation
    tr( ',¿?.¡!;:"@#$%^&*()_=+[]{}\|<>/`~', " " ) .tr( "'\-", "")
  end

end