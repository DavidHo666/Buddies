# README

### Title: Buddies: Join Now!
#### Team Members: 
- Yi Zhong(yz4330) 
- Yuxin Yang(yy3277) 
- Dawei He(dh3027) 
- Yuhan Xia(yx2729)

#### Instructions:
- GitHub Link: https://github.com/dorissssy/buddies
- Ruby version: 3.1.0
- Machine's OS: Mac
- Branch: Master Branch, tag: Buddies: Launch
- Follow these instructions to get a local copy of our project:
  ```cmd
  git clone  https://github.com/dorissssy/buddies.git
  cd buddies
  bundle install
  yarn install
  rake db:create
  rake db:migrate
  ```
- To run our project on local host, use the command `rails server`, and go to `localhost:3000` in browser. You should be able to run our product now!
- You could also try our project at heroku! Heroku deployment: https://buddies4152.herokuapp.com/

#### Testing
We provide two kinds of test that could both show test coverage. Use the following command to test:
- Cucumber test: `rake cucumber`
- Rspec test: `rake spec`

Under `coverage` folder, there are two subfolders showing coverage for rspec and coverage for cucumber. They are automatically created by running the above two commands.

So far, we have gained 98.97% coverage for cucumber test and 94.36% coverage for rspec test!

Here is the screenshot for cucumber test:
<img width="1449" alt="image" src="https://user-images.githubusercontent.com/56754826/208322410-0e81586f-f6f7-493c-9290-a9f48a972c8a.png">

Here is the screenshot for rspec test:
<img width="1113" alt="image" src="https://user-images.githubusercontent.com/56754826/208322420-99e15389-d51d-43c7-b568-058b2590fda9.png">



#### Notice
When creating a new event, the user is asked to choose a start time and an end time for the event. The current time for our website is under EST

To let the newly created events seen by all other users, the user have to follow these rules:
- Start time should be before end time. 
- End time should be after current time.

Otherwise, a "Time Invalid" warning would pop out.

For users under timezone other than EST, they have to consider the time difference. For example, if the current time is Nov 16, 2022, 7:30 pm EST, and the user at San Fransisco wants to create an event that ends at Nov 16, 2022, 3:30 pm locally (6:30 pm EST), the system would automatically consider time as 3:30 pm EST, and the event would not be created due to "Time Invalid" error.

In addition, when clicking the create button, if the user use the current minute as the end time, the newly created events would be considered as "Event passed already", and could only be seen by the current user under "Event Posted" along with all other passed events. For example, if the current time is Nov 16, 2022, 7:30 pm EST, and the user at San Fransisco wants to create an event that ends at Nov 16, 2022, 4:30 pm locally (7:30 pm EST), the event would be created, but could only be seen under "Event Posted".

For testing purposes, user could simply choose an end time a month later than current time.
