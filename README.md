# Ruby on Rails framework applicaiton

This is a framework for a Home/Office automation project. This project intends
to create a network of IOT Devices (Raspberry Pi and Arduino) to be endpoints
that communicate with a central server (API) to control access, temperature,
lighting, and various other actions. The intent is to create a customizable
experience for the resident/tenant while giving the owner controls to maximize
power saving and security.

## Getting started

To get started with the app, clone the repo and then install the needed gems:

```
$ cd /path/to/repos
$ git clone https://github.com/dusterg20/rails_web_frame.git sample_app_reference
$ cd sample_app_reference
$ bundle install --without production
```

Next, migrate the database:

```
$ rails db:migrate
```

Finally, run the test suite to verify that everything is working correctly:

```
$ rails test
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
```
