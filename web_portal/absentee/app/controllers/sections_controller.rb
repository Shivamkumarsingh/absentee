class SectionsController < ApplicationController
  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def index
    @klass = Klass.joins(:sections).where(school_id: params[:school_id]).select('name, title, klasses.id as id')
    respond_to do |format|
      format.json { render json: @klass }
      format.html
      format.js {}
    end
  end
end
