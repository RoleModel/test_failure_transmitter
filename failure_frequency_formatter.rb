require_relative './frequency_logger'
require 'net/http'
require 'json'

class FailureFrequencyFormatter
  RSpec::Core::Formatters.register self, :stop

  class Configuration
    attr_accessor :host, :port, :path
  end

  def self.configure
    yield config
  end

  def self.config
    @config ||= Configuration.new
  end

  attr_reader :output

  def initialize(output)
    @output = output
  end

  def config
    self.class.config
  end

  def logger
    @logger ||= FrequencyLogger.new
  end

  def stop(notification)
    send_test_results(notification.examples)
  end

  def send_test_results(examples)
    result = examples.each_with_object([]) do |example, results|
      if example.execution_result.status == :passed
        results << { description: example.full_description, passed: true }
      elsif example.execution_result.status == :failed
        results << { description: example.full_description, passed: false }
      end
    end
    results = { results: result }
    Net::HTTP.new(config.host, config.port).post(config.path, results.to_json, 'Content-Type' => 'application/json')
  end
end
