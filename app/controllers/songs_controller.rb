require 'rack-flash'

class SongsController < ApplicationController
  use Rack::Flash
  
  get '/songs' do
    @songs = Song.all
    erb :'/songs/index'
  end
  
  get '/songs/new' do
    @genres = Genre.all
    erb :'/songs/new'
  end
  
  post '/songs/new' do
    @song = Song.create(name: params[:song_name])
    song_artist = Artist.find_by_slug(params[:artist_name])
    
    if song_artist.empty?
      song_artist = Artist.create(name: params[:artist_name])
      @song.artist = song_artist
    else
      @song.artist = song_artist.first
    end
    
    @song.genres << Genre.find_by_slug(params[:genre_name])
    @song.save
    flash[:message] = "Successfully created song."

    redirect "/songs/#{@song.slug}"
  end
  
  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/show'
  end
  
  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/edit'
  end
end