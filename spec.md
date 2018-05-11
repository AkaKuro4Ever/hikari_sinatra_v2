# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
- [X] Use ActiveRecord for storing information in a database
- [X] Include more than one model class (list of model class names e.g. User, Post, Category)
- [X] Include at least one has_many relationship on your User model (x has_many y, e.g. User has_many Posts)
- [X] Include at least one belongs_to relationship on another model (x belongs_to y, e.g. Post belongs_to User)
- [X] Include user accounts
- [ ] Ensure that users can't modify content created by other users
- [X] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
- [ ] Include user input validations
- [ ] Display validation failures to user with error message (example form URL e.g. /posts/new)
- [ ] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [X] You have a large number of small Git commits
- [X] Your commit messages are meaningful
- [X] You made the changes in a commit that relate to the commit message
- [X] You don't include changes in a commit that aren't related to the commit message

INSTRUCTIONS
Create a new repository on GitHub for your Sinatra Application.
When you create the Sinatra app for your assessment, add the spec.md file from this repo to the root directory of the project, commit it to Git and push it up to GitHub.
Build your application. Make sure to commit early and commit often. Commit messages should be meaningful (clearly describe what you're doing in the commit) and accurate (there should be nothing in the commit that doesn't match the description in the commit message). Good rule of thumb is to commit every 3-7 mins of actual coding time. Most of your commits should have under 15 lines of code and a 2 line commit is perfectly acceptable. This is important and you'll be graded on this.
While you're working on it, record a 30 min coding session with your favorite screen capture tool. During the session, either think out loud or not. It's up to you. You don't need to submit the video, but we may ask for it at a later time.
Make sure to create a good README.md with a short description, install instructions, a contributors guide and a link to the license for your code.
Make sure to check each box in your spec.md (replace the space between the square braces with an x) and explain next to each one how you've met the requirement before you submit your project.
Fill out this checklist.
Prepare a short video demo (narration helps!) describing how a user would interact with your working application.
Write a blog post about the project and process.
When done, submit your GitHub repo's url, a link to your video demo, and a link to your blog post in the corresponding text boxes in the right rail. Hit "I'm done" to wrap it up.


Build an MVC Sinatra Application.
Use ActiveRecord with Sinatra.
Use Multiple Models.
Use at least one has_many relationship on a User model and one belongs_to relationship on another model
Must have user accounts. The user that created a given piece of content should be the only person who can modify that content
Must have the abilty to create, read, update and destroy any instance of the resource that belongs to a user.
Ensure that any instance of the resource that belongs to a user can be edited or deleted only by that user.
You should also have validations for user input to ensure that bad data isn't added to the database. The fields in your signup form should be required and the user attribute that is used to login a user should be a unique value in the DB before creating the user.
