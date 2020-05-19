class Song
  attr_reader :id
  attr_accessor :name, :lyrics, :songwriter, :album_id



  def initialize(attributes)
    @name = attributes.fetch(:name)
    @lyrics = attributes.fetch(:lyrics)
    @songwriter = attributes.fetch(:songwriter)
    @album_id = attributes.fetch(:album_id)
    @id = attributes.fetch(:id)
  end

  def ==(song_to_compare)
    if song_to_compare != nil
      (self.name() == song_to_compare.name()) && (self.album_id() == song_to_compare.album_id())
    else
      false
    end
  end

  def self.all
    returned_songs = DB.exec("SELECT * FROM songs;")
    songs = []
    returned_songs.each() do |song|
      name = song.fetch("name")
      lyrics = song.fetch("lyrics")
      songwriter = song.fetch("songwriter")
      album_id = song.fetch("album_id").to_i
      id = song.fetch("id").to_i
      songs.push(Song.new({:name => name, :lyrics => lyrics, :songwriter => songwriter, :album_id => album_id, :id => id}))
    end
    songs
  end
    
  # @@songs.values

  def save
    result = DB.exec("INSERT INTO songs (name, lyrics, songwriter, album_id) VALUES ('#{@name}','#{@lyrics}','#{@songwriter}', #{@album_id}) RETURNING id;")
    @id = result.first().fetch("id").to_i
    # @@songs[self.id] = Song.new(self.name, self.album_id, self.id, self.lyrics, self.songwriter)
  end

  def self.find(id)
    song = DB.exec("SELECT * FROM songs WHERE id = #{id};").first
    if song
    name = song.fetch("name")
    lyrics = song.fetch("lyrics")
    songwriter = song.fetch("songwriter")
    album_id = song.fetch("album_id").to_i
    id = song.fetch("id").to_i
    Song.new({:name => name, :lyrics => lyrics, :songwriter => songwriter, :album_id => album_id, :id => id})
    else
      nil
    end
  end

  def update(name, lyrics, songwriter, album_id)
    @name = name
    @lyrics = lyrics
    @songwriter = songwriter
    @album_id = album_id
    DB.exec("UPDATE songs SET name = '#{@name}', lyrics= '#{@lyrics}', songwriter = '#{@songwriter}', album_id = #{@album_id} WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM songs WHERE id = #{@id};")
  end

  def self.clear
    DB.exec("DELETE FROM songs *;")
  end

  def self.find_by_album(alb_id)
    songs = []
    returned_songs = DB.exec("SELECT * FROM songs WHERE album_id = #{alb_id};")
    returned_songs.each() do |song|
      name = song.fetch("name")
      lyrics = song.fetch("lyrics")
      songwriter = song.fetch("songwriter")
      id = song.fetch("id").to_i
      songs.push(Song.new({:name => name, :lyrics => lyrics, :songwriter => songwriter, :album_id => alb_id, :id => id}))
    end
    songs
  end

  def album
    Album.find(@album_id)
  end
end