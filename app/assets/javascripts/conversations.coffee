# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery(document).on 'turbolinks:load', ->
  messages = $('#conversation-body')
  if messages.length > 0
    messages_to_bottom = -> messages.scrollTop(messages.prop("scrollHeight"))

    messages_to_bottom()
