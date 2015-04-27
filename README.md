[![Build Status](https://travis-ci.org/ectomorph314/msds.svg)](https://travis-ci.org/ectomorph314/msds) [![Code Climate](https://codeclimate.com/github/ectomorph314/MSDS/badges/gpa.svg)](https://codeclimate.com/github/ectomorph314/MSDS) [![Coverage Status](https://coveralls.io/repos/ectomorph314/msds/badge.svg)](https://coveralls.io/r/ectomorph314/msds)

#Readme

[App on Heroku](https://safety-data-sheet-depot.herokuapp.com/)

SDSD is a mobile friendly web app that allows companies/schools to upload pdf files of their safety data sheets so that their employees/students can easily access important health and safety information.

App uses Ruby on Rails and Foundation. PDF uploads using CarrierWave and Amazon S3.

*Data generated using Faker gem*

To use the app locally on your machine:
```
$ git clone git@github.com:ectomorph314/msds.git
$ rake db:create
$ rake db:migrate
```

Test suite uses Rspec, Capybara, as well as FactoryGirl.

To run test suite:
```
$ rspec
```
