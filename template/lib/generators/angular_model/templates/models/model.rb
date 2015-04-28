class <%= class_name.singularize %> < ActiveRecord::Base
  # This Class is composed of <%= @attributes.map { |a| "#{a.name} (:#{a.type})" }.join(", ") %>
end