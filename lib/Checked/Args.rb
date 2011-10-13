
module Checked

  class Args
    
    Unknown_Class = Class.new(RuntimeError)

    module Base

      def initialize *arr
        arr.flatten.each { |var|
          case var
          when Array
            var.each { |k|
              define k
            }
          when Hash
            var.each { |k,v|
              define k
              send("#{k}=", v)
            }
          else
            raise Unknown_Class, var.inspect
          end
        }
      end

      def define *raw
        raw.flatten.each { |k|
          eval %~

        def #{k}
          @#{k}
        end

        def #{k}= v
          @#{k} = v
        end

        ~
        }
      end

      def defined? key
        respond_to?( key ) && 
          respond_to?( :"#{key}=" )
      end

    end # === module Base
    
    include Base
    
  end # === module Args
  
end # === module Checked
