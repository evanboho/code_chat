class Messages

  def initialize
    m = $redis.get("messages")
    @data = m.present? ? JSON.parse(m) : {}
  end

  attr_reader :data

  def add(new_msg)
    n = data.keys.last.to_i
    @data = @data.merge({(n+1).to_s => new_msg})
    $redis.set("messages", @data.to_json)
  end

  def reset
    $redis.set("messages", nil)
  end

end