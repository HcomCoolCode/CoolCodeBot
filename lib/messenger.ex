defmodule FinBot.Router.Messenger do
	use Maru.Router

	namespace :messenger do

		desc "handshake with FB Messenger"
		get do
			IO.inspect conn
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

		desc "main entry point got FB Messenger"
		params do
			optional :object, type: String
			optional :entry, type: List do
				optional :id, type: String
				optional :time, type: String
				optional :messaging, type: List do
					optional :optin
					optional :message
					optional :delivery
					optional :postBack
				end
			end
		end
		post do
			IO.inspect conn
			IO.inspect params
			text(conn, "okay")
		end
	end
end



