require 'pry'
require_relative "../config/environment.rb"


class Song

    attr_accessor :name, :artist, :genre
    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        artist ? self.artist=artist : nil
        genre ? self.genre=genre : nil

    end

    def self.all
        @@all
    end

    def save
        @@all << self
        self
    end

    def self.destroy_all
        @@all.clear
    end

    def self.create(name)
        new(name).save
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre=genre
    end

    def self.find_by_name(name)
        @@all.find {|i| i.name == name}
    end

    def self.find_or_create_by_name(name)
        !find_by_name(name) ? create(name) : find_by_name(name)
    end

    def self.new_from_filename(filename)
        split = filename.split(" - ")

        artist = Artist.find_or_create_by_name(split[0])
        genre = Genre.find_or_create_by_name(split[2].gsub(".mp3",""))

        new(split[1], artist, genre)
        
    end

    def self.create_from_filename(filename)
        new_from_filename(filename).save
    end



        
        

end

