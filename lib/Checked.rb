require "Checked/version"

%w{ Args Base Ask Clean Demand }.each { |klass|
  require "Checked/#{klass}"
}
  
%w{ Ask Clean Demand }.each { |type|
  Dir.glob(File.join File.dirname(__FILE__), "Checked/#{type}/.rb").each { |path|
    path =~ %r!lib/Checked/(.+)/(.+)\.rb!
    require( "Checked/#{$1}/#{$2}" ) if $1 && $2
  }
}

module Checked
  module DSL
    
    # ============ Demand ==============
    
    def demand *args
      raise "No block allowed here." if block_given?
      
      Demand.new( *args )
    end
    
    %w{ Arrays Bools File_Paths Strings Symbols }.each { |klass|
      eval %~
        def #{klass.downcase.sub(/s\Z/, '')}! *args, &blok
          Demand::#{klass}.new(*args, &blok)
        end
      ~
    }

    # ============= Ask ================

    def ask? target, *args
      Checked::Ask.new(target) { |a|
        a.<< args
      }.true?
    end

    def true? target, *args
      demand! block_given?, :no_block!
      q = Ask.new(target)
      q << args
      q.true?
    end

    def any? target, *args
      demand! block_given?, :no_block!
      q = Ask.new(target)
      q << args
      q.any?
    end

    # ============ Clean ===============
    
    def clean target, *args
      raise "No block allowed here." if block_given?

      c = Clean.new(target)
      c.<(*args)
      c.target
    end


  end # === module DSL
end
