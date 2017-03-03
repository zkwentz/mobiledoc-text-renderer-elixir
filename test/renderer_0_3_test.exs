defmodule MobileDoc.Text.Renderer_0_3_Test do
  use ExUnit.Case
  import MobileDoc.Text.Renderer_0_3

  @mobiledoc_version_0_3 "0.3.0"
  @mobiledoc_version_0_3_1 "0.3.1"

  @markup_section_type 1
  @image_section_type 2
  @list_section_type 3
  @card_section_type 10

  @markup_marker_type 0
  @atom_marker_type 1


  test "renders an empty mobiledoc" do
    mobiledoc = %{
      "version" => @mobiledoc_version_0_3,
      "atoms" => [],
      "cards" => [],
      "markups" => [],
      "sections" => []
    }

    assert render(mobiledoc) == ""
  end

  test "renders a mobiledoc without markers" do
    mobiledoc = %{
      "version" => @mobiledoc_version_0_3,
      "atoms" => [],
      "cards" => [],
      "markups" => [],
      "sections" => [
        [@markup_section_type, "P", [
          [@markup_marker_type, [], 0, "hello world"]]
        ]
      ]
    }

    assert render(mobiledoc) == "hello world"
  end

  test "renders a mobiledoc 0.3.1 without markers with aside" do
    mobiledoc = %{
      "version" => @mobiledoc_version_0_3_1,
      "atoms" => [],
      "cards" => [],
      "markups" => [
        ["B"]
      ],
      "sections" => [
        [@markup_section_type, "P", [
          [@markup_marker_type, [0], 1, "hello world"]]
        ]
      ]
    }

    assert render(mobiledoc) == "hello world"
  end

  test "renders a mobiledoc with complex (has attributes) marker" do
    mobiledoc = %{
      "version" => @mobiledoc_version_0_3,
      "atoms" => [],
      "cards" => [],
      "markups" => [
        ["A", ["href", "http://google.com"]],
      ],
      "sections" => [
        [@markup_section_type, "P", [
          [@markup_marker_type, [0], 1, "hello world"]]
        ]
      ]
    }

    assert render(mobiledoc) == "hello world"
  end

  test "renders a mobiledoc with multiple markups in a section" do
    mobiledoc = %{
      "version" => @mobiledoc_version_0_3,
      "atoms" => [],
      "cards" => [],
      "markups" => [
        ["B"],
        ["I"]
      ],
      "sections" => [
        [@markup_section_type, "P", [
            [@markup_marker_type, [0], 1, "hello "], # b
            [@markup_marker_type, [0], 1, "brave "], # b+i
            [@markup_marker_type, [], 1, "new "],    # close i
            [@markup_marker_type, [], 1, "world"],   # close b
          ]
        ]
      ]
    }

    assert render(mobiledoc) == "hello brave new world"
  end

  test "renders a mobiledoc with image section" do
    mobiledoc = %{
      "version" => @mobiledoc_version_0_3,
      "atoms" => [],
      "cards" => [],
      "markups" => [],
      "sections" => [
        [@image_section_type, "imageUrl"]
      ]
    }

    assert render(mobiledoc) == ""
  end

  test "renders a mobiledoc with built-in image card (as empty string)" do
    mobiledoc = %{
      "version" => @mobiledoc_version_0_3,
      "atoms" => [],
      "cards" => [
        ["image-card", %{src: "bob.gif"}]
      ],
      "markups" => [],
      "sections" => [
        [@card_section_type, 0]
      ]
    }

    assert render(mobiledoc) == ""
  end

  test "renders mobiledoc with list section and list items" do
    mobiledoc = %{
      "version" => @mobiledoc_version_0_3,
      "atoms" => [],
      "cards" => [],
      "markups" => [],
      "sections" => [
        [@list_section_type, "ul", [
          [[@markup_marker_type, [], 0, "first item"]],
          [[@markup_marker_type, [], 0, "second item"]]
        ]]
      ]
    }

    assert render(mobiledoc) == Enum.join(["first item", "second item"], "\n")
  end

  test "renders a mobiledoc with an atom section" do
    defmodule HelloAtom do
      defmodule Text do
        def render(text, _options, _env, _payload) do
          "Hello #{text}"
        end
      end
    end

    mobiledoc = %{
      "version" => @mobiledoc_version,
      "atoms" => [
        ["hello-atom", "Bob", %{ "id" => 42}]
      ],
      "cards" => [],
      "markups" => [],
      "sections" => [
        [@markup_section_type, "P", [
          [@atom_marker_type, [], 0, 0]]
        ]
      ]
    }

    rendered = render(mobiledoc, %{}, %{
      "hello-atom" => HelloAtom
    })

    assert rendered == "Hello Bob"
  end
end
