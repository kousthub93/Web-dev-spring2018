import React from 'react';
import Task from './task';

export default function Feed(params) {
  let tasks = _.map(params.tasks, (pp) => <Task key={pp.id} task={pp} loginUser={params.user} />);
  return <div>
    { tasks }
  </div>;
}