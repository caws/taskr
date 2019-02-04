# Taskr - A kanban-like todo example application on Rails

![Alt Text](https://i.imgur.com/N51MOOd.gif)

This is an example project.
I figured it would be cool to code a Ruby on Rails example project employing a few interesting (at least to me) RoR concepts. 
The basic idea behind it is to provide a platform that lets multiple users CRUD tasks while keeping everyone's screens updated.


What's in this solution:

* AJAX (using Rails' [remote elements](https://guides.rubyonrails.org/working_with_javascript_in_rails.html#remote-elements))
* WebSocket (using  [Action Cable](https://github.com/rails/rails/tree/master/actioncable) )
* API/Model Tests (using [Rspec](https://github.com/rspec/rspec-rails))
* [Scopes](https://guides.rubyonrails.org/active_record_querying.html#scopes)
* [Active Record Validations](https://guides.rubyonrails.org/active_record_validations.html)
* has_many / belongs_to [Active Record Associations](https://guides.rubyonrails.org/association_basics.html)
* [Active Record Callbacks](https://guides.rubyonrails.org/active_record_callbacks.html)
* Some seed data
* API endpoints to manage tasks (with versioning)

Extra stuff:
* Notifications using [Notify.js](https://notifyjs.jpillora.com/) (triggered via WebSocket actions)

API endpoints:

| Result | Request Type | URL |
| :---: | :---: | :---: |
| Return tasks| GET | /api/v1/tasks  |
| Create task | POST | /api/v1/tasks  |
| Return task with id = 1 | GET | /api/v1/tasks/1  |
| Update task with id = 1 | PATCH/PUT | /api/v1/tasks/1  |
| Delete task with id = 1 | DELETE | /api/v1/tasks/1  |

## Getting Started

* Clone the project
* rake:db create db:migrate db:seed
* bundle install
* rails s

## Prerequisites

```
Rails 5.2.2
Ruby 2.5.1
```

## Built With

* [Action Cable](https://github.com/rails/rails/tree/master/actioncable)
* [Bootstrap](https://github.com/twbs/bootstrap) 
* [Font-Awesome](https://github.com/FortAwesome/Font-Awesome)
* [Notify.js](https://notifyjs.jpillora.com/)
* [Rails](https://github.com/rails/rails)
* [Rspec](https://github.com/rspec/rspec-rails)
* [ServiceWorker::Rails](https://github.com/rossta/serviceworker-rails)
 

## Author

* **Charles Washington de Aquino dos Santos** - [Caws](https://github.com/caws)

## Acknowledgments

* StackOverflow
* Google (lots of)
