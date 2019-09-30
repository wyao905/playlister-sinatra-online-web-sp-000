class SongsController < ApplicationController
  
  get '/songs' do
    @songs = Songs.all
    erb :index
  end
  
end