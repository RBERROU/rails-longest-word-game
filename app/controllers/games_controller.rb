require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(9) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters].split('')

    # Record the start time before processing (for demonstration purposes)
    @start_time = Time.now

    # Process word validation and scoring
    if valid_word?(@word, @letters)
      if english_word?(@word)
        @message = "Well Done! Your word is valid and an English word!"
        @end_time = Time.now
        @time_taken = @end_time - @start_time
        @score = compute_score(@word)
      else
        @message = "Sorry, but #{@word} does not seem to be a valid English word."
        @score = 0
        @time_taken = 0 # Ensuring @time_taken has a value
      end
    else
      @message = "Sorry, but #{@word} can't be built out of #{@letters.join(', ')}."
      @score = 0
      @time_taken = 0 # Ensuring @time_taken has a value
    end
  end

  private

  def valid_word?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    url = "https://dictionary.lewagon.com/#{word}"
    response = URI.open(url).read
    json = JSON.parse(response)
    json['found'] || false
  end

  def compute_score(word)
    word.length * 10 - (@time_taken * 10).to_i
  end
end
