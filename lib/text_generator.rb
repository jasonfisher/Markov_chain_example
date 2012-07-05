require File.dirname(__FILE__) + '/markov_chain'

class TextGenerator
  attr_reader :markov_chain
  
  RANDOM_DELIMITER = "__foo__" 
  
  def initialize
    @markov_chain = MarkovChain.new
  end
  
  def seed(text)
    sentences = sentences(text)
    sentences.each do |sentence|
      words = sentence.split
      (0..words.size-2).each { |i|
         @markov_chain.increment_probability(words[i], words[i+1])        
       }
    end
  end
  
  def sentences(text)
    splits = text.gsub(/([.!?])\s*/, '\1' + RANDOM_DELIMITER)
    splits.split(RANDOM_DELIMITER)
  end
  
  def generate(start)
    @markov_chain.random_walk(start).join(" ")
  end
  
end