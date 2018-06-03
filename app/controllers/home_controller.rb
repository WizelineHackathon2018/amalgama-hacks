class HomeController < ApplicationController

  def index

  end

  def results
    @postulants = Postulant.all.limit(5)

    render 'results'
  end

end
