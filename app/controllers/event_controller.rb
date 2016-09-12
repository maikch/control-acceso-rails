class EventController < ApplicationController
  def new
    nonce = fetch_nonce(params[:nonce], params[:user_id])
    if(nonce)
      create_event(params[:user_id], params[:course_id], params[:kind], nonce)
      redirect_to '/?type=login&status=ok&course_id=' + params[:course_id].to_s
    else
      redirect_to '/?status=error'
    end
  end

  def fetch_nonce(nonce_value, user_id)
    Nonce
      .where("created_at >= ?",  DateTime.now - 5.minutes)
      .where(value: nonce_value, user_id: user_id, active: true)
      .order("created_at")
      .last
  end

  def create_event(user_id, course_id, event_kind, nonce)
    user_course = UserCourse.where(user_id: user_id).where(course_id: course_id).first!
    event = Event.new(kind: event_kind)
    event.user_course = user_course
    nonce.update(active: false)
    event.save!
  end

  def event_params
    params.permit(:course_id, :user_id, :kind, :nonce)
  end
end
