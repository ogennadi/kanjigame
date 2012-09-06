class GameController < ApplicationController
  def index
    wl, cl = Game.generate(16)
    @word_list = wl.to_json
    @character_list = cl.to_json
  end
end
