class UserCourse < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  has_many :events, :dependent => :destroy

  validates :user, :course, presence: true
end

# == Schema Information
#
# Table name: user_courses
#
#  id         :integer          not null, primary key
#  expiration :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  course_id  :integer
#
# Indexes
#
#  index_user_courses_on_course_id  (course_id)
#  index_user_courses_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_4a55f742c8  (user_id => users.id)
#  fk_rails_63b9b1bfc2  (course_id => courses.id)
#
