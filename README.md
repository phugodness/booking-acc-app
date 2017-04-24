
# Welcome to TruongVanPhu's Final Project

@(Ruby on Rails)[Ruby | jQuery]

[TOC]

## Introducing

> My purpose of project is create a site where everybody can find the a to live temporarily at anywhere they want with a reasonable price.Some how like a clone of [Airbnb](http://www.airbnb.com)

## About Me

  My name is **Truong Van Phu**. I'm a student at Danang University of Technology [DUT](http://dut.udn.vn). I'm also an engineer at [AsianTech Co, Ltd](http://www.asiantech.vn). I'm learning Ruby,  Ruby on Rails and Rust. In spare time, my interesting is playing 3-cushion, surfing web and watching Twice (a korean music girl group).
If you have any question you can contact me via:
- Email: <phugodness@gmail.com>
- Facebook: [facebook](http://facebook.com/phugodness)
- Twitter: [@phugodness](twitter.com/phugodness)

## Main Technology
1. Real time messages by Action Cable
2. Payment with Paypal
3. Google maps API
4. Cronjob

## Main Features

## How to run
1. Ruby Version:  `2.3.0`
2. Rails version: `5.0.1`

# Prerequisites
- Install Ubuntu 14.04 LTS (recommended)
- Install oh-my-zsh for boosting your Git work
- Install Git
- Install rbenv or rvm
 - Install Ruby
 - Install Rails
- Install PostgeSQL, and pgadmin for GUI

# Guide
- **Step 1**: Clone repo
 - ```$ git clone git@github.com:phugodness/iptv.git```
- **Step 2**: Create database
 - ```$ cp config/database.yml.sample config/database.yml```
 - modify <%= ENV['USERNAME'] %> and <%= ENV['PASSWORD'] %> in database.yml with your Postgres Login roles
- **Step 3**:Install gem dependencies
 - ```$ bundle install```
- **Step 4**:Switch branch (because we mainly develop on ``develop branch``)
 - ```$ git checkout develop```
- **Step 5**:Setup Server
 - ```$ rails db:setup```
- **Step 6**:Seed for database
 - ```$ rails db:seed```
- **Step 7**:Start Server
 - ```$ rails s```
- **Step 8**: Enjoy

### Description
