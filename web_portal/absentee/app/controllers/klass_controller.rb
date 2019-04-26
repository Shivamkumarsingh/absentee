class KlassController < ApplicationController
  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def index
    @class = Klass.joins(:sections).select('name, title, klasses.id as id')
    respond_to do |format|
      format.json { render json: @class }
      format.html
      format.js {}
    end
  end
end
