require_relative "../config/environment.rb"

class MusicLibraryController

    attr_accessor :path

    def initialize(path = './db/mp3s')
        @path = path
        MusicImporter.new(path).import
        
    end

    def call
        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"
        
        input = gets.chomp

        input == 'list songs' ? self.list_songs : nil
        input == 'list artists' ? self.list_artists : nil
        input == 'list genres' ? self.list_genres : nil
        input == 'list artist' ? self.list_songs_by_artist : nil
        input == 'list genre' ? self.list_songs_by_genre : nil
        input == 'play song' ? self.play_song : nil



        input == 'exit' ? nil : self.call
     
    end

    def sort_by_name(i)
        i.sort {|a,b| a.name <=> b.name}
    end

    def list_songs
        count = 1
        sort_by_name(Song.all).each {|s| 
            puts "#{count}. #{s.artist.name} - #{s.name} - #{s.genre.name}" 
            count+=1
        }
    end

    def list_artists
        count = 1
        sort_by_name(Artist.all).each {|a| 
            puts "#{count}. #{a.name}" 
            count+=1
        }
    end

    def list_genres
        count = 1
        sort_by_name(Genre.all).each {|g| 
            puts "#{count}. #{g.name}" 
            count+=1
        }    
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets.chomp
        if Artist.find_by_name(input)
            count = 1
            songs = Artist.find_by_name(input).songs
            sort_by_name(songs).each {|s| 
                puts "#{count}. #{s.name} - #{s.genre.name}" 
                count+=1
            }
        end 
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets.chomp
        if Genre.find_by_name(input)
            count = 1
            songs = Genre.find_by_name(input).songs
            sort_by_name(songs).each {|s| 
                puts "#{count}. #{s.artist.name} - #{s.name}" 
                count+=1
            }
        end 
    end

    def play_song
        puts "Which song number would you like to play?"
        input = gets.chomp
        if input.to_i >= 1 && input.to_i <= Song.all.length + 1
            songs = sort_by_name(Song.all)
            song = songs[input.to_i-1]
            if song.class == Song
                puts "Playing #{song.name} by #{song.artist.name}"
            end
        end
    end




end

   # if input == 'list songs'
        #     Song.all.each {|s| puts "#{s.name}"}
        # elsif input == 'list artists'
        #     Artist.all.each {|a| puts "#{a.name}"}
        # elsif input == 'list genres'
        #     Genre.all.each {|g| puts "#{g.name}"}
        # elsif input == 'list artist'
        #     Genre.all.each {|g| puts "#{g.name}"}
        # elsif input == 'exit'
        #     nil
        # else self.call
        
        # end        
