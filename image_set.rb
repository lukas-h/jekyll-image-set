# ImageSet Liquid Plugin
# by Erik Dungan
# erik.dungan@gmail.com / @callmeed
#
require 'mini_magick'

  class ImageSet < Liquid::Tag
    @path = nil

    @class = nil

    def initialize(tag_name, text, tokens)
      super
      
      @path = text.split(/\s+/)[0].strip

      @class = 'image'

    end

    def render(context)
      full_path = File.join(context.registers[:site].config['source'], "_" + @path, "*.{jpg,jpeg,JPG,JPEG,png,PNG}")

      source = "<div class='image-set'>\n"

      files = Dir.glob(full_path).uniq.sort

      Dir.glob(files).each do |image|
        check = image.end_with? ".thumb.jpg"
        if check == false
        file = Pathname.new(image).basename.to_s
        src = File.join('/', @path, file)
        src_thumb = File.join('/', @path, file + ".thumb.jpg")
        source += "<a class='image-item'>\n"
        source += "<img src='#{src}' alt='gallery item' width='100%' class='responsive-img materialboxed lazyload'>\n" +
                  "<img src='#{src_thumb}' alt='gallery item' width='100%' class='responsive-img materialboxed lazyload'>\n"
        source += "</a>\n"
        img = MiniMagick::Image.open(image)
        img.resize "30%x30%"
        img.write(image + ".thumb.jpg")
        end
      end

      source += "</div>\n"
      source
    end

Liquid::Template.register_tag 'image_set', self

end
