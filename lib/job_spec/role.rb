module JobSpec
  class Role
    def self.definition(name, &block)
      @definitions ||= {}
      @definitions[name] = new(name, &block)
    end

    def self.definitions
      @definitions.values
    end

    def self.add_expectations(role_expectations)
      expectation = role_expectations.first[:expectations].first

      role_expectations.each do |role_expectation|
        role = @definitions[role_expectation[:name]]
        role_expectation[:expectations].each do |e|
          role.expected(e[:expectation], e[:description])
        end
      end

      nil
    end

    def initialize(name, &block)
      @name = name
      @expectations = []
      instance_eval(&block) if block_given?
    end

    def name
      @name
    end

    def description(description = nil)
      @description = @description || description
    end

    def salary(range = nil)
      @salary = @salary || range
    end

    def include(role_expectations, as:)
      @expectations.concat(role_expectations.to_a.map { |expectation| expectation.merge(group: as) })
    end

    def expected(expectation, description = nil)
      @expectations << { expectation: expectation, description: description, group: nil }
    end

    def expectations
      @expectations
    end

    class Expectations
      def self.expected(expectation, description = nil)
        @role ||= Role.new(self.class.name)
        @role.expected(expectation, description)
      end

      def self.to_a
        @role.expectations
      end
    end
  end
end
