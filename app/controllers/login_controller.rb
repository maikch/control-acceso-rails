class LoginController < ApplicationController
  def show
    @status = params[:status]
    @course = Course.find_by(id: params[:course_id])
    @type = params[:type]
  end

  def logout

    begin
      line = Cocaine::CommandLine.new("caverify")
      @user_rut = line.run.chomp
      @user = User.where(rut: @user_rut).first
    if @user
      @user_id = @user.id
    else
      redirect_to '/?status=error'
      return
    end
    rescue Cocaine::ExitStatusError => e
      redirect_to '/?status=error'
      return
    end
    @last_login_event = last_login_event
    if (@last_login_event)
      create_event(@user_id, @last_login_event.user_course.course, 'logout')
      redirect_to '/?type=logout&status=ok&course_id=' + @last_login_event.user_course.course.id.to_s
    else
      redirect_to '/?status=error'
    end
  end

  def last_login_event
    event = Event.where(user_course_id: UserCourse.where(user_id: @user_id).map(&:id))
              .order("created_at")
              .last
    event && event.kind == 'login' ? event : nil
  end

  def create_event(user_id, course_id, event_kind)
    user_course = UserCourse.where(user_id: user_id).where(course_id: course_id).first!
    event = Event.new(kind: event_kind)
    event.user_course = user_course
    event.save!
  end

  def login_params
    params.permit(:status, :course_id)
  end

end
