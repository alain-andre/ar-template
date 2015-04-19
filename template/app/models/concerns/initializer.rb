module Initializer
  extend ActiveSupport::Concern

  included do # instance methods goes here
    # Initialize the generator accepting model attributes as arguments  
    def initialize(*args, &block)
      super
      @attributes = []
      model_attributes.each do |attribute|
        @attributes << Rails::Generators::GeneratedAttribute.new(*attribute.split(":")) if attribute.include?(":")
      end
    end
  end

end
