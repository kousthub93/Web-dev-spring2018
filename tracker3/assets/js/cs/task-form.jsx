
import React from 'react';
import { connect } from 'react-redux';
import { Button, FormGroup, Label, Input } from 'reactstrap';
import api from '../api';


function TaskForm(props) {
  
  function update(ev) {
    let tgt = $(ev.target);

    let data = {};
    data[tgt.attr('name')] = tgt.val();
    if(tgt.attr('name') == "done"){
      data["done"] = $(tgt).is(':checked') ? 'true' : 'false'; 
    }
    else{

      data[tgt.attr('name')] = tgt.val();
    }
    let action = {
      type: 'UPDATE_FORM',
      data: data,
    };
    props.dispatch(action);
  }

  function submit(ev) {

    if(props.form.time_spent == "" || props.form.time_spent%15 != 0){
      alert("enter time taken is incorrect ");
    }
    else if(props.form.title == "" || props.form.title== undefined){
      alert("task title is blank");
    }
    else if(props.form.body == "" || props.form.body == undefined ){
      alert("task body is blank");
    }
    else if(props.form.assigned_to == "select"){
      alert("select user to be assigned");
    }
    else{
    api.submit_task(props.form);
    }
  }

  function clear(ev) {
    props.dispatch({
      type: 'CLEAR_FORM',
    });
  }

  let users = _.map(props.users, (uu) => <option key={uu.id} value={uu.name}>{uu.name}</option>);
  return <div style={{padding: "4ex"}}>
    <h2>New Post</h2>

    <FormGroup>
      <Label for="user_id">Assigned By</Label>
      <Input type="text" name="user_id" value={props.form.user_id} onChange={update} readOnly />
    </FormGroup>

    <FormGroup>
      <Label for="assigned_to">Assign To</Label>
      <Input type="select" name="assigned_to" value={props.form.assigned_to} onChange={update}>
        <option>select</option>
        { users }
      </Input>
    </FormGroup>
    
    <FormGroup>
      <Label for="title">Task Title</Label>
      <Input type="text" name="title" value={props.form.title} onChange={update}>
      </Input>
    </FormGroup>
    <FormGroup>
      <Label for="body">Body</Label>
      <Input type="textarea" name="body" value={props.form.body} onChange={update}/>
    </FormGroup>

    <FormGroup>
      <Label for="done">Completed? </Label>
      <Input type="checkbox" name="done" className="check" value={props.form.done} onChange={update}/>
    </FormGroup>

    <FormGroup>
      <Label for="time_spent">Time Spent</Label>
      <Input type="number" name="time_spent" min="0" step="15" value={props.form.time_spent} onChange={update} />
    </FormGroup>
    <Button onClick={submit} color="primary">New Task</Button> &nbsp;
    <Button onClick={clear}>Clear</Button>
  </div>;
}

function state2props(state) {
  return {
    form: state.form,
    users: state.users,
  };
}

export default connect(state2props)(TaskForm);