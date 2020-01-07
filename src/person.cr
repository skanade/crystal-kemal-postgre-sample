class Person
  getter id : Int32
  getter first : String
  setter first
  getter last : String
  setter last

  def initialize(@id, @first, @last)
  end
  def to_s
    "#{id} #{first} #{last}"
  end
  
end
