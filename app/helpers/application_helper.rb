module ApplicationHelper

  def alert_type(type)
    case type
      when :alert
        "alert-error"
      when :error
        "alert-error"
      when :notice
        "alert-success"
      when :success
        "alert-success"
      else
        type.to_s
    end
  end
end
