require 'pry'
require_relative "../config/environment.rb"

class MusicImporter

    attr_accessor :path

    def initialize(path)
        @path = path
    end

    def files
        Dir["#{@path}/*"].map {|i| i.split("/")[4]}
    end

    def import
    end

end

