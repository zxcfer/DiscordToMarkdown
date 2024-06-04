defmodule Discord2markdown do
  @moduledoc """
  Documentation for `Discord2markdown`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Discord2markdown.hello()
      :world

  """
  use Nostrum.Consumer

  alias DiscordBot.GitHelper

  def start_link do
    Consumer.start_link(__MODULE__)
  end

  def handle_event({:MESSAGE_CREATE, payload, _ws_state}) do
    case payload.content do
      "/post " <> content ->
        GitHelper.save_and_commit(content)

      _ ->
        :ignore
    end
  end
end
