defmodule FinBot.Handlers.MyFirstHandler do
	use GenEvent
	alias FinBot.SendFb
	
	@help_text "funny isn't it"
	@help_negative_text "ohh i am so sorry"

	def init(state) do
		IO.inspect "Fun Handler is ready to handle help"
		{:ok, state}
	end
	
	def handle_event({:message, message}, state) do
		%{id: senderId, text: msgText} = decompose(message)
		if wantsFun?(msgText) do
			SendFb.post(senderId, @help_text)
		end

if isSad?(msgText) do
			SendFb.post(senderId, @help_negative_text)
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
	
	def wantsFun?(text) do
		text =~ ~r<fun>i
	end

	def isSad?(text) do
		text =~ ~r<sad>i
	end

end
