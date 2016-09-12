class Course < ActiveRecord::Base
  validates :name, presence: true

  has_many :user_courses, :dependent => :delete_all
end

# == Schema Information
#
# Table name: courses
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
