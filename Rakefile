require 'pact_broker/client/tasks'

PACT_BROKER_BASE_URL = ENV["PACT_BROKER_BASE_URL"] || "http://localhost:8000"
PACT_BROKER_TOKEN    = ENV["PACT_BROKER_TOKEN"]

git_commit = `git rev-parse HEAD`.strip

PactBroker::Client::PublicationTask.new do |task|
  task.pact_broker_base_url = PACT_BROKER_BASE_URL
  task.pact_broker_token    = PACT_BROKER_TOKEN
  task.consumer_version     = git_commit
  task.tag_with_git_branch  = true
end

require 'rspec/core/rake_task'


RSpec::Core::RakeTask.new('pact:spec') do |task|
  task.pattern = 'spec/pact/providers/**/*_spec.rb'
  task.rspec_opts = ['-t pact']
end
RSpec::Core::RakeTask.new('pact:spec:v1') do |task|
  task.pattern = 'spec/payment_service_client_spec.rb'
  task.rspec_opts = ['-t pact']
end
