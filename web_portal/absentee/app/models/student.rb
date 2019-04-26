class Student < ApplicationRecord
  belongs_to :klass
  belongs_to :section
end
