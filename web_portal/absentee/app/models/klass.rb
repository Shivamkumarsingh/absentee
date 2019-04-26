class Klass < ApplicationRecord
  belongs_to :school
  has_many :sections
  has_many :attendances
end
