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
        file = Pathname.new(image).basename
        src = File.join('/', @path, file)

        src2 = File.join('/uploads/', File.basename(image).sub(File.extname(image), "-thumb#{File.extname(image)}"))
        puts "#{src2}"

        source += "<a class='image-item'>\n"
        source += "<img src='#{src}' data-src='#{src2}' alt='gallery item' width='100%' class='responsive-img materialboxed lazyload'>\n"
        source += "</a>\n"
      end
      source += "</div>\n"
      source
    end

Liquid::Template.register_tag 'image_set', self
end


class Bla < Jekyll::StaticFile
  def write(dest)
      super(dest) rescue ArgumentError
      true
    end
end

class ThumbnailGenerator < Jekyll::Generator
    def generate(site)
      full_path = File.join("_uploads", "**", "*.{png,jpg,jpeg,gif}")
      puts "#{full_path}"

      files = Dir.glob(full_path).uniq.sort
      Dir.glob(files).each do |image|
          x =File.basename(image).sub(File.extname(image), "-thumb#{File.extname(image)}")
          puts "#{x}"
          bla = Bla.new(site,site.dest, "uploads", x, site.collections['uploads'])
          site.static_files << bla

          thumb_path = site.dest + "/uploads/" + x
          image = MiniMagick::Image.open(image)
          image.strip
          image.resize "30%x30%"
          image.write thumb_path
          if bla.path() == thumb_path
            puts "yeah: #{thumb_path}"
          end
      end
    end
end
