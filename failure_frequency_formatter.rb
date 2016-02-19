require 'pry'
require 'yaml'
require_relative './frequency_logger'

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
