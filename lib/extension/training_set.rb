#!/bin/env ruby
# encoding: utf-8

# Author::    Sergio Cancelo (mailto: yo@sergiocancelo.es)
# Copyright:: Copyright (c) 2014 Sergio Cancelo

require_relative "document"

class TrainingSet

  attr_reader :documents, :diccionary

  def initialize
    @documents = []
    @doc_counter = Hash.new(0)
    @doc_sum = 0
    @diccionary = Hash.new(0)
    @dicc_counter = 0
    @word_documents_appear = Hash.new(0)
  end


  #
  # Custom marshaling save data. I don't need to save documents, only stats of those one
  #
  def marshal_dump
    [@doc_counter,@doc_sum,@diccionary,@dicc_counter,@word_documents_appear]
  end

  #
  # Custom marshaling load data
  #
  def marshal_load array
    @doc_counter,@doc_sum,@diccionary,@dicc_counter,@word_documents_appear = array
  end

  #
  # Add document into documents training set
  #
  def add_document(doc)
    @doc_counter[doc.category_id] += 1
    @doc_sum += 1
    doc.words_uniq.each do |word|
      unless @diccionary.has_key? word
      @diccionary[word] = @dicc_counter
      @dicc_counter += 1
      end
      @word_documents_appear[word] += 1
    end
    @documents << doc
  end

  #
  # Return the number of documents given a category id
  #
  def documents_by_category_id(id)
    @doc_counter[id]
  end

  #
  # Return sum of documents
  #
  def total_documents
    @doc_sum
  end

  #
  # Check if a word is into diccionary
  #
  def is_in_diccionary?(word)
    @diccionary.has_key? word
  end

  #
  # Return diccionary position
  #
  def get_diccionary_position(word)
    @diccionary[word]
  end
  #
  # Return the number of documents a word appears
  #
  def documents_word_appear(word)
    @word_documents_appear[word]
  end

  #
  # Calculate idf of a word
  #
  def idf(word)
    Math.log(total_documents.to_f / (1+ documents_word_appear(word)))
  end
end