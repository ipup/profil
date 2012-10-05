module Tinymce::Hammer

  mattr_accessor :install_path, :src, :languages, :themes, :plugins, :setup

  @@install_path = '/javascripts/tiny_mce'

  @@src = false

  @@setup = nil

  @@plugins = ['paste']

  @@languages = ['en']

  @@themes = ['advanced']

  @@init = {
    :paste_convert_headers_to_strong => true,
    :paste_convert_middot_lists => true,

    :theme => 'advanced',
    :theme_advanced_toolbar_align => 'left',
    :theme_advanced_toolbar_location => 'top',
    :theme_advanced_buttons1 => 'bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,formatselect,fontselect,fontsizeselect',
    :theme_advanced_buttons2 => 'bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,help,|,forecolor,backcolor,|,removeformat,cleanup,code',
    :theme_advanced_buttons3 => '',
    :valid_elements => "a[href|title,blockquote[cite],span[style|_mce_style],address,br,caption,cite,code,dl,dt,dd,em,i,img[src|alt|title|width|height|align],li,ol,p[style],pre,q[cite],small,strike,strong/b,u,ul,h1,h2,h3,h4,h5,h6" ,
  }

  def self.init= js
    @@init = js
  end

  def self.init
    @@init
  end

  def self.cache_js
    File.open("#{Rails.root}/public/javascripts/tinymce_hammer.js", 'w') do |file|
      file.write Combiner.combined_js
    end
  end

end
