class <%= class_name %> < ActiveRecord::Base
  # This Class is composed of <%= @attributes.map { |a| "#{a.name} (:#{a.type})" }.join(", ") %>
end