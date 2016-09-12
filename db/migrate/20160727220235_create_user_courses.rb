class CreateUserCourses < ActiveRecord::Migration
  def change
    create_table :user_courses do |t|
      t.date :expiration

      t.timestamps null: false
    end
  end
end
