defmodule MobileDoc.Text.Renderer_0_3 do

  def render(%{"sections" => sections, "atoms" => atom_types}, cards \\ %{}, atoms \\ %{}) do
    sections
    |> Enum.reduce("", fn (section, root) ->
      render_section(section, %{atom_types: atom_types, cards: cards, atoms: atoms})
    end)
  end

  # markup section type
  def render_section([1, _tagname, markers], meta) do
    render_markers(markers, meta)
  end

  # image section type
  def render_section([2, _], _meta) do
    ""
  end

  # list section type
  def render_section([3, _tagName, items], meta) do
    Enum.join(Enum.map(items, fn(item) ->
      render_markers(item, meta)
    end), "\n")
  end

  # card section type
  def render_section([10, _card_index], _meta) do
    ""
  end

  def render_markers(markers, meta) do
    Enum.reduce(markers, "", fn(marker, string) ->
      string <> render_marker(marker, meta)
    end)
  end

  # markup marker type
  def render_marker([0, _, _, text], _meta), do: text

  # atom marker type
  def render_marker([1, _, _, atom_id], meta) do
    atom_for_id(meta, atom_id)
    |> render_atom
	end

  def render_atom({atom, text, payload}) when not is_nil(atom) do
    Module.concat(atom, Text).render(text, {}, {}, payload)
  end

  def render_atom({nil, text, _payload}), do: text

  defp atom_for_id(meta, id) do
    case Enum.at(meta.atom_types, id) do
      [atom_name, text, payload] -> {Dict.get(meta.atoms, atom_name), text, payload}
      nil -> {nil, nil, nil}
    end
  end

end
