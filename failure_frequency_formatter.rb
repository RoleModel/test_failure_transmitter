require 'pry'
require 'yaml'
require_relative './frequency_logger'

LOG_PATH = './failure_log.yml'

class FailureFrequencyFormatter
  RSpec::Core::Formatters.register self, :stop, :close

  attr_reader :output

  def initialize(output)
    @output = output
  end

  def logger
    @logger ||= begin
      if File.exist?(LOG_PATH)
        YAML.load_file(LOG_PATH)
      else
        FrequencyLogger.new
      end
    end
  end

  def stop(notification)
    log_example_statuses(notification.examples)
    save_results_to_file
  end

  def close(notification)
    print_summary
  end

  def log_example_statuses(examples)
    examples.each do |example|
      if example.execution_result.status == :passed
        logger.log_example_passed(example)
      elsif example.execution_result.status == :failed
        logger.log_example_failed(example)
      end
    end
  end

  def save_results_to_file
    File.open(LOG_PATH, 'w') do |file|
      file.write YAML.dump(logger)
    end
  end

  def print_summary
    output.puts "Most Frequent Failures:"
    logger.most_frequent_failures.each do |log_item|
      output.puts log_item
    end
  end
end
