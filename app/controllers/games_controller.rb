class GamesController < ApplicationController
	skip_before_action :verify_authenticity_token
	require 'chessmate'

	def index
		@game = session[:game].nil? ? ChessMate.new : ChessMate.new(**game_params)
		@PIECES = {
			"BK" => "&#9818;",
			"BQ" => "&#9819;",
			"BR" => "&#9820;",
			"BB" => "&#9821;",
			"BN" => "&#9822;",
			"BP" => "&#9823;",
			"WK" => "&#9812;",
			"WQ" => "&#9813;",
			"WR" => "&#9814;",
			"WB" => "&#9815;",
			"WN" => "&#9816;",
			"WP" => "&#9817;"
		}
		@history = @game.move_history
	end

	def move
		@game = session[:game].nil? ? ChessMate.new : ChessMate.new(**game_params)
		if @game.move(move_params[:origin], move_params[:destination], test=true)
			@game.move(move_params[:origin], move_params[:destination])
		end
		session[:game] = @game
		render js: "window.location = '#{root_path}'"
	end

	def new
		reset_session
		redirect_to root_path
	end

	private

	def move_params
		params.permit(:origin, :destination)
	end

	def game_params
		params = session[:game].deep_symbolize_keys
		params
	end
end
