class SearchController < ApplicationController

  def search
        @word = params[:word]
    @range = params[:range]
    if @range == "User"
      @users = User.looks(params[:method], params[:word])
    else
      @books = Book.looks(params[:method], params[:word])
    end
  end

end
