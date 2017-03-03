defmodule MobileDoc.Text.RendererTest do
  use ExUnit.Case
  import MobileDoc.Text.Renderer

  test "renders a v0.3.0 mobiledoc as text" do
    mobiledoc = %{
      "version" => "0.3.0",
      "atoms" => [],
      "cards" => [],
      "markups" => [],
      "sections" => [
        [1, "P", [
          [0, [], 0, "hello world"]]
        ]
      ]
    }

    assert render(mobiledoc) == "hello world"
  end

  test "renders a v0.3.1 mobiledoc as text" do
    mobiledoc = %{
      "version" => "0.3.1",
      "atoms" => [],
      "cards" => [],
      "markups" => [],
      "sections" => [
        [1, "P", [
          [0, [], 0, "hello world"]]
        ]
      ]
    }

    assert render(mobiledoc) == "hello world"
  end
end
