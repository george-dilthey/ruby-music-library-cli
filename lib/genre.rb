require 'pry'
require_relative "../config/environment.rb"


class Genre

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

    def songs
        Song.all.select {|song| song.genre == self}
    end

    def artists
        Song.all.collect {|song| song.artist if song.genre == self}.uniq
    end


end