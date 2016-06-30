defmodule HelpHandlerTest do
	use ExUnit.Case
	alias FinBot.Handlers.HelpHandler

	test "responds to slash commands" do
		assert HelpHandler.wantsHelp?("/help")
		assert HelpHandler.wantsHelp?("help?")
	end

	test "breaks down messages from FB correctly" do
		%{id: id, text: text} = HelpHandler.decompose(%{"message" => %{"mid" => "mid.1467249611412:4d8959e3ff48c92416", "seq" => 9264, "text" => "super"}, "recipient" => %{"id" => "572617346244802"}, "sender" => %{"id" => "1344190288931480"}, "timestamp" => 1467249611419})
		assert id == "1344190288931480"
		assert text == "super"
	end
end
