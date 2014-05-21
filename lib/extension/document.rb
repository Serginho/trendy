#!/bin/env ruby
# encoding: utf-8

# Author::    Sergio Cancelo (mailto: yo@sergiocancelo.es)
# Copyright:: Copyright (c) 2014 Sergio Cancelo

require_relative "estring"

class Document
  attr_reader :category_id

  def initialize(t, cid = 0, down_case = true)
    @category_id = cid
    if down_case then t.downcase! end
    @content = t.without_punctuation.split(' ')
    @content.flatten!
    @times_appear_word = Hash.new(0)

    @content.each do |word|
      @times_appear_word[word] += 1
    end
  end

  #
  #Return number of times a word appears in a document
  #
  def tf(word)
    if @times_appear_word[word] == 0
      return 0
    else
      return (1 + Math.log(@times_appear_word[word]))
    end
  end

  #
  #Return an array of document without repeated words
  #
  def words_uniq
    @content.uniq
  end

end