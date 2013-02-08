$:.unshift File.expand_path("../../lib", __FILE__)

require 'magent'

class Inception
  include Magent::Async

  def enter
    puts "enter"
    self.async(:queue1).leave
  end

  def leave
    puts "leave"
  end
end

Inception.new.async(:queue1).enter

channel = Magent::AsyncChannel.new(:queue1)
processor = Magent::Processor.new(channel)

processor.run!(true)

