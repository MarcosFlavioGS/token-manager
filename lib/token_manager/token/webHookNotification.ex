defmodule TokenManager.Tokens.WebHookNotification do
  def send_notification({user_id, token_id}) do
    url = "https://webhook.site/9f57bd6f-5f87-4f63-a4d1-c7fe78c44ec0"
    headers = [{"Content-type", "Application/json"}]
    body = Jason.encode!(%{user_id: user_id, token_id: token_id})

    case HTTPoison.post(url, body, headers) do
      {:ok, %HTTPoison.Response{status_code: 200}} ->
        :ok

      {:ok, %HTTPoison.Response{status_code: 400}} ->
        {:error, "Bad request"}

      {:ok, %HTTPoison.Response{status_code: status_code}} ->
        {:error, {:http_error, status_code}}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end
