class Agent
  include Magent::Async

  def self.enqueue_job(name, *args)
    async(:specs).send(name, *args)
  end

  def self.do_job(*args)
    puts ">> exec job with #{args.inspect}"
  end

  def self.do_job_and_fail(*args)
    raise ">> fail running do_job_and_fail with #{args.inspect}"
  end
end
