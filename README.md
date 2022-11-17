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
- Branch: Master Branch, commit: buddies-itr-1-final
- Follow these instructions to get a local copy of our project:
  ```cmd
  git clone  https://github.com/dorissssy/buddies.git
  cd buddies
  bundle install
  ```
- To run our project on local host, use the command `rails server`, and go to `localhost:3000` in browser. You should be able to run our product now!
- You could also try our project at heroku! Heroku deployment: https://buddies4152.herokuapp.com/

#### Testing
We provide two kinds of test that could both show test coverage. Use the following command to test:
- Cucumber test: `rake cucumber`
- Rspec test: `rake spec`

Under `coverage` folder, there are two subfolders showing coverage for rspec and coverage for cucumber. They are automatically created by running the above two commands.

So far, we have gained 100.0% coverage for cucumber test and 97.95% coverage for rspec test!

Here is the screenshot for cucumber test:
<img width="1089" alt="Screen Shot 2022-11-16 at 7 07 20 PM" src="https://user-images.githubusercontent.com/72602630/202322002-f2c4338e-5b4d-48d3-a90a-ad5d372160bf.png">

Here is the screenshot for rspec test:
<img width="1091" alt="Screen Shot 2022-11-16 at 7 07 31 PM" src="https://user-images.githubusercontent.com/72602630/202322016-f0bccd35-8a66-43ef-9fe1-9aa910629060.png">


#### Notice
When creating a new event, the user is asked to choose a start time and an end time for the event. The current time for our website is under UTC, which is 5 hours after EST.

To let the newly created events seen by all other users, the user have to follow these rules:
- Start time should be before end time. 
- End time should be after current time.

Otherwise, a "Time Invalid" warning would pop out.

For users under timezone other than UTC, they have to consider the time difference. For example, if the current time is Nov 16, 2022, 7:30 pm UTC, and the user at New York wants to create a event that ends at Nov 16, 2022, 3:30 pm locally (8:30 pm UTC), the system would automatically consider time as 3:30 pm UTC, and the event would not be created due to "Time Invalid" error.

In addition, when clicking the create button, if the user use the current minute as the end time, the newly created events would be considered as "Event passed already", and could only be seen by the current user under "Event Posted" along with all other passed events. For example, if the current time is Nov 16, 2022, 7:30 pm UTC, and the user at New York wants to create a event that ends at Nov 16, 2022, 2:30 pm locally (7:30 pm UTC), the event would be created, but could only be seen under "Event Posted".

For testing purposes, user could simply choose an end time a month later than current time.
