class HomeController < ApplicationController

  def index

  end

  def results
    @postulants = Postulant.all.limit(5)
    @positions = ['Designer', 'Backend-Dev', 'Frontend-Dev', 'QA', 'Proyect Manager']
    @personality = ['Innovative', 'Adventurous', 'Logic Analyst', 'Innovative', 'Adventurous']

    render 'results'
  end

end
