class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  

  
=begin
функци видимо должна принимать букву - проверки
проверить есть ли она в слове
и не было ли попытки её уже отгадать
=end
  def guess letter
      
    if letter.nil? or letter.length == 0 or not letter=~/[a-z]/i
      raise ArgumentError
    end
    result = false
    letter.downcase!
    isLetterAlreadyGuessed = false;
    isWrongGuessedAlready  = false;



    
    if @guesses.include? letter #буква уже была отгадана
      isLetterAlreadyGuessed = true
    end
    if @wrong_guesses.include? letter#была неудачная  попытка угадать эту букву
      isWrongGuessedAlready = true;
    end
    if !isWrongGuessedAlready && !isLetterAlreadyGuessed
     # puts "word:"
     # puts @word
     # puts "letter"
     # puts letter
      if @word.include? letter #если слово содержит букву
    #  puts "yea"
        @guesses+=letter
        result = true
      else
        result = true
        @wrong_guesses+=letter
      end
    else
      result = false
    end


    
    
    return result
  end
 

def word_with_guesses
  guessed_word = ""
  @word.each_char do |letter|
    if @guesses.include? letter
      guessed_word << letter
    else
      guessed_word << '-'
    end
  end

  return guessed_word
end

def check_win_or_lose
  return :lose if @wrong_guesses.size>6
  if word_with_guesses == @word
    return :win
  else
    return :play
  end
end


#
  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
