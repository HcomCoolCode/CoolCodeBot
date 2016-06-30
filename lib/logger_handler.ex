defmodule FinBot.Handlers.LoggerHandler do
	use GenEvent

	def init(_args) do
		IO.inspect "LoggerHandler started|"
		{:ok, []}
	end
	
	def handle_event({:messages, messages}, state) do
		IO.inspect(messages)
		{:ok, state}
	end
	
end
