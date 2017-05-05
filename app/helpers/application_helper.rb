module ApplicationHelper
  def notification
    flash.each do |message_type, message|
      content_tag(:div, class: "alert alert-#{message_type}") do
        concat(content_tag(:span, message))
      end
    end
  end

  def online_status(user)
    content_tag :span, user.name,
                class: "user-#{user.id} online_status #{'online' if user.online?}"
  end

  def icon_content(icon, content, value)
    content_tag :i, ' ' + content, class: icon, style: "font-size:20px; text-decoration:#{ value ? ';' : 'line-through;' }", :'aria-hidden' => 'true'
  end
end
