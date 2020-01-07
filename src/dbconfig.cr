class DBConfig
  getter server : String
  getter port : Int32
  getter database : String

  def initialize(config)
    @server = config.get("db").as_h["server"].as_s
    @port = config.get("db").as_h["port"].as_i
    @database = config.get("db").as_h["database"].as_s
  end

  def postgres_uri
    "postgres://#{@server}:#{@port}/#{@database}"
  end
  
end
