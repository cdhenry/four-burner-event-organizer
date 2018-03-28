# Four Burner Event Organizer

Welcome to the Four Burner Event Organizer! This is a Sinatra web app that allows users to organize their schedules around the four-burner theory of work-life balance.

Users set up an account, log in, and create Events with date and duration stamps. Those events are then collated and can be seen through the lens of the four-burner pie chart. This visualization will help users get a sense of how they are spending their time in a similar way to how credit card companies use web apps to show users how they are spendiing their money.

Users can also edit and update their events later on and the burner breakdown will adjust.

### Installation & Usage Clone this repository.

And then write in your terminal:
```
$ bundle

$ rake db:migrate
```
Set up the app with some example date by writing in your terminal:
```
$ rake db:seed
```
(You can always delete that seed info later) This app has the gem 'shotgun' installed. In your terminal, run
```
$ shotgun
```
And in your browser, go to http://localhost:9393/ to get started! To stop running this app, type ^C (Control + C).

### Contributing 

Bug reports and pull requests are welcome on GitHub at https://github.com/cdhenry/four-burner-event-organizer. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the Contributor Covenant code of conduct.

### License 

The gem is available as open source under the terms of the MIT License.

### Code of Conduct 

Everyone interacting in the Four-Burner-Event-Organizer's project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the code of conduct.
