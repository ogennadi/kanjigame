class Game
  class << self
    # Returns [a, b] where a =  list of Words made up of n characters in total,
    # and b = the n characters
    def words_with_n_chars(n)
      words      = Set.new
      characters = Set.new

      while characters.length < n
        rw = Word.where(:level => 5).sample
        next if rw.kanji.length > (n - characters.length)
        words << rw
        rw.kanji.each_char {|c| characters << c}
      end

      return words.map(&:kanji), characters.to_a
    end

    # chars : [ruby_char]
    # returns all Words formable from chars
    def words_from(chars)
      Word.where("kanji SIMILAR TO ?", '[' + chars.join('|') +']+' )
    end

    def generate(n)
      words, characters = words_with_n_chars(n)
      expanded_words = words_from(characters)
      return expanded_words.sort_by{|x| x.kanji.length}, characters
    end
  end
end
