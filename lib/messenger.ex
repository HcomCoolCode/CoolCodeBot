defmodule FinBot.Router.Messenger do
	use Maru.Router

	namespace :messenger do

		desc "handles requests from FB Messenger"
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
	end
end
