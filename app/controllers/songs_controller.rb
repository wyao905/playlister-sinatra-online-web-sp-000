class SongsController < ApplicationController
  enable :sessions
    
  get '/songs' do
    @songs = Song.all
    erb :'/songs/index'
  end
  
  get '/songs/new' do
    @genres = Genre.all
    erb :'/songs/new'
  end
  
  post '/songs/new' do
    if Artist.find_by_slug(params[:artist_name]).empty?
      song_artist = Artist.create(name: params[:artist_name])
    end
    
    @song = Song.create(name: params[:song_name])
    @song.artist = song_artist
    @song.genres << Genre.find_by_slug(params[:genre_name])
    flash[:message] = "Successfully created song."
    redirect "/songs/#{@song.slug}"
  end
  
  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/show'
  end
end