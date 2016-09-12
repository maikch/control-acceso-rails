ActiveAdmin.register UserCourse do

  permit_params :user_id, :course_id, :expiration, :user_course

  index do
    column :user
    column :course
    column :expiration
    actions
  end

   form do |f|
    f.inputs "User Details" do
      f.input :user
      f.input :course
      f.input :expiration, as: :string, input_html: {type: "date"}
    end
    f.actions
  end


 controller do
    def create
      user_course = UserCourse.new(user_id: params[:user_course][:user_id], course_id: params[:user_course][:course_id])
      user_course.user = User.find(user_course.user_id)
      user_course.course = Course.find(user_course.course_id)
      if !params[:user_course][:expiration].blank?
        user_course.expiration = Date.parse(params[:user_course][:expiration])
      end
      user_course.save!
      redirect_to admin_user_courses_path
    end
 end


end
