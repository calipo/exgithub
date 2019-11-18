defmodule ExGitHub.Services.GiraService do
  alias ExGitHub.Services.GiraServiceProvider

  require Logger

  @behaviour GiraServiceProvider

  @base_url System.get_env("JIRA_BASE_URL")
  @authorization_token System.get_env("JIRA_AUTH_TOKEN")

  @doc """
    Opens a new jira issue with customized information parsed from GitHub request

    Returns '%{}'

    ## Examples:

  """
  @impl GiraServiceProvider
  def create(req) do
    {:ok, client} = Gira.new(@base_url, @authorization_token)
    {_, response} = Gira.create_issue_with_basic_info(client, req)
    response
  end

  @doc """
  Closes an jira issue associated with a `jira_id`

  Returns '%{}'

  ## Examples:

  """
  @impl GiraServiceProvider
  def close(jira_id) do
    {:ok, client} = Gira.new(@base_url, @authorization_token)
    {:ok, response} = Gira.close_issue(client, %{jira_id: jira_id, transition_id: "31"})
    response
  end

  @doc """
  Searches for issues within a customized `filter`

  Returns '%{}'

  ## Examples:

  """
  @impl GiraServiceProvider
  def get(filter) do
    {:ok, client} = Gira.new(@base_url, @authorization_token)
    Gira.get_issue_basic_info_by_query(client, filter)
    |> IO.inspect
    Logger.info("returning jira search response")
    %{status: 500, payload: "error"}
  end
end
