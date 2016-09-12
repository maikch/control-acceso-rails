class CourseController < ApplicationController

  helper_method :course_url

  def list
    begin
      line = Cocaine::CommandLine.new("caverify")
      @user_rut = line.run.chomp
      @user = User.where(rut: @user_rut).first
      @user_id = @user.id
    rescue Cocaine::ExitStatusError => e
      redirect_to '/?status=error'
      return
    end
    @courses = Course.where(id: UserCourse.where(user_id: @user_id).where(['expiration > ?', DateTime.now]).map(&:course_id))
    @courses = @courses + Course.where(id: UserCourse.where(user_id: @user_id).where('expiration IS ?', nil).map(&:course_id))
    if @courses.count == 0
      redirect_to '/?status=error'
    end
    @nonce = generate_nonce
    if @courses.count == 1
      redirect_to course_url(@courses.first)
    end
  end

  def course_url(course)
    '/event/?user_id=' + @user_id.to_s + '&course_id=' + course.id.to_s + '&kind=login' + '&nonce=' + @nonce
  end

  def generate_nonce
    nonce = rand(36**32).to_s(36)
    Nonce.create!(value: nonce, active: true, user_id: @user_id)
    nonce
  end
end
