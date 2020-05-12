require('sinatra')
require('sinatra/reloader')
require('./lib/album')
require('pry')
also_reload('lib/**/*.rb')

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

get('/albums/search') do
  user_search = params[:search]
  @search = Album.search(user_search)
  erb(:search)
end

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
  album = Album.new(name, nil)
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
  @sold_albums = @albums.sold()
  @album.update(params[:name])
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
