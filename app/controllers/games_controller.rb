class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def new
  end
end