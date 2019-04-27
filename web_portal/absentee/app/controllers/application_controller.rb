class ApplicationController < ActionController::Base
	before_action :authenticate_user!, unless: -> { params[:controller].eql?("home") || params[:action].eql?('forgot_password') }

	def load_school_sections
		school = School.last
		@sections = Section.joins(:klass).where("klasses.school_id": school.id).select('sections.name, title, klasses.id as klass_id, sections.id as id')
	end
end
