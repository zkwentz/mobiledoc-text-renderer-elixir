defmodule MobileDoc.Text.Renderer do

  def render(doc, cards \\ %{}, atoms \\ %{})

  def render(doc = %{ "version" => "0.3.0" }, cards, atoms) do
    MobileDoc.Text.Renderer_0_3.render(doc, cards, atoms)
  end

  def render(doc = %{ "version" => "0.3.1" }, cards, atoms) do
    MobileDoc.Text.Renderer_0_3.render(doc, cards, atoms)
  end

end
