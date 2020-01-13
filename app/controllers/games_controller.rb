class GamesController < ApplicationController
	skip_before_action :verify_authenticity_token
	require 'chessmate'

	def index
		@game = session[:game].nil? ? ChessMate.new : ChessMate.new(**game_params)
		@PIECES = {
			"BK" => "king",
			"BQ" => "queen",
			"BR" => "rook",
			"BB" => "bishop",
			"BN" => "knight",
			"BP" => "pawn",
			"WK" => "king",
			"WQ" => "queen",
			"WR" => "rook",
			"WB" => "bishop",
			"WN" => "knight",
			"WP" => "pawn"
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
