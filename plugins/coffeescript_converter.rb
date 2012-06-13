module Jekyll
  require 'coffee-script'
  class CoffeeScriptConverter < Converter
    safe true
    priority :normal

    def matches(ext)
      ext =~ /coffee/i
    end

    def output_ext(ext)
      ".js"
    end

    def convert(content)
      begin
        content = CoffeeScript.compile content
        # OctoPress will pass all content though a RubyPants filter.
        # RubyPants will conver quotes to smart quotes.
        # RubyPants will ignore any convertions when content is surrounded by HTML comment tags
        # This adds HTML comment tags to the output to prevent RubyPants from processing the JavaScript code.
        "// <!-- HTML comment to prevent OctoPress filtering through RubyPants\n#{content}\n// -->"
      rescue StandardError => e
        puts "CoffeeScript error:" + e.message
      end
    end
  end
end
