require 'rspec'
require 'album'
require 'pry'
require 'song'

describe '#Album' do

  before(:each) do
    Album.clear()
  end

  describe('.all') do
    it("returns an empty array when there are no albums") do
      expect(Album.all).to(eq([]))
    end
  end

  describe('#save') do
    it("saves an album") do
      album = Album.new("Giant Steps", nil, 2000, "rock", "chi")
      album.save()
      album2 = Album.new("Blue", nil, 2010, "pop", "celeste")
      album2.save()
      expect(Album.all).to(eq([album, album2]))
    end
  end

  describe('.clear') do
    it("clears all albums") do
      album = Album.new("Giant Steps", nil, 2000, "rock", "chi")
      album.save()
      album2 = Album.new("Blue", nil, 2010, "pop", "celeste")
      album2.save()
      Album.clear()
      expect(Album.all).to(eq([]))
    end
  end
  describe('#==') do
    it("is the same album if it has the same attributes as another album") do
      album = Album.new("Giant Steps", nil, 2000, "rock", "chi")
      album2 = Album.new("Giant Steps", nil, 2000, "rock", "chi")
      expect(album).to(eq(album2))
    end
  end

  describe('.find') do
    it("finds an album by id") do
      album = Album.new("Giant Steps", nil, 2000, "rock", "chi")
      album.save()
      album2 = Album.new("Blue", nil, 2010, "pop", "celeste")
      album2.save()
      expect(Album.find(album.id)).to(eq(album))
    end
  end

  describe('#update') do
    it("updates an album by id") do
      album = Album.new("Giant Steps", nil, 2000, "rock", "chi")
      album.save()
      album.update("A Love Supreme", 2000, "rock", "chi")
      expect(album.name).to(eq("A Love Supreme"))
    end
  end

  describe('#delete') do
    it("deletes an album by id") do
      album = Album.new("Giant Steps", nil, 2000, "rock", "chi")
      album.save()
      album2 = Album.new("Blue", nil, 2010, "pop", "celeste")
      album2.save()
      album.delete()
      expect(Album.all).to(eq([album2]))
    end
  end

  describe("#sort") do 
    it ("sorts albums by name") do 
      album = Album.new("Giant Steps", nil, 2000, "rock", "chi")
      album.save()
      album2 = Album.new("Blue", nil, 2010, "pop", "celeste")
      album2.save()
      expect(Album.sort).to(eq([album2,album]))
    end
  end
  
  describe("#sold") do
    it("will show that an album is sold") do
      album = Album.new("Giant Steps", nil, 2000, "rock", "chi")
      album.save()
      album2 = Album.new("Blue", nil, 2010, "pop", "celeste")
      album2.save()
      album.sold()
      album.delete
      expect(Album.all).to(eq([album2]))
    end
  end
  
  describe("#sold") do
    it("it will show all sold albums") do
      album = Album.new("Giant Steps", nil, 2000, "rock", "chi")
      album.save()
      album2 = Album.new("Blue", nil, 2010, "pop", "celeste")
      album2.save()
      album.sold()
      expect(album.sold).to(eq(true))
    end
  end
  describe('#songs') do
    it("returns an album's songs") do
      album = Album.new("Giant Steps", nil, 2000, "rock", "chi")
      album.save()
      song = Song.new("Naima", album.id, nil, "song lyrics", "Sally")
      song.save()
      song2 = Song.new("Cousin Mary", album.id, nil, "song lyrics 2", "Sarah")
      song2.save()
      expect(album.songs).to(eq([song, song2]))
    end
  end
end


