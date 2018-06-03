class HomeController < ApplicationController

  def index

  end

  def results
    @postulants = Postulant.order(name: :asc).limit(5)
    @positions = ['Designer', 'Backend-Dev', 'Frontend-Dev', 'QA', 'Proyect Manager']

    render 'results'
  end

end
