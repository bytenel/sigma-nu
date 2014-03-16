class HomeController < ApplicationController
  def index
    @news_items = Article.all
  end

  def recruitment
  end

  def bios
  end

  def officers
  end

  def alumni
  end

  def about
  end 
end
