// tracker.jsx

import React from 'react';
import ReactDOM from 'react-dom';
import { BrowserRouter as Router, Route } from 'react-router-dom';
import { Button, FormGroup, Label, Input } from 'reactstrap';

import Nav from './nav';
import Feed from './feed';
import Users from './users';
import TaskForm from './task-form';

import { Provider, connect } from 'react-redux';
import RegisterForm from './register-form';

export default function tracker_init(store) {
  ReactDOM.render(
    <Provider store={store}>
      <Tracker state={store.getState()}/>
    </Provider>,
    document.getElementById('root'),
  );
}

let Tracker = connect((state) => state)((props) => {

  function logOut(){

    console.log("in log out");
    window.location.reload();
  }



  if(props.token==null){

    return(
     <Router>
      <div>
        <Nav />
          <Route path="/registerForm" exact={true} render={() => 
            <RegisterForm state={props} />
          } /> 

        </div> 
    </Router>

    );
  }


  else{

  return (
    <Router>
      <div>
        <Nav />
          <div>
            <Button onClick={logOut}>Log Out!</Button>
          </div>
          <Route path="/" exact={true} render={() => 
            <div>
              <TaskForm />
              <Feed tasks={props.tasks} user={props.token} />
            </div>
          } />
          <Route path="/users" exact={true} render={() =>
            <Users users={props.users} />
          } />
          <Route path="/users/:user_id" render={({match}) =>
            <Feed tasks={_.filter(props.tasks, (pp) =>
              match.params.user_id == pp.user.id )
            } />
          } /> 
        </div> 
    </Router>
  );}

});






