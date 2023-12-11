defmodule IDENTICON do
  defp create_svg(grid_data, id) do
    svg_content = """
    <svg width="300" height="300" xmlns="http://www.w3.org/2000/svg">
      #{generate_grid(grid_data)}
    </svg>
    """

    File.write!("tmp/#{id}_#{System.os_time(:second)}.svg", svg_content)
  end

  @spec generate_grid(list()) :: String.t()
  defp generate_grid(grid_data) do
    Enum.reduce(grid_data, {0, ""}, fn value, {acc, svg} ->
      {acc + 1,
       svg <>
         case rem(value, 2) do
           0 -> "<rect width=\"100\" height=\"100\" x=\"#{rem(acc, 3) * 100}\" y=\"#{div(acc, 3) * 100}\" fill=\"black\" />"
           1 -> "<rect width=\"100\" height=\"100\" x=\"#{rem(acc, 3) * 100}\" y=\"#{div(acc, 3) * 100}\" fill=\"white\" />"
         end
      }
    end)
    |> elem(1)
  end

  @spec gen_i_o(binary()) :: list()
  def gen_i_o(string) do
    split_string = string |> String.graphemes()

    Enum.map(split_string, &String.to_integer/1)
  end

  def create do
    id = IO.gets("\n Please input user ID \n") |> String.trim()

    case String.length(id) === 9 do
      true ->
        grid_data = gen_i_o(id)
        create_svg(grid_data, id)

      false ->
        {:error, "invalid ID"}
    end
  end
end
