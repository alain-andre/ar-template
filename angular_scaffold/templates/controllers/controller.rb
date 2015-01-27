class <%= class_name.pluralise %>Controller < ApplicationController
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def <%= class_name.underscore %>_params
      params.require(:<%= class_name.underscore %>).permit(<%= @attributes.map { |a| ":#{a.name}" }.join(", ") %>)
    end
end