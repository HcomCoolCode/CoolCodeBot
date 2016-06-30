defmodule FinBot.Handlers.HotelWordHandler do
	use GenEvent
	alias FinBot.SendFb
	
	@go_to_hotels_com "Go visit http://uk.hotels.com"

	def init(_args) do
		IO.inspect "go to Hotels.com handler started"
		{:ok, []}
	end

	def handle_event({:message, message}, _state) do
		%{id: senderId, text: msgText} = decompose(message)
		if contains_hotel?(msgText) do
			SendFb.post(senderId, @go_to_hotels_com)
		end
		{:ok, []}
	end
	
	def handle_event(_message, state) do
		{:ok, state}
	end

	def decompose(message) do
		%{"sender" =>
			%{"id" => senderId},
			"message" =>
			%{"text" => msgText}} = message
		%{id: senderId, text: msgText}
	end

	def contains_hotel?(text) do
		text =~ ~r<hotel|hoteles>i
	end
end
