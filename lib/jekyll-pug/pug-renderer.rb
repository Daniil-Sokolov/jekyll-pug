# This is where the magic happens
module Jekyll
  class LiquidRenderer
    File.class_eval do
      def parse(content)        
        measure_time do
            if @filename =~ /\.pug$/
                userSource = $JEKYLLPUG_PROJECT_SOURCE
                content = Pug.compile(content, {"filename"=>userSource})
            end
            # if content.lines.first =~ /^$/
            # content = content.sub(/^$\n/, "")
            # end
            @template = Liquid::Template.parse(content, :line_numbers => true)
        end

        self
      end
    end
  end
end

# This section ensures that Pug files are compiled as HTML.
module Jekyll
  class PugConverter < Converter
      safe true
      priority :low

      def matches(ext)
          ext =~ /^\.pug$/i
      end

      def output_ext(ext)
          ".html"
      end

      def convert(content)
          return content
      end
  end
end