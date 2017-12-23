require 'thor'
require 'job_spec'

module JobSpec
  class CLI < Thor
    desc 'build DIR', 'build roles in DIR'
    def build(path = '.')
      print "Building roles in #{path}... "
      Dir[File.join(Dir.pwd, path, '**/*.rb')].each { |f| require f }
      puts 'done.'
      p Role.definitions
    end

    map %w(--version -v) => :version

    desc '--version', 'get jobspec version'
    def version
      puts "jobspec v#{JobSpec::VERSION}"
    end
  end
end
