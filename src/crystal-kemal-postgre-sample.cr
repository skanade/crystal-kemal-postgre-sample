require "kemal"
require "db"
require "pg"
require "totem"

require "./person"
require "./dbconfig"

def sample()
  people = Array(Person).new
  people << Person.new(1, "John", "Smith")
  people << Person.new(2, "Mary", "Jane")
  people << Person.new(3, "David", "Jones")
  people
end

def people_from_db()
  config = Totem.from_file "./main.yml"
  
  dbconfig = DBConfig.new(config)
  
  people = Array(Person).new

  DB.open dbconfig.postgres_uri do |db|
    db.query "select id, first, last from people" do |rs|
      rs.each do 
        id = rs.read(Int32)
        first = rs.read(String)
        last = rs.read(String)
        person = Person.new(id, first, last)

        people << person
      end
    end
  end

  people
end

module Crystal::Kemal::Postgre::Sample
  VERSION = "0.1.0"

  get "/sample" do
    people = sample()
    render "src/views/people_list.ecr", "src/views/layouts/layout.ecr"
  end

  get "/" do
    people = people_from_db()
    render "src/views/people_list.ecr", "src/views/layouts/layout.ecr"
  end

end

Kemal.run
