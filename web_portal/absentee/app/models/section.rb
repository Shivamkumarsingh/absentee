class Section < ApplicationRecord
  belongs_to :klass
  has_many :attendances
  has_many :students
end
