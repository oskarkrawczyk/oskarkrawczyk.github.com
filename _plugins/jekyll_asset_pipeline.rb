require 'jekyll_asset_pipeline'

module JekyllAssetPipeline
  class CoffeeScriptConverter < JekyllAssetPipeline::Converter
    require 'coffee-script'

    def self.filetype
      '.coffee'
    end

    def convert
      return CoffeeScript.compile(@content)
    end
  end

  class SassConverter < JekyllAssetPipeline::Converter
    require 'sass'

    def self.filetype
      '.scss'
    end

    def convert
      return Sass::Engine.new(@content, load_paths: ['.', '_assets', '_assets/scss', '_assets/images'], syntax: :scss).render
    end
  end
end
