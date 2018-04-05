import React from 'react';
import { connect } from 'react-redux';
import { Button, FormGroup, Label, Input } from 'reactstrap';
import api from '../api';
import { BrowserRouter as Router, Route } from 'react-router-dom';

function RegisterForm(props){


	return( <div style={{padding: "4ex"}}>
		
		<h2>New User</h2>

    	<FormGroup>
      	<Label for="email">Email:</Label>
      	<Input type="text" name="email" value={props.form.email} onChange={update}>
      	</Input>
    	</FormGroup>

    	
		<FormGroup>
      	<Label for="userName">Name:</Label>
      	<Input type="text" name="userName" value={props.form.userName} onChange={update}>
      	</Input>
    	</FormGroup>

    	<FormGroup>
      	<Label for="password">Password:</Label>
      	<Input type="text" name="password" value={props.form.password} onChange={update}>
      	</Input>
    	</FormGroup>

    	<Button onClick={submit} color="primary">Add New User</Button>

	
	</div>);


	function update(ev) {
    	let tgt = $(ev.target);

    	let data = {};
    	data[tgt.attr('name')] = tgt.val();
    	let action = {
      	type: 'UPDATE_FORM',
      	data: data,
    	};
    	props.dispatch(action);
  }

  function submit(ev) {

  	if(props.form.email == "" || props.form.email == undefined){

  		alert("email is blank");
  	}
  	else if(props.form.userName=="" || props.form.userName==undefined){

  		alert("user name is blank");
  	}
  	else if(props.form.password=="" || props.form.password==undefined ){

  		alert("password is blank");
  	}
  	else{

  		api.submit_newUser(props.form);
    	alert("created successfully");
    	window.location.href= "https://tasks3.kousthubh.com";
  	}
    
  }

}


function state2props(state) {
  return {
    form: state.form,
    users: state.users,
  };
}

export default connect(state2props)(RegisterForm);