class Event < ActiveRecord::Base
  belongs_to :user_course
  validates :user_course, :kind, presence: true
end

# == Schema Information
#
# Table name: events
#
#  id             :integer          not null, primary key
#  kind           :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_course_id :integer
#
# Indexes
#
#  index_events_on_user_course_id  (user_course_id)
#
# Foreign Keys
#
#  fk_rails_5a2372c240  (user_course_id => user_courses.id)
#
