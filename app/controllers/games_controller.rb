require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(9) { ('A'..'Z').to_a.sample }
  end

  def score
    attempt = params[:score]
    grid = params[:letters]
    @poppo = game(attempt, grid)
  end

  def game(attempt, grid)
    if included?(attempt.upcase, grid)
      if english_word?(attempt)
        "well done"
      else
        "not an english word"
      end
    else
      "not in the grid"
    end
  end
end

def included?(guess, grid)
  guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
end

def english_word?(word)
  response = open("https://wagon-dictionary.herokuapp.com/#{word}")
  json = JSON.parse(response.read)
  return json['found']
end
