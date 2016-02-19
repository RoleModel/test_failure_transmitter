class FrequencyLogItem
  attr_reader :description
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

  def failure_percent
    (failures.to_f / total_runs) * 100
  end

  def to_s
    "#{failure_percent.round(1)}% - #{description}"
  end

  def <=>(other)
    failure_percent <=> other.failure_percent
  end
end
