namespace :game do
  desc "Imports the JMdict dictionary"
  task :slurpdict => :environment do
    Slurp.jmdict
  end

  desc "Imports the JLPT level 5 words"
  task :slurpn5 => :environment do
    Slurp.vocabn5
  end
end
