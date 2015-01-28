# README

## How to make this rails API

1. rails new <name of your api>_api --database=postgresql --skip-test-unit --skip-spring
1. rake db:create
1. strip out all gems relating to style, css or views:
  * gem 'sass-rails', '~> 4.0.3'
  * gem 'uglifier', '>= 1.3.0'
  * gem 'coffee-rails', '~> 4.0.0'
  * gem 'therubyracer',  platforms: :ruby
  * gem 'jquery-rails'
  * gem 'turbolinks'
1. remove the entire directory `app/assets`
1. remove the entire directory `app/views`
1. add the cors gem
  * `gem 'rack-cors', '~> 0.3.1'` to Gemfile
1. bundle
1. add to bottom of config.ru:

  ```
  use Rack::Cors do
    allow do
      origins 'localhost:3000', '127.0.0.1:3000',
              /http:\/\/192\.168\.0\.\d{1,3}(:\d+)?/
              # regular expressions can be used here

      resource '/file/list_all/', :headers => 'x-domain-token'
      resource '/file/at/*',
          :methods => [:get, :post, :put, :delete, :options],
          :headers => 'x-domain-token',
          :expose  => ['Some-Custom-Response-Header'],
          :max_age => 600
          # headers to expose
    end

    allow do
      origins '*'
      resource '/public/*', :headers => :any, :methods => :get
    end
  end
  ```

1. add to `config/application.rb` (within `class Application < Rails::Application`):

  ```
  config.middleware.insert_before 0, "Rack::Cors" do
    allow do
      origins '*'
      resource '*', :headers => :any, :methods => [:get, :post, :options]
    end
  end
  ```

1. in `application_controller.rb`, change `:exception` to
  * :null_session
1. add `resources :notes, except: [:new, :edit]` to routes
  * new and edit are views which send params to create and update. We don't need those views.
1. add `notes_controller.rb`
1. add index action to notes controller

  ```
  def index
    @notes = Note.all
    render json: @notes
  end
  ```

1. add model `note.rb`
  * delete the `.keep` file in the models directory
1. `$ rails g migration CreateNotes title:string body:text`
  * add `t.timestamps` to the created migration
1. `$ rake db:migrate`
1. `rails s`
  * go to [http://localhost:3000/notes](http://localhost:3000/notes) and you should see `[]` (an array of no notes)
