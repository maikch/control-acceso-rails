class AddUserToUserCourse < ActiveRecord::Migration
  def change
    add_reference :user_courses, :user, index: true, foreign_key: true
  end
end
