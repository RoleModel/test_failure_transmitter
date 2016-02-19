require_relative './frequency_log_item'

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
