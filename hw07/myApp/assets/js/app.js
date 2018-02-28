// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"
import $ from "jquery";

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

function follow_click(ev) {
  let btn = $(ev.target);
  let work_id = btn.data('work_id');
  follow(work_id);

}

function update_click(ev) {
  let btn = $(ev.target);
  let duration_id = btn.data('duration_id');
  update(duration_id);
  

}

function delete_click(ev) {
  let btn = $(ev.target);
  let duration_id = btn.data('duration_id');
  delete_row(duration_id);
  

}

function start_click(ev) {
  let btn = $(ev.target);
  let duration_id = btn.data('duration_id');
  start_update(duration_id);
  
}

function start_update(duration_id) {
  let text = JSON.stringify({
    duration: {

        start_time: new Date()
      },
  });

  $.ajax(duration_path + "/"+duration_id, {
    method: "put",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => { console.log(resp); },
  });

  location.reload();
}

function delete_row(duration_id) {
  $.ajax(duration_path + "/"+duration_id, {
    method: "delete",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: "",
    success: (resp) => { console.log(resp); },
  });

  location.reload();
}


function update(duration_id) {
  let text = JSON.stringify({
    duration: {

        end_time: new Date()
      },
  });

  $.ajax(duration_path + "/"+duration_id, {
    method: "put",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => { console.log(resp); },
  });

  location.reload();

}


function follow(work_id) {
  let text = JSON.stringify({
    duration: {
        start_time: new Date(),
        end_time: new Date(),
        work_id: work_id
      },
  });

  $.ajax(duration_path, {
    method: "post",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => { console.log(resp); },
  });

  location.reload();
}


function init_follow() {
  if (!$('.follow-button')) {
    return;
  }

  $(".follow-button").click(follow_click);
  $(".updateEnd-button").click(update_click);
  $(".delete-button").click(delete_click);
  $(".updateStart-button").click(start_click);

}

$(init_follow);
