defmodule FinBot.Handlers.SumHandler do
	use GenEvent
	alias FinBot.SendFb

	@reply_text "I am ready to add numbers for you"
	@enter_first_number_text "Please enter first number"
	@enter_second_number_text "Please enter second number"
	@result_text "The sum is 10"

	def init(_args) do
		IO.inspect "Math Handler is ready to handle sums"
		{:ok, {:nothing, []}}
	end

	def handle_event({:message, message}, {:need_first_number, []}) do
		%{id: senderId, text: msgText} = decompose(message)
		if enter_first_number?(msgText) do
			SendFb.post(senderId, @enter_second_number_text)
			end

			{:ok, {:need_second_number, [msgText]}}
	end

	def handle_event({:message, message}, {:need_second_number, [first_number]}) do
		%{id: senderId, text: msgText} = decompose(message)
		if enter_second_number?(msgText) do
			SendFb.post(senderId, first_number+msgText)
			end

			{:ok, {:nothing, []}}
	end

	def handle_event({:message, message}, state) do
		%{id: senderId, text: msgText} = decompose(message)
		if want_to_add_numbers?(msgText) do
			SendFb.post(senderId, @reply_text)
			SendFb.post(senderId, @enter_first_number_text)
		end

		{:ok, {:need_first_number, []}}
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

	def want_to_add_numbers?(text) do
		text =~ ~r<add|sum>i
	end

	def enter_first_number?(number1)do
		is_integer(number1)
	end

	def enter_second_number?(number2)do
		is_integer(number2)
	end
end
