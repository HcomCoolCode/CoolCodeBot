defmodule FinBot.DispatchSupervisor do
	use Supervisor
	
	def start_link do
		Supervisor.start_link(__MODULE__, :ok)
	end

	def init(:ok) do
		[
			worker(GenEvent, [[name: :fb_msg_dispatch]])
		]
		|> supervise(strategy: :one_for_one)
	end
end
