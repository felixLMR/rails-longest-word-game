
require 'open-uri'
require 'JSON'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { [*'A'..'Z'].sample }
    # 10.times do
    #   @letters << ('A'..'Z').to_a.sample
    # end
  end

  def score
    word = params[:word_input]
    array = params[:letter_array].split
    url = 'https://wagon-dictionary.herokuapp.com/'
    word_url = "#{url}#{word}"
    answer_url = open(word_url).read
    json_answer = JSON.parse(answer_url)
    word1 = word.upcase.split('').map { |letter| array.include?(letter) ? array.delete_at(array.index(letter)) : 'false' }
    if word1.include?('false')
      return @response = "Sorry but #{word} is not in the grid!"
    elsif json_answer['found'] == false
      return @response = "Sorry but #{word} is not an english word!"
    else
      return @response = "Congratulations! #{word} is an English word !"
    end
  end
end
