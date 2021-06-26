Sinatra Application Template
Welcome to the Photographer Workflow Database, it is an MVC sinatra app, in it, you can record different clients and sessions for later reference,  and is a great database to work with several photographers because it gives you the visibility to compare jobs prices and experiences.

Getting Started
Go to https://github.com/l1mk/photographer_workflow_database and click "clone or download" green button, select clone with SHH and in your command promp, type:
$git clone https://github.com/l1mk/photographer_workflow_database

After that make sure you are inside the new directory by using:
$cd photographer_workflow_database

Configuration
Dependencies and all configuration is done in environment.rb and config.ru. Database is stored in DB folder with all the migrations. Gemfile already has all the gems you will require so make sure you run:
$bundle install
(if you encounter an issue with fully running bundle install, due to thin version, try running this first $bundle update thin)
To have rake and shotgun installed, and from there, run all your migrations:
$rake db:migrate

This will create a schema with all tables for each class. After you are good to go, just run Shotgun:
$shotgun
And from the title "Your server is running at 192.xxx.xxx.xxx:xxxxx" copy that IP address to your browser, allowing you to see the app live from the browser.

Usage
The website give you the option to signup or sign in, and after following the instruction of any, it will take you to the welcome page, where you can see all your fellow photographers that have created an account, and all clients and sessions for all members of the website.

You can also visit an index of all clients, and all sessions independently. Look at your profile as a photographer where you can see all work you have done, and edit or delete your own profile.

Sessions and Clients can be created as well, and edited and delete by the person who created each.
Give it a try and let me know any feedback.

Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/'juansiu'/a_quote_a_day. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the Contributor Covenant code of conduct.

License
The gem is available as open source under the terms of the MIT License.

Code of Conduct
Everyone interacting in the AQuoteADay project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the code of conduct.
