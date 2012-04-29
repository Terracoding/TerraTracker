get_tasks = ->
  project_id = $("#timeslip_project_id").val()
  $.ajax
    type: "POST"
    url: "/timeslips/get_tasks"
    data: "project_id=" + project_id
    success: (tasks) ->
      $("#timeslip_task_id").empty()
      $.each tasks, (t) ->
        $("#timeslip_task_input").show()
        opt = $("<option />")
        opt.val tasks[t].id
        opt.text tasks[t].name
        $("#timeslip_task_id").append opt
get_users = ->
  project_id = $("#timeslip_project_id").val()
  $.ajax
    type: "POST"
    url: "/timeslips/get_users"
    data: "project_id=" + project_id
    success: (tasks) ->
      $("#timeslip_user_id").empty()
      $.each tasks, (t) ->
        $("#timeslip_user_input").show()
        opt = $("<option />")
        opt.val tasks[t].id
        opt.text tasks[t].firstname + " " + tasks[t].lastname
        $("#timeslip_user_id").append opt
$(document).ready ->
  if $("#timeslip_project_id").length > 0
    $(".inline-errors").ready ->
      get_tasks()
      $("#timeslip_project_id").change ->
        get_tasks()

      get_users()
      $("#timeslip_project_id").change ->
        get_users()

$(document).ajaxSend (event, request, settings) ->
  return  if typeof (AUTH_TOKEN) is "undefined"
  settings.data = settings.data or ""
  settings.data += (if settings.data then "&" else "") + "authenticity_token=" + encodeURIComponent(AUTH_TOKEN)