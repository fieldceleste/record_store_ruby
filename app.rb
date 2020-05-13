require('sinatra')
require('sinatra/reloader')
require('./lib/album')
require('./lib/song')
require('pry')
also_reload('lib/**/*.rb')

set :port, 5000

get('/') do
  @albums = Album.all
  erb(:albums) 
end

get('/albums') do
  @albums = Album.all
  erb(:albums)
end

get('/albums/new') do
  erb(:new_album)
end

# get('/albums/search') do
#   user_search = params[:search]
#   @search = Album.search(user_search)
#   erb(:search)
# end

get('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  if params["_method"]
    @album.sold
    @albums = Album.all
    erb(:albums)
  else
    # puts params
    erb(:album)
  end
end

post('/albums') do
  name = params[:album_name]
  year = params[:album_year]
  genre = params[:album_genre]
  artist = params[:album_artist]
  album = Album.new(name, nil, year, genre, artist)
  # @album.update(params[:album_name], params[:album_year], params[:album_genre], params[:album_artist])
  album.save()
  @albums = Album.all()
  erb(:albums)
end

get('/albums/:id/edit') do
  @album = Album.find(params[:id].to_i())
  erb(:edit_album)
end

patch('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @sold_albums = @album.sold()
  @album.update(params[:name], params[:album_year], params[:album_genre], params[:album_artist])
  @albums = Album.all
  erb(:albums)
end
 
delete('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.delete()
  @albums = Album.all
  erb(:albums)
end

 get('/albums/:id') do 
  @album = Album.find(params[:id].to_i())
  @album.sort()
  @albums = Albums.all
  erb(:albums)
end

# ///----Songs---------------------------------------------->

get('/albums/:id/songs/:song_id') do
  @song = Song.find(params[:song_id].to_i())
  erb(:song)
end
# Post a new song. After the song is added, Sinatra will route to the view for the album the song belongs to.
post('/albums/:id/songs') do
  @album = Album.find(params[:id].to_i())
  song_name = params[:song_name]
  lyrics = params[:lyrics]
  songwriter = params[:songwriter]
  song = Song.new(song_name, @album.id, nil, lyrics, songwriter)
  song.save()
  #@songs = Song.all
  #@albums = Album.all
  erb(:album)
end

# Edit a song and then route back to the album view.
patch('/albums/:id/songs/:song_id') do
  @album = Album.find(params[:id].to_i())
  song = Song.find(params[:song_id].to_i())
  song.update(params[:song_name], @album.id, params[:lyrics], params[:songwriter])
  # @songs = Song.all
  erb(:album)
end

# Delete a song and then route back to the album view.
delete('/albums/:id/songs/:song_id') do
  song = Song.find(params[:song_id].to_i())
  song.delete
  @album = Album.find(params[:id].to_i())
  erb(:album)
end