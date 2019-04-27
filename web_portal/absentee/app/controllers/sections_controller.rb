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
    if request.headers['Authorization'] and !User.where(auth_token: request.headers['Authorization']).exists?
      respond_to do |format|
        format.json { render json: {message: 'Not Authorized'}, status: 401 }
      end
      return
    end

    @sections = Section.joins(:klass).where("klasses.school_id": params[:school_id]).select('sections.name, title, klasses.id as klass_id, sections.id as id')

    respond_to do |format|
      format.json { render json: @sections }
      format.html { }
      format.js {}
    end
  end
end
