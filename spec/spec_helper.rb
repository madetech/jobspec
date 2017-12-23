require_relative '../lib/job_spec'

class SharedExpectationsExample < JobSpec::Role::Expectations
  expected 'to shared these',
    'Nice.'
end
