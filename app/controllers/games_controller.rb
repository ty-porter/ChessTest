class GamesController < ApplicationController
	skip_before_action :verify_authenticity_token
	require 'chessmate'

	def index
		@game = session[:game].nil? ? ChessMate.new : ChessMate.new(session[:game]["board"])
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
		session[:game] = @game
	end

	def move
		@game = ChessMate.new(session[:game]["board"])
		@game.move(params[:origin], params[:destination])
		session[:game] = @game
		redirect_to root_path		
	end

	private

	def move_params
		params.permit(:origin, :destination)
	end
end
