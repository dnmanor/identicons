defmodule IDENTICONTest do
  use ExUnit.Case
  doctest IDENTICON

  test "test i_o" do
    assert IDENTICON.gen_i_o("876793874") == [0, 1, 0, 1, 1, 1, 0, 1, 0]
  end
end
