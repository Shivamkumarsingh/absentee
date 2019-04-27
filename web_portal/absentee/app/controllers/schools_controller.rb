class SchoolsController < ApplicationController
  def dashboard
    load_school_sections
    render :dashboard
  end
end
