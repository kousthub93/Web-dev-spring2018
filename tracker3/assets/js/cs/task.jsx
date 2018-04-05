import React from 'react';
import { Card, CardBody, Button } from 'reactstrap';
import api from '../api';
import store from '../store';


export default function Task(props) {
  let task = props.task;
  return (<Card>
    <CardBody>
      <div>
        <p>Posted by <b>{ task.user.name }</b></p>
        <p>Task Title <b>{ task.title}</b></p>
        <p>Task Body <b>{ task.body }</b></p>
        <p>Assigned To <b>{ task.assigned_to}</b></p>
        <p>Completed? <b>{ task.done ? "Yes" : "No"}</b></p>
        <p>Time Taken <b>{ task.time_spent}</b></p>
        <p className="text-right">
          <Button onClick={editForm} color="primary">Edit</Button> &nbsp;
          <Button onClick={deleteForm} color="primary">Delete</Button> &nbsp;
        </p>

      </div>
    </CardBody>
  </Card>);


  function editForm(){

    api.deleteForm(props.task)
    let data = {
      user_id: props.loginUser.user_id,
      title: props.task.title,
      body: props.task.body,
      assigned_to: props.task.assigned_to,
      time_spent: props.task.time_spent,
      done: props.task.done,
    }

    let action = {

      type: 'UPDATE_FORM',
      data: data,
    };

    store.dispatch(action);
  }

  function deleteForm(){

    api.deleteForm(props.task)
  }
}

