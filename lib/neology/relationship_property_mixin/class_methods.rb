module Neology

  module RelationshipPropertyMixin

    module ClassMethods

      def _class_name
        self.name
      end

      def relationship_properties_hash
        @relationship_properties_hash ||= { }
      end

      def property property_name, options= nil
        #p "defining relationship property #{property_name} with options #{options}"
        self.relationship_properties_hash[property_name] = options if options
        define_relationship_property_setter property_name.to_s
        define_relationship_property_getter property_name.to_s
      end

      def define_relationship_property_setter property_name
        #p "defining relationship property setter for property #{property_name}"
        send :define_method, "#{property_name}=".to_sym do |value|
          self[property_name.to_sym]= value
        end
      end

      def define_relationship_property_getter property_name
        #p "defining relationship property getter for property #{property_name}"
        send :define_method, property_name.to_sym do
          self[property_name.to_sym]
        end
      end

    end

  end

end