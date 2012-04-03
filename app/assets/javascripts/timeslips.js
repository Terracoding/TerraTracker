$(document).ready(function()
{
  $('.inline-errors').ready(function()
  { 
    get_tasks();
    $('#timeslip_project_id').change(function() { get_tasks(); });
		get_users();
		$('#timeslip_project_id').change(function() { get_users(); });
  });
});

function get_tasks()
{
  var project_id = $('#timeslip_project_id').val();

  $.ajax(
  { 
    type: "POST",
    url: "get_tasks",
    data: "project_id="+project_id,
    success: function(tasks)
    {
      $('#timeslip_task_id').empty();
      $.each(tasks,function(t)
      {
        $('#timeslip_task_input').show();
        var opt = $('<option />');
        opt.val(tasks[t].id);
        opt.text(tasks[t].name);
        $('#timeslip_task_id').append(opt);
      });
    }
  });
}

function get_users()
{
  var project_id = $('#timeslip_project_id').val();

  $.ajax(
  { 
    type: "POST",
    url: "get_users",
    data: "project_id="+project_id,
    success: function(tasks)
    {
      $('#timeslip_user').empty();
      $.each(tasks,function(t)
      {
        $('#timeslip_user_input').show();
        var opt = $('<option />');
        opt.val(tasks[t].id);
        opt.text(tasks[t].firstname + " " + tasks[t].lastname);
        $('#timeslip_user').append(opt);
      });
    }
  });
}

$(document).ajaxSend(function(event, request, settings)
{
	if (typeof(AUTH_TOKEN) == "undefined") return;
	settings.data = settings.data || "";
	settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(AUTH_TOKEN);
});
