require 'thor'
require 'job_spec'

module JobSpec
  class CLI < Thor
    desc 'build', 'build roles in DIR out to DIR'
    option :in, required: true
    option :out, required: true
    def build
      puts "Looking in '#{options[:in]}' for roles... "
      role_files(options[:in]).each do |f|
        require f
      end

      FileUtils.mkdir_p(path_relative_to_pwd(options[:out]))
      JobSpec::Role.add_expectations(JobSpec::AdhocExpectations.roles)
      Role.definitions.each do |role|
        puts "Saving #{role.name} to #{safe_role_out_path(role)}..."
        File.write(safe_role_out_path(role), RenderAsMarkdown.new(role).render)
      end
      puts 'Finished.'
    end

    map %w(--version -v) => :version

    desc '--version', 'get jobspec version'
    def version
      puts "jobspec v#{JobSpec::VERSION}"
    end
  end
end

def path_relative_to_pwd(path)
  File.expand_path(path, Dir.pwd)
end

def path_glob(dir)
  path_relative_to_pwd(File.join(dir, '**/*.rb'))
end

def role_files(dir)
  Dir[path_glob(dir)]
end

def safe_role_name(role)
  "#{role.name.downcase.gsub(' ', '_').gsub(/[^a-z_]+/, '')}.md"
end

def safe_role_out_path(role)
  File.join(path_relative_to_pwd(options[:out]), safe_role_name(role))
end
