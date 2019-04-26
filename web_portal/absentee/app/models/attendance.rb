class Attendance < ApplicationRecord
  belongs_to :klass
  belongs_to :student
  belongs_to :section
end
