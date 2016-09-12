class AddUserCourseToEvent < ActiveRecord::Migration
  def change
    add_reference :events, :user_course, index: true, foreign_key: true
  end
end
