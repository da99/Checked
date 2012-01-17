class Checked
  class Vars

    def check!
      return!
    end

    def either! *args
      answer = args.flatten.detect { |m|
        begin
          return!.send m
          true
        rescue Failed
          false
        end
      }
      demand answer, "...is not any: #{args.inspect}"
    end

    def be! *args
      rejected = args.flatten.select { |m|
        !(return!.send m)
      }
      demand rejected.empty?, "...must be all of these: #{rejected.map(&:to_s).join(', ')}"
    end

    def not_be! *args
      rejected = args.flatten.select { |m|
        !!(return!.send m)
      }
      demand rejected.empty?, "...must not be: #{rejected.map(&:to_s).join(', ')}"
    end

    def one_of! *klasses
      demand \
        klasses.flatten.any? { |k| return!.is_a?(k) }, \
          "...can only be of class/module: #{klasses.map(&:to_s).join(', ')}"
    end

    def nil!
      demand return!.nil?, "...must be nil."
    end

    def not_nil!
      demand !return!.nil?, "...can't be nil." 
    end

    def respond_to! *args
      rejected = args.reject { |m|
        !return!.respond_to?(m)
      }
      demand rejected.empty?, "...must respond to #{rejected.inspect}"
    end

  end # === class Vars
end # === module Checked

