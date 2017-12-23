module JobSpec
  class Role
    def self.definition(name, &block)
      @definitions ||= []
      @definitions << new(name, &block)
    end

    def self.definitions
      @definitions
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

    def include(role_expectations)
      @expectations.concat(role_expectations.to_a)
    end

    def expected(expectation)
      @expectations << expectation
    end

    def expectations
      @expectations
    end

    class Expectations
      def self.expected(expectation)
        @role ||= Role.new(self.class.name)
        @role.expected(expectation)
      end

      def self.to_a
        @role.to_a
      end
    end
  end
end
