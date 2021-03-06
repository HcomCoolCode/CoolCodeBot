defmodule FinBot.Handlers.HelpHandler do
	use GenEvent
	alias FinBot.SendFb
	
	@help_text "I am glad to help, but presently all I can do is offer help"

	def init(state) do
		IO.inspect "Help Handler is ready to handle help"
		{:ok, state}
	end
	
	def handle_event({:message, message}, state) do
		%{id: senderId, text: msgText} = decompose(message)
		if wantsHelp?(msgText) do
			SendFb.post(senderId, @help_text)
		end
		{:ok, state}
	end

	def handle_event(_message, state) do
		{:ok, state}
	end

	def decompose(message) do
		%{"sender" =>
			%{"id" => senderId},
			"message" =>
			%{"text" => msgText}} = message
		%{id: senderId, text: msgText}
	end
	
	def wantsHelp?(text) do
		text =~ ~r<help|info|commands>i
	end
end
