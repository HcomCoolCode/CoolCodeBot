defmodule HotelWordTest do
	use ExUnit.Case
	alias FinBot.Handlers.HotelWordHandler
	
	test "finds word hotel in message" do
		msg = "you know a hotel?"
		assert HotelWordHandler.contains_hotel?(msg)
	end
end
