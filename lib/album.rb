require 'pry'

class Album

  attr_reader :id, :name 
  attr_accessor :name, :sold_albums, :year, :genre, :artist
  @@albums = {}
  @@total_rows = 0
  

  def initialize(name, id, year, genre, artist)
    @name = name  
    @id = id || @@total_rows += 1 
    @year = year.to_i
    @genre = genre
    @artist = artist
    @sold_albums = false 
   
  end

  def self.all
    @@albums.values()
  end
    
  def save
    @@albums[self.id] = Album.new(self.name, self.id, self.year, self.genre, self.artist)
  end

  def ==(album_to_compare)
    self.name() == album_to_compare.name()
  end

  def self.clear
    @@albums = {}
    @@total_rows = 0
  end

  def self.find(id)
    @@albums[id]
  end

  # def self.search(search)
  #   @@albums.values().select {|a| a.name.match(/#{search}/i)}
  # end 

  def update(name, year, genre, artist)
    self.name = name
    self.year = year.to_i
    self.genre = genre
    self.artist = artist
    @@albums[self.id] = Album.new(self.name, self.id, self.year, self.genre, self.artist )
  end

  def self.sort()
     @@albums.values().sort_by(&:name)
  end

  def delete()
    @@albums.delete(self.id)
  end
   
  def sold
    @@albums[self.id].sold_albums = true
  end
  
  def songs
    Song.find_by_album(self.id)
  end
end

