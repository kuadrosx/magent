$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'magent'
require 'pry'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|

  def run_jobs(*args, &blk)
    channel = Magent::AsyncChannel.new(:specs)
    processor = Magent::Processor.new(channel)

    processor.run!(false)

    yield channel if blk

    channel.clear!
    channel.stats_collection.remove({})
  end
end
