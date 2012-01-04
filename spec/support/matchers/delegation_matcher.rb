module Custom
  module Shoulda
    module Matchers
      # describe Comment do
      #   it 'should delegate author_name to user' do
      #      Comment.new.should delegate(:author_name, :to => :user, :via => :name)
      #   end
      # end
      class Delegation
        private
        attr_reader :expected, :actual, :method_name, :options, :to, :via
        public
        def initialize(method_name, options = {})
          @method_name = method_name
          options.symbolize_keys!
          @to = options[:to]
          @via = options[:via] || method_name
        end

        def description
          "delegate #{method_name} to #{to} via #{via}"
        end

        def matches?(actual)
          @actual = actual.class
          delegate_class = Class.new
          delegate_class.send(:attr_accessor, @via)

          delegate_object = delegate_class.new
          delegate_object.send("#{@via}=", :spec_rails_matchers_delegation)

          @base_object = @actual.new

          # Use the singleton class of the base_object
          # I am rewriting the @to method on the base_object's meta_class
          # but not altering the base_object's parent class
          # So if I instantiate another instance of @actual
          # it will not have the below behavior, only the @base_object will
          #
          # http://whytheluckystiff.net/articles/seeingMetaclassesClearly.html
          singleton = @base_object.instance_eval("class << self; self; end")
          singleton.class_eval("attr_accessor :#{@to}")

          @base_object.send("#{@to}=", delegate_object)
          @base_object.send(method_name) == :spec_rails_matchers_delegation
        end

        def failure_message
          "expected #{actual.to_s} to delegate :#{method_name} to :#{to} via :#{via}"
        end

        def negative_failure_message
          "expected #{actual.to_s} to NOT delegate :#{method_name} to :#{to} via :#{via}"
        end

        def to_s
          "#{actual.to_s} delegates :#{method_name} to :#{to} via :#{via}"
        end

      end

      def delegates(method_name, options = {})
        Delegation.new(method_name, options)
      end
      alias_method :delegate, :delegates
    end
  end
end