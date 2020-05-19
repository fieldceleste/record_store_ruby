require 'pry'

class Album

  attr_reader :id, :name 
  attr_accessor :name, :year, :genre, :artist, :sold_albums
 

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id).to_i
    @years = attributes.fetch(:years)
    @genre = attributes.fetch(:genre)
    @artist = attributes.fetch(:artist)
    @sold_albums = false 
  end

  def self.all
    returned_albums = DB.exec("SELECT * FROM albums;")
    albums = []
    returned_albums.each() do |album|
      name = album.fetch("name")
      id = album.fetch("id").to_i
      years = album.fetch("years")
      genre = album.fetch("genre")
      artist = album.fetch("artist")
      albums.push(Album.new({:name => name, :id => id, :years => years, :genre => genre, :artist => artist}))
    end
    albums
  end

  def save
    result = DB.exec("INSERT INTO albums (name, years, genre, artist) VALUES ('#{@name}', '#{@years}', '#{@genre}', '#{@artist}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def ==(album_to_compare)
    self.name() == album_to_compare.name()
  end

  def self.all_sold
    self.get_albums('SELECT * FROM sold_albums;')
  end

  def self.clear
    DB.exec("DELETE FROM albums *;")
  end

  def self.find(id)
    album = DB.exec("SELECT * FROM albums WHERE id = #{id};").first
    name = album.fetch("name")
    id = album.fetch("id").to_i
    years = album.fetch('years')
    genre = album.fetch('genre')
    artist = album.fetch('artist')
    Album.new({:name => name, :id => id, :years => years, :genre => genre, :artist => artist})
  end

  # def self.search(search)
  #   self.get_albums("SELECT * FROM albums WHERE lower(name) LIKE '%#{search}%';")
  # end

  def update(name, years, genre, artist)
    @name = name
    @years= years
    @genre = genre
    @artist = artist
    DB.exec("UPDATE albums SET name = '#{@name}' WHERE id = #{@id};")
  end

  def self.sort()
    self.get_albums('SELECT * FROM albums ORDER BY name;')
  end

  def delete()
    DB.exec("DELETE FROM albums WHERE id = #{@id};")
    DB.exec("DELETE FROM songs WHERE album_id = #{@id};")
  end
   
  def sold
    result = DB.exec("INSERT INTO sold_albums (name, years, genre, artist) VALUES ('#{@name}', '#{@years}', '#{@genre}', '#{@artist}') RETURNING id;")
    @id = result.first().fetch('id').to_i
    DB.exec("DELETE FROM albums WHERE id = #{@id};")
    # @@albums[self.id].sold_albums = true
  end
  
  def songs
    Song.find_by_album(self.id)
  end
 end 