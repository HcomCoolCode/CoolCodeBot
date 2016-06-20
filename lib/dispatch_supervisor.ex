defmodule FinBot.DispatchSupervisor do
	use Supervisor
	alias FinBot.Handlers.{LoggerHandler, StartHandlers}

	@manager :fb_msg_dispatch
	
	def start_link do
		Supervisor.start_link(__MODULE__, :ok)
	end

	#
	
	def init(:ok) do
		[
			worker(GenEvent, [[name: @manager]]),
			worker(StartHandlers, [[%{manager: @manager}]])
		]
		|> supervise(strategy: :one_for_one)
	end
end
