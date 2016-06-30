defmodule HelpHandlerTest do
	use ExUnit.Case
	alias FinBot.Handlers.HelpHandler

	test "responds to slash commands" do
		assert HelpHandler.wantsHelp?("/help")
		assert HelpHandler.wantsHelp?("help?")
	end
	
end
