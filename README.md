# Test Failure Transmitter

A spike at creating a plugin for RSpec that logs test failure data to an external service

# Usage

The formatter requires some configuration:

```rb
FailureFrequencyFormatter.configure do |config|
  config.host = 'localhost'
  config.port = 3000
  config.path = '/projects/1/test_results'
end
```

To use it: `rspec --format FailureFrequencyFormatter`
