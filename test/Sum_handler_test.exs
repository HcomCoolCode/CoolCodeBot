defmodule SumHandlerTest do
	use ExUnit.Case
	alias FinBot.Handlers.SumHandler

	test "responds to slash commands" do
		assert SumHandler.want_to_add_numbers?("add")
		assert SumHandler.want_to_add_numbers?("sum")
    assert SumHandler.enter_first_number?(1)
    assert SumHandler.enter_second_number?(2)
	end

	test "breaks down messages from FB correctly" do
		%{id: id, text: text} = SumHandler.decompose(%{"message" => %{"mid" => "mid.1467249611412:4d8959e3ff48c92416", "seq" => 9264, "text" => "super"}, "recipient" => %{"id" => "572617346244802"}, "sender" => %{"id" => "1344190288931480"}, "timestamp" => 1467249611419})
		assert id == "1344190288931480"
		assert text == "super"
	end
end
