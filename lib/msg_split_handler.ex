defmodule FinBot.Handlers.MsgSplitHandler do
	use GenEvent

	def init(%{manager: manager}) do
		IO.inspect "Msg Split Handler"
		{:ok, manager}
	end

	def handle_event({:messages, messages}, manager) do
		#split and send
		split(messages)
		|> Enum.each(&GenEvent.notify(manager, {:message, &1}))
		
		{:ok, manager}
	end
	
	def handle_event(_msg, manager) do
		{:ok, manager}
	end

	def split(%{"entry": entries}) do
		entries
		|> Enum.flat_map(fn(%{"messaging": messaging}) -> messaging end)
	end
end
