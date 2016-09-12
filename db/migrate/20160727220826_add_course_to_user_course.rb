class AddCourseToUserCourse < ActiveRecord::Migration
  def change
    add_reference :user_courses, :course, index: true, foreign_key: true
  end
end
