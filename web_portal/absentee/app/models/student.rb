class Student < ApplicationRecord
  belongs_to :klass
  belongs_to :section
  has_many :attendances
end
