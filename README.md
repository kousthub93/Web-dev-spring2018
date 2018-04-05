Single Page Task Tracker Web App:

Database Design:
1. Two tables i.e, users and tasks are created in the database.
2. users table has following fields:
   name   : <string>, null: false 
   email  : <string>, null: false
   password: <Argon2>, null: false  // password is hashed before storing
   So when a user registers, above fields manadatory. Once the user submits the information, its stored in the database and later used for retrieval
3. tasks table has following fileds:
   user_id    : <number> (foreign key referencing user table), null: false, on_delete: delete_all
   assigned_to: <string>, null: false
   task_title : <string>
   task_body  : <string>
   done      : <boolean>
   time_spent  : <integer> 
   
   The above database design is made so that the app has the following main features:
   a) User cannot login without entering email address, name and password
   b) user_id in tasks table is referencing the users table and if a user is deleted, all tasks corresponding to that user is deleted.
   d) Once the task is created, new task can be seen appended to the same page. It can be edited and also can be deleted. 
   
4. Once the user logs in, the current user is stored in the session which is further used to populate assigned_by field in the new task creation page and this field is not editable

5. The tasks assigned by the user are only visible on the tasks page.
