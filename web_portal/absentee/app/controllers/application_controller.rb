class ApplicationController < ActionController::Base
	before_action :authenticate_user!, unless: -> { params[:controller].eql?("sessions") || params[:action].eql?('forgot_password') }
	protect_from_forgery with: :null_session

	def load_school_sections
		school = School.last
		@sections = Section.joins(:klass).where("klasses.school_id": school.id).select('sections.name, title, klasses.id as klass_id, sections.id as id')
	end
end
