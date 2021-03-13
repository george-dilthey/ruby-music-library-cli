require 'pry'
require_relative "../config/environment.rb"

class Artist

    extend Concerns::Findable

    attr_accessor :name
    @@all = []

    def initialize(name)
        @name = name
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

    def add_song(song)
        !song.artist ? song.artist=self : nil
    end

    def songs
        Song.all.select {|song| song.artist == self}
    end

    def genres
        Song.all.collect {|song| song.genre if song.artist == self }.uniq
    end


end