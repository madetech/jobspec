module JobSpec
  class RenderAsMarkdown
    attr_reader :role

    def initialize(role)
      @role = role
    end

    def render
      markdown = []
      markdown << "# #{role.name}"
      markdown << role.description unless role.description.nil?

      grouped_expectations.each do |group, expectations|
        if group.nil?
          markdown << '## Expectations' unless role.expectations.empty?
        else
          markdown << "## #{group}"
        end

        expectations.map(&:values).each do |(expectation, description)|
          markdown << "### #{expectation[0].upcase}#{expectation[1..expectation.length]}"
          markdown << description unless description.nil?
        end
      end

      markdown.join("\n\n")
    end

    private

    def grouped_expectations
      role.expectations.group_by do |expectations|
        expectations[:group]
      end
    end
  end
end
