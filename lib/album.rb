require 'pry'

class Album

  attr_reader :id, :name 
  attr_accessor :name, :sold_albums
  @@albums = {}
  @@total_rows = 0

  def initialize(name,id)
    @name = name
    @id = id || @@total_rows += 1 
    @sold_albums = false 
  end

  def self.all
    @@albums.values()
  end

  # def self.all_sold
  #   @@sold_albums.values()
  # end
    
  def save
    @@albums[self.id] = Album.new(self.name, self.id)
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

  def self.search(search)
    @@albums.values().select {|a| a.name.match(/#{search}/i)}
  end 

  def update(name)
    self.name = name
    @@albums[self.id] = Album.new(self.name, self.id)
  end

  def self.sort()
     @@albums.values().sort_by(&:name)
  end

  def delete()
    @@albums.delete(self.id)
  end
   
  def sold
    @@albums[self.id].sold_albums = true
    # @@sold_albums[self.id] = @@albums[self.id]
    # @@albums.delete(self.id)
  end
end