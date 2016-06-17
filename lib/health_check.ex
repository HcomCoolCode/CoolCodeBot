defmodule FinBot.Router.HealthCheck do
	use Maru.Router

	get do
		json(conn, %{status: :ok})
	end
end
