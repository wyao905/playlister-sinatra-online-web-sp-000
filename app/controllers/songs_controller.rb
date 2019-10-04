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
    song_artist = Artist.find_by_slug(params[:artist_name].downcase.split(" ").join("-"))
    
    if song_artist == ""
      song_artist = Artist.create(name: params[:artist_name])
      @song.artist = song_artist
    else
      @song.artist = song_artist
    end
    
    @song.genres << Genre.find_by_slug(params[:genre_name].downcase.split(" ").join("-"))
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
    @genres = Genre.all
    erb :'/songs/edit'
  end
  
  patch '/songs/:slug/edit' do
    if !params.keys.include?("genre_name")
      params["genre_name"] = []
    end
    
    @song = Song.find_by_slug(params[:slug])
    if !params[:artist_name].empty?
      song_artist = Artist.find_by_slug(params[:artist_name].downcase.split(" ").join("-"))
      if song_artist == ""
        song_artist = Artist.create(name: params[:artist_name])
        @song.artist = song_artist
      else
        @song.artist = song_artist
      end
    end

    Genre.all.each do |genre|
      if genre.slug == params[:genre_name].downcase.split(" ").join("-")
        @song.genres << genre if !@song.genres.include?(genre)
      end
    end
    
    @song.save
    flash[:message] = "Successfully updated song."
    
    redirect "/songs/#{@song.slug}"
  end
end