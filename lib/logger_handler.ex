defmodule FinBot.Handlers.LoggerHandler do
	use GenEvent

	def init(_args) do
		IO.inspect "LoggerHandler started|"
		{:ok, []}
	end
	
	def handle_event(message, state) do
		IO.inspect(message)
		{:ok, state}
	end
	
end
