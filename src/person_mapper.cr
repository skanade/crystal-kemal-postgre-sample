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

  def self.create(person : Person)
    dbconfig = DBConfig.init

    # postgresql: use $1, $2, etc
    insert_sql = "insert into people (id, first, last) values ($1, $2, $3)"

    nextval_sql = "select nextval('people_id_seq')"

    DB.open dbconfig.postgres_uri do |db|
      id = db.scalar nextval_sql
      
      person.id = id.to_s.to_i

      db.exec insert_sql, person.id, person.first, person.last
    end
    
    person
  end

  def self.update(person : Person)
    dbconfig = DBConfig.init

    # postgresql: use $1, $2, etc
    update_sql = "update people set first = $1, last = $2 where id = $3"

    DB.open dbconfig.postgres_uri do |db|
      db.exec update_sql, person.first, person.last, person.id
    end

    person
  end

  def self.delete_by_id(id)
    dbconfig = DBConfig.init

    # postgresql: use $1
    delete_sql = "delete from people where id = $1"

    DB.open dbconfig.postgres_uri do |db|
      result = db.exec delete_sql, id
      puts result
    end
  end

  def self.find_by_id(id)
    dbconfig = DBConfig.init

    # postgresql: use $1
    find_sql = "select id, first, last from people where id = #{id}"

    DB.open dbconfig.postgres_uri do |db|
      id, first, last = db.query_one find_sql, as: { Int32, String, String }
      person = Person.new(id, first, last)
      return person
    end
  end

end
