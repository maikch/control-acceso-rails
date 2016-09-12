ActiveAdmin.register Event do

  filter :kind
  filter :user_course_user_name_cont, as: :string, label: "Nombre"
  filter :user_course_course_name_cont, as: :string, label: "Curso"
  filter :created_at

  index do
    column "Fecha", :created_at
    column "Tipo", :kind
    column "Nombre" do |event|
      event.user_course.user.name
    end
    column "Curso" do |event|
      event.user_course.course.name
    end
  end


end
