module RoomsHelper
  def display_line_through(arg)
    return 'underline;' if arg.nil?
    arg ?  ';' : 'line-through;'
  end
end
