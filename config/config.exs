use Mix.Config

config :distillerydb,
  git_repo_path: "/opt/git-repo"

# lib/discord_bot.ex
defmodule DiscordBot do
  use Nostrum.Consumer
  alias Nostrum.Api

  @git_repo_path Application.get_env(:distillerydb, :git_repo_path)

  def start_link do
    Consumer.start_link(__MODULE__)
  end

  def handle_event({:MESSAGE_CREATE, payload, _ws_state}) do
    case payload.content do
      "/post " <> content ->
        save_to_file(content)
        commit_and_push()

      _ ->
        :ignore
    end
  end

  defp save_to_file(content) do
    filename = "#{:os.system_time(:millisecond)}.txt"
    file_path = Path.join(@git_repo_path, filename)
    File.write!(file_path, content)
  end

  defp commit_and_push do
    # Initialize Git repository if not already initialized
    unless File.exists?(Path.join(@git_repo_path, ".git")) do
      Git.init!(@git_repo_path)
    end

    Git.add!(@git_repo_path, "--all")
    Git.commit!(@git_repo_path, "-m 'Commit from Discord bot'")
    Git.push!(@git_repo_path)
  end
end
