require 'csv'

class Slurp
  class << self
    JMDICT_PATH = 'JMdict' # ftp://ftp.monash.edu.au/pub/nihongo/JMdict.gz
    N5CSV       = 'vocabn5.csv' # based on http://www.jlptstudy.net/N5/N5_vocab-list.html

    # Imports the Japanese dictionary
    def jmdict
      root = Nokogiri::XML(open(JMDICT_PATH))		

      root.xpath('//entry').each do |entry|
        kanjis  = entry.xpath('k_ele/keb').map(&:content)
        reading = entry.xpath('r_ele/reb').first.content
        meaning = entry.xpath('sense').first.xpath('gloss').first.content
        pos     = entry.xpath('sense').first.xpath('pos').first.children

        kanjis.each do |kanji|
          word = Word.find_or_initialize_by_kanji(:kanji => kanji,
                                              :reading => reading,
                                              :pos => pos.to_s,
                                              :meaning => meaning)

          characters = word.kanji.split('').map do |char|
            Character.find_or_create_by_glyph(char)
          end
          
          word.characters = characters
          word.save!

          puts "#{kanji} #{reading} (#{pos}) #{meaning}"
        end
      end
    end

    # Tags all level 5 words as such
    def vocabn5
      CSV.foreach(N5CSV) do |row|
        kanji     = row[0]
        new_word  = init_word(kanji, :level => 5)
        new_word.save!
        print "#{new_word.kanji} "
      end
    end

    # returns a possibly unsaved word based on KANJI
    def init_word(kanji, options={})
      word = Word.find_by_kanji(kanji)
      word.update_attributes!(options)
      word
    end
  end
end
