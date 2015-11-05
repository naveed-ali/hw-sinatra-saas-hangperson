class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  def guess(letter)
    raise ArgumentError if letter.nil? or letter.empty? or letter =~ /[^a-z]/i
    
    if @word =~ /#{letter}/i
      if @guesses =~ /#{letter}/i
        false
      else
        @guesses << letter
        true
      end
    else
      if @wrong_guesses =~ /#{letter}/i
        false
      else
        @wrong_guesses << letter
        true
      end
    end
  end

  def word_with_guesses
    unless guesses.empty?
      @word.gsub(/[^#{guesses}]/i, '-')
    else
      @word.gsub(/[^.]/i, '-')
    end
  end
  
  def check_win_or_lose
    if word_with_guesses == @word
      :win
    elsif @wrong_guesses.length == 7
      :lose
    else
      :play
    end
  end
end
