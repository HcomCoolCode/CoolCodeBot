defmodule FinBot do
	use Application

	def start(_type, _args) do
		FinBot.DispatchSupervisor.start_link
	end
end
