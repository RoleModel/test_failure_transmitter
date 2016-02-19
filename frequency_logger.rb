require_relative './frequency_log_item'

class FrequencyLogger
  attr_writer :total_runs

  def log
    @log ||= {}
  end

  def total_runs
    @total_runs ||= 0
  end

  def log_example_passed(example)
    log[example.id] ||= FrequencyLogItem.new(example.full_description)
    log[example.id].passed
  end

  def log_example_failed(example)
    log[example.id] ||= FrequencyLogItem.new(example.full_description)
    log[example.id].failed
  end

  def log_run_finished
    self.total_runs += 1
  end

  def most_frequent_failures(count = 10)
    log.values.keep_if { |log_item| log_item.failures > 0 }.sort.reverse.take(count)
  end
end
