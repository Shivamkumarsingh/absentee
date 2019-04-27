class Section < ApplicationRecord
  belongs_to :klass
  has_many :attendances
  has_many :students

  def divison
    "#{self.klass.title}-#{self.name}"
  end
end
