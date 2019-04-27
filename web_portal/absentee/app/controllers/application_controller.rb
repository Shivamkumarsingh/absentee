class ApplicationController < ActionController::Base
	def load_school_sections
		school = School.last
		@sections = Section.joins(:klass).where("klasses.school_id": school.id).select('sections.name, title, klasses.id as klass_id, sections.id as id')
	end
end
