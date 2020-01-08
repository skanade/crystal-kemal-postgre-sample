require "./person"
require "./dbconfig"

module PersonMapper

  def self.find_all_statement()
    "select id, first, last from people"
  end

  def self.load(rs)
    id = rs.read(Int32)
    first = rs.read(String)
    last = rs.read(String)

    person = Person.new(id, first, last)
  end

  def self.find_all()
    dbconfig = DBConfig.init

    people = Array(Person).new

    DB.open dbconfig.postgres_uri do |db|
      db.query find_all_statement do |rs|
        rs.each do 
          person = load(rs)
          people << person
        end
      end
    end

    people
  end

end
