defmodule FinBot.Handlers.MsgSplitHandler do
	use GenEvent

	def init(_args) do
		IO.inspect "Msg Split Handler"
		{:ok, []}
	end

	def handle_event({:messages, message}, all_messages) do
		#split and send
		{:ok, [message|all_messages]}
	end

	def split(%{"entry": entries}) do
		entries
		|> Enum.flat_map(fn(%{"messaging": messaging}) -> messaging end)
		|> IO.inspect
	end
end
