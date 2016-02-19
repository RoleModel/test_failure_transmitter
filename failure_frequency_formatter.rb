require 'pry'
require 'yaml'

LOG_PATH = './failure_log.yml'

class FailureFrequencyFormatter
  # This registers the notifications this formatter supports, and tells
  # us that this was written against the RSpec 3.x formatter API.
  RSpec::Core::Formatters.register self, :stop

  def initialize(output)
    @output = output
  end

  def logger
    @logger ||= begin
      if File.exists?(LOG_PATH)
        YAML.load_file(LOG_PATH)
      else
        FrequencyLogger.new
      end
    end
  end

  def stop(notification)
    notification.examples.each do |example|
      if example.execution_result.status == :passed
        logger.log_example_passed(example)
      elsif example.execution_result.status == :failed
        logger.log_example_failed(example)
      end
    end

    File.open(LOG_PATH, 'w') do |file|
      file.write YAML.dump(logger)
    end
  end
end

class FrequencyLogger
  def log
    @log ||= {}
  end

  def log_example_passed(example)
    log[example.location_rerun_argument] ||= FrequencyLogItem.new(example.full_description)
    log[example.location_rerun_argument].passed
  end

  def log_example_failed(example)
    log[example.location_rerun_argument] ||= FrequencyLogItem.new(example.full_description)
    log[example.location_rerun_argument].failed
  end
end

class FrequencyLogItem
  attr_writer :total_runs, :failures

  def initialize(description)
    @description = description
  end

  def total_runs
    @total_runs ||= 0
  end

  def failures
    @failures ||= 0
  end

  def passed
    self.total_runs += 1
  end

  def failed
    self.total_runs += 1
    self.failures += 1
  end
end
