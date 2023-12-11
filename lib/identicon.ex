defmodule IDENTICON do
  @spec gen_i_o(binary()) :: list()
  def gen_i_o(string) do
    split_string = string |> String.graphemes()

    Enum.map(split_string, fn x ->
      case rem(String.to_integer(x), 2) === 0 do
        true ->
          0

        false ->
          1
      end
    end)
  end

  def create do
    id = IO.gets("\n Please input user ID \n") |> String.trim()

    case String.length(id) === 9 do
      true ->
        gen_i_o(id)

      false ->
        {:error, "invalid ID"}
    end
  end
end
