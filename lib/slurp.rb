class Slurp
  class << self
    JMDICT_PATH = 'JMdict.txt.trunc' #ftp://ftp.monash.edu.au/pub/nihongo/JMdict.gz
    N5_PATH = 'vocabn5.htm' # http://www.jlptstudy.net/N5/N5_vocab-list.html

    def jmdict
      root = Nokogiri::XML(open(JMDICT_PATH))		

      root.xpath('//entry').each do |entry|
        kanji   = entry.xpath('k_ele/keb').first
        reading = entry.xpath('r_ele/reb').first
        writing = kanji.blank? ? reading : kanji
        meaning = entry.xpath('sense').first.xpath('gloss').first
        pos     = entry.xpath('sense').first.xpath('pos').first
        puts "#{writing.content} #{reading.content} (#{pos.children}) #{meaning.content}"
      end
    end

    def vocabn5
      root = Nokogiri::HTML(open(N5_PATH))

      root.css('tr td.kanji:nth-child(3)').each do |td|
        kanji = td.content
        print "#{kanji} " unless kanji.blank?
      end
    end
  end
end
