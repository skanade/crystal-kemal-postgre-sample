require "totem"

class DBConfig
  getter server : String
  getter port : Int32
  getter database : String

  def initialize()
    config = Totem.from_file "./main.yml"

    @server = config.get("db").as_h["server"].as_s
    @port = config.get("db").as_h["port"].as_i
    @database = config.get("db").as_h["database"].as_s
  end

  def self.init() : DBConfig
    @@instance ||= new
  end

  def postgres_uri
    "postgres://#{@server}:#{@port}/#{@database}"
  end
  
end
