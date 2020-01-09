require "json"

class Person
  getter id : Int32
  setter id
  getter first : String
  setter first
  getter last : String
  setter last

  def initialize(id, first, last)
    @id = id
    @first = first
    @last = last
  end
  def initialize(first, last)
    initialize(0, first, last)
  end
  def to_s
    "#{id} #{first} #{last}"
  end

  JSON.mapping(
    id: Int32,
    first: String,
    last: String
  )
  
end
