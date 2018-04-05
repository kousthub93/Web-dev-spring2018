import { createStore, combineReducers } from 'redux';
import deepFreeze from 'deep-freeze';

/*
 *  state layout:
 *  {
 *   tasks: [... Tasks ...],
 *   users: [... Users ...],
 *   form: {
 *     user_id: null,
 *     body: "",
 *   }
 * } 
 *
 * */

 function login(state = empty_login, action) {
  switch (action.type) {
    case 'UPDATE_LOGIN_FORM':
      return Object.assign({}, state, action.data);
    default:
      return state;
  }
}

 function token(state = null, action) {
  switch (action.type) {
    case 'SET_TOKEN':
      return action.token;
    default:
      return state;
  }
}

function tasks(state = [], action) {
  switch (action.type) {
  case 'TASKS_LIST':
    return [...action.tasks];
  case 'ADD_TASK':
    return [action.task, ...state];
  default:
    return state;
  }
}

function users(state = [], action) {
  switch (action.type) {
  case 'USERS_LIST':
    return [...action.users];
  default:
    return state;
  }
}

let empty_login = {
  email: "",
  pass: "",
};

let empty_form = {
  user_id: "",
  body: "",
  title: "",
  time_spent: "",
  done: "",
  token: "",

};

function clearOptions(state){

  let empty_form = {
  user_id: state.user_id,
  body: "",
  title: "",
  time_spent: "",
  done: "",
  token: state.token,
};

return empty_form;

}

function form(state = empty_form, action) {
  switch (action.type) {
  case 'UPDATE_FORM':
    return Object.assign({}, state, action.data);
  case 'CLEAR_FORM':
    return Object.assign({}, clearOptions(state), action.data);
  case 'SET_TOKEN':
      return Object.assign({}, state, action.token);
  default:
    return state;
  }
}

function root_reducer(state0, action) {
  let reducer = combineReducers({tasks, users, form, token, login});
  let state1 = reducer(state0, action);
  return deepFreeze(state1);
};

let store = createStore(root_reducer);
export default store;