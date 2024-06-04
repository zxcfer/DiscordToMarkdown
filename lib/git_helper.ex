defmodule DiscordBot.GitHelper do
  @git_repo_path Application.get_env(:distillerydb, :git_repo_path)

  def save_and_commit(content) do
    save_to_file(content)
    commit_and_push()
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
