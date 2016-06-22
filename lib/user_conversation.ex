defmodule FinBot.UserConversation do
	use GenServer

	def start_link(id) do
		GenServer.start_link(__MODULE__, id)
	end

	def message(pid, msg) do
		GenServer.call(pid, {:message, msg})
	end

	def all_messages(pid) do
		GenServer.call(pid, {:all_messages})
	end
	#

	def init(id) do
		{:ok, {id, []}}
	end

	def handle_call({:message, message}, _from, {id, messages}) do
		{:reply, :ok, {id, [ message | messages ]}}
	end

	def handle_call({:all_messages}, _from, {_id, messages} = state) do
		{:reply, messages, state}
	end
end
