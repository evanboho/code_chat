class Messages

  def initialize(chan=nil)
    @channel = chan || make_new_channel
  end

  attr_reader :data
  attr_reader :channel

  def data
    @data ||= fetch_data
  end

  def add(new_msg)
    messages.merge!({ new_key => new_msg })
    $redis.set("messages", data.to_json)
  end

  def self.reset
    $redis.set("messages", nil)
  end

  def reset
    data.delete(channel)
    $redis.set("messages", data.to_json)
  end

  def messages
    data[@channel] ||= {}
  end

  def self.lang_options_for_select
    lang_options.collect { |a| [a,a] }
  end

  def self.lang_options
    %w(ruby javascript python java)
  end

  private

  def fetch_data
    m = $redis.get("messages")
    m.present? ? JSON.parse(m) : {}
  end

  def make_new_channel
    while (chan ||= nil).nil? || data.keys.include?(chan)
      chan = (("0".."9").to_a + ("a".."z").to_a).shuffle.first(6).join
    end
    chan
  end

  def last_key
    messages.keys.last.to_i
  end

  def new_key
    (last_key + 1).to_s
  end

end