class AttendancesController < ApplicationController
  skip_forgery_protection only: %i[create]
  def new
  end

  def create
    section_id = params[:section_id]
    klass_id = Section.find(section_id).klass_id
    absent_array = params[:attendance]
    absent_array.each do |roll|
      student_id = Student.where(roll_number: roll).where(section_id: section_id).first.id
      @attendance = Attendance.find_or_create_by(student_id: student_id, present: false,
       section_id: section_id, klass_id: klass_id, date: Date.today)
    end
    respond_to do |format|
      format.json { render json: { message: "Attendance Created Successfully",
                        status: 200 } }
      format.html
      format.js {}
    end
  end

  def edit
  end

  def update
  end

  def bulk_attendance
    invalid = []	  
    attendance_hash = params[:attendance].reject {|key, value| value == "" }
    attendance_hash.each do |attendance|
      section = Section.find(attendance.first)
      klass = section.klass
      klass_id = klass.id
      roll_ids = attendance.second.split(',').map(&:strip).reject(&:blank?)
      
      valid_roll_numbers = Student.where(section_id: section.id, roll_number: roll_ids).pluck(:roll_number)
      invalid_roll_numbers = roll_ids - valid_roll_numbers
      invalid << "Class #{klass.title} - #{section.name} : #{invalid_roll_numbers.join(',')}"  if invalid_roll_numbers.present?
      roll_ids.each do |id|
        student = Student.where(roll_number: id, section_id: attendance.first)
        if student.exists?
          Attendance.find_or_create_by!(section_id: attendance.first, student_id: student.first.id, date: Date.today,
          present: false, klass_id: klass_id)
	  flash[:success] = "Updated Successfully!"
        else
		flash[:alert] = "Few roll numbers are invalid! Here is list #{invalid.join(' | ')}. Attendance for valid roll numbers is marked successfully!"
          p '--------------------Invalid Roll Number ---------------'
        end
      end
    end
    redirect_to root_path
  end

  def todays_attendance
    section_id = params[:section_id].to_i
    @attendance = Student.joins("LEFT JOIN attendances ON attendances.student_id = students.id AND attendances.date::Date = '#{Date.today}'").
                          where(students: {section_id: params[:section_id]}).
                          select('attendances.present as present, name, students.roll_number, students.id')
    respond_to do |format|
      format.json { render json: @attendance }
      format.html
      format.js {}
    end
  end
end
