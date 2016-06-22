defmodule FinBot.UserConversationTest do
	use ExUnit.Case
	alias FinBot.UserConversation

	test "create user conversation and send a message" do
		{:ok, user_one} = UserConversation.start_link("1")
		resp = UserConversation.message(user_one, "cool it down")
		assert :ok == resp
	end

	test "saves messages" do
		{:ok, user_two} = UserConversation.start_link("2")
		messages = ["I","am","Sam"]
		UserConversation.message(user_two, Enum.at(messages, 0))
		UserConversation.message(user_two, Enum.at(messages, 1))
		UserConversation.message(user_two, Enum.at(messages, 2))
		all_messages = UserConversation.all_messages(user_two)
		assert is_list(all_messages)
		assert all_messages == Enum.reverse(messages)
	end
end
