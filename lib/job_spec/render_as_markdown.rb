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

      role.expectations.map(&:values).each do |(expectation, description)|
        markdown << "## #{expectation[0].upcase}#{expectation[1..expectation.length]}"
        markdown << description unless description.nil?
      end

      markdown.join("\n\n")
    end
  end
end
