class Song
  attr_reader :id
  attr_accessor :name, :album_id, :lyrics, :songwriter

  @@songs = {}
  @@total_rows = 0

  def initialize(name, album_id, id, lyrics, songwriter)
    @name = name
    @lyrics = lyrics
    @songwriter = songwriter
    @album_id = album_id
    @id = id || @@total_rows += 1
  end

  def ==(song_to_compare)
    (self.name() == song_to_compare.name()) && (self.album_id() == song_to_compare.album_id())
  end

  def self.all
    @@songs.values
  end

  def save
    @@songs[self.id] = Song.new(self.name, self.album_id, self.id, self.lyrics, self.songwriter)
  end

  def self.find(id)
    @@songs[id]
  end

  def update(name, album_id, lyrics, songwriter)
    self.name = name
    self.lyrics = lyrics
    self.songwriter = songwriter
    self.album_id = album_id
    @@songs[self.id] = Song.new(self.name,self.album_id, self.id, self.lyrics, self.songwriter)
  end

  def delete
    @@songs.delete(self.id)
  end

  def self.clear
    @@songs = {}
  end
  def self.find_by_album(alb_id)
    songs = []
    @@songs.values.each do |song|
      if song.album_id == alb_id
        songs.push(song)
      end
    end
    songs
  end
  
  def album
    Album.find(self.album_id)
  end
end