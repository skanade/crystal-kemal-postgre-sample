require "kemal"
require "db"
require "pg"

require "./person"
require "./person_mapper"

def sample()
  people = Array(Person).new
  people << Person.new(-1, "John", "Smith")
  people << Person.new(-2, "Mary", "Jane")
  people << Person.new(-3, "David", "Jones")
  people
end

module Crystal::Kemal::Postgre::Sample
  VERSION = "0.1.0"

  get "/" do
    render "src/views/index.ecr", "src/views/layouts/layout.ecr"
  end

  get "/people/sample" do
    people = sample()
    render "src/views/people_list.ecr", "src/views/layouts/layout.ecr"
  end

  get "/people" do
    people = PersonMapper.find_all()
    render "src/views/people_list.ecr", "src/views/layouts/layout.ecr"
  end

  get "/people/search" do
    render "src/views/people_search.ecr", "src/views/layouts/layout.ecr"
  end

  before_post "/people/search" do |env|
    env.response.content_type = "application/json"
  end

  post "/people/search" do |env|
    #puts "===== env.params ===="
    #puts env.params.pretty_inspect

    text = env.params.json["text"].as(String)
    puts "post /people/search for text: #{text}"

    puts "post /people/search env.response.headers['Content-Type']: #{env.response.headers["Content-Type"]}"

    people = PersonMapper.find_names_like(text)

    #puts typeof(env.response)
    #{"name": "Foo"}.to_json

    people.to_json
  end

  get "/people/delete/:id" do |env|
    id = env.params.url["id"]

    PersonMapper.delete_by_id(id)

    env.redirect "/people"
  end

  post "/people/create" do
    render "src/views/people_create.ecr", "src/views/layouts/layout.ecr"
  end

  post "/people/save" do |env|
    first = env.params.body["first"]
    last = env.params.body["last"]

    person = Person.new(first, last)
    person = PersonMapper.create(person)

    render "src/views/people_update.ecr", "src/views/layouts/layout.ecr"
  end

  get "/people/update/:id" do |env|
    id = env.params.url["id"]

    person = PersonMapper.find_by_id(id)

    render "src/views/people_update.ecr", "src/views/layouts/layout.ecr"
  end

  post "/people/update" do |env|
    id = env.params.body["id"]
    first = env.params.body["first"]
    last = env.params.body["last"]

    person = Person.new(id.to_i, first, last)
    person = PersonMapper.update(person)

    render "src/views/people_update.ecr", "src/views/layouts/layout.ecr"
  end

end

Kemal.run
