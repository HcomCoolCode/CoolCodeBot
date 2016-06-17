defmodule FinBot.API do
	use Maru.Router

	mount FinBot.Router.HealthCheck
	mount FinBot.Router.Messenger

	rescue_from :all do
		conn
		|> put_status(500)
		|> text("Server Error")
	end
end
