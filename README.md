# Government Outcomes Tracker API


Data Model

`Government`:
  Think of this as the core tenant. This is currently unused, but is useful for future development where we want to track
  provincial governments in addition to the federal government. 
  


Things you may want to cover:

* Ruby version
  3.4.4
* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

### 🛠 Setup

```bash
# Install dependencies
bundle install

# Setup PostgreSQL (Ubuntu example)
sudo service postgresql start

# Setup database
rails db:create
rails db:migrate
rails db:seed

# Run the server
rails s
```