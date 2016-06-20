defmodule FinBot.Router.Messenger do
	use Maru.Router

	namespace :messenger do

		desc "handshake with FB Messenger"
		get do
			query_params = fetch_query_params(conn).query_params
			case query_params["hub.mode"] do
				"subscribe" ->
					if ("token" == query_params["hub.verify_token"]) do
						text(conn, query_params["hub.challenge"])
					else
						text(conn, "what?")
					end
				_ ->
					text(conn, "what?")
			end
		end

		desc "main entry point for FB Messenger"
		pipeline do
			plug Plug.Parsers, parsers: [:json],
			json_decoder: Poison
		end
		post do
			IO.inspect conn.params
			text(conn, "okay")
		end
	end
end



