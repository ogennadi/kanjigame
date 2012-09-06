class Slurp
  class << self
    JMDICT_PATH = 'JMdict.txt' #ftp://ftp.monash.edu.au/pub/nihongo/JMdict.gz
    N5_PATH = 'vocabn5.htm' # http://www.jlptstudy.net/N5/N5_vocab-list.html

    def jmdict
      root = Nokogiri::XML(open(JMDICT_PATH))		

      root.xpath('//entry').each do |entry|
        kanjis   = entry.xpath('k_ele/keb').map(&:content)
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
  end
end
