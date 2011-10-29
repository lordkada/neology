module Neology

  module PropertyMixin

    module ClassMethods

      def _class_name
        self.name
      end

      def properties_hash
        @properties_hash ||= { }
      end

      def property property_name, options= nil
        #p "defining property #{property_name} with options #{options}"
        self.properties_hash[property_name] = options if options
        define_property_setter property_name.to_s
        define_property_getter property_name.to_s
      end

      def define_property_setter property_name
        #p "defining property setter for property #{property_name}"
        send :define_method, "#{property_name}=".to_sym do |value|
          self[property_name.to_sym]= value
        end
      end

      def define_property_getter property_name
        #p "defining property getter for property #{property_name}"
        send :define_method, property_name.to_sym do
          self[property_name.to_sym]
        end
      end

    end

  end

end