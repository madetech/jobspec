module JobSpec
  class AdhocExpectations
    def self.clear!
      @expectations = nil
    end

    def self.define(expectation, &block)
      @expectations ||= []
      @expectations << new(expectation, &block)
    end

    def self.roles
      return [] if @expectations.nil?

      roles = {}
      @expectations.each do |expectation|
        expectation.to_a.each do |role_expectation|
          roles[role_expectation[:role]] ||= {
            name: role_expectation[:role],
            expectations: []
          }

          roles[role_expectation[:role]][:expectations] << {
            expectation: role_expectation[:expectation],
            description: role_expectation[:description]
          }
        end
      end
      roles.values
    end

    def initialize(expectation, &block)
      @expectation = expectation
      @block = block
      instance_eval(&block) unless block.nil?
    end

    def description(description)
      @description = description
    end

    def roles(*roles)
      @roles = roles
    end

    def to_a
      @roles.map do |role|
        {
          role: role,
          expectation: @expectation,
          description: @description
        }
      end
    end
  end
end
