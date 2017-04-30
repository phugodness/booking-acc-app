module RoomsHelper
  def display_line_through(arg)
    return 'underline;' if arg.nil?
    arg ?  ';' : 'line-through;'
  end
  def type_of_room_display type
    case type.id
    when 1
      'fa fa-home'
    when 2
      'fa fa-hotel'
    else
      'fa fa-info'
    end
  end
end
