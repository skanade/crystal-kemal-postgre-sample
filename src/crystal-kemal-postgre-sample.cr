require "kemal"
require "db"
require "pg"

require "./person"
require "./person_mapper"

def sample()
  people = Array(Person).new
  people << Person.new(1, "John", "Smith")
  people << Person.new(2, "Mary", "Jane")
  people << Person.new(3, "David", "Jones")
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

#  get "/people/:id" do |env|
#    id = env.params.url["id"]
#    render "src/views/hello.ecr", "src/views/layouts/layout.ecr"
#  end

end

Kemal.run
