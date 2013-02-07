if defined? RSpec
  task(:spec).clear
  desc "Run all specs"
  RSpec::Core::RakeTask.new spec: 'db:test:clone_structure' do |t|
    t.rspec_opts = ['--format progress']
  end
end
