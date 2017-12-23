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
        markdown << "## #{expectation.capitalize}"
        markdown << description.capitalize unless description.nil? 
      end

      markdown.join("\n\n")
    end
  end
end
