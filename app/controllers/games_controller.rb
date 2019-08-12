require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = (0..10).map { ('a'..'z').to_a[rand(26)] }.join
  end

  def score
    @correct = true
    @response = params[:score].split('').sort!
    @letters = params[:letters].split('').sort!
    @response.each do |l|
      unless @letters.include? l
        @correct = false
      else
        @letters.delete_at(@letters.index(l))
      end
    end
    @url = "https://wagon-dictionary.herokuapp.com/#{params[:score]}"
    @user_serialized = open(@url).read
    @user = JSON.parse(@user_serialized)
    @correct ? @result = 'Good joob!' : @result = 'Looser!'
    @result = 'no exist' unless @user['found']
    session[:score] += params[:score].lengthk
    @chunky_bacon = session[:score]
  end
end
