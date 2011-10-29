module Neology

  class DataTypeConverter

    def self.convert_to_native value, type

      if value

        case type.name

          when Float.name
            value = value.to_f

          when Integer.name
            value = value.to_i

          when String.name
            value = value.to_s

          when Time.name
            value = Time.at(value.to_f)

        end

      end

      value

    end

  end

end