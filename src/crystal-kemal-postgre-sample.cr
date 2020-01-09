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

  get "/people/sample" do
    people = sample()
    render "src/views/people_list.ecr", "src/views/layouts/layout.ecr"
  end

  get "/people" do
    people = PersonMapper.find_all()
    render "src/views/people_list.ecr", "src/views/layouts/layout.ecr"
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


#  get "/people/:id" do |env|
#    id = env.params.url["id"]
#    render "src/views/hello.ecr", "src/views/layouts/layout.ecr"
#  end

end

Kemal.run
