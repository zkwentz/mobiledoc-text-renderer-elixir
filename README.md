# [MobileDoc](https://github.com/bustlelabs/content-kit-editor/blob/master/MOBILEDOC.md) MobileDoc Text Renderer for Elixir


### (WIP)

Similarly to
[MobileDoc Text Renderer](https://github.com/bustlelabs/mobiledoc-text-renderer),
this a text renderer for the
[MobileDoc](https://github.com/bustlelabs/content-kit-editor/blob/master/MOBILEDOC.md)
format used by the [ContentKit](https://github.com/bustlelabs/content-kit-editor)
editor, written in [Elixir](http://elixir-lang.org/).

## Installation

First, add MobileDoc.Text.Renderer to your `mix.exs` dependencies:

```elixir
def deps do
  [{:mobiledoc_text, ">= 0.0.1"}]
end
```

Then, update your dependencies:

```sh-session
$ mix deps.get
```

## Usage

```elixir
mobiledoc = Poison.decode!(~s(
  {
    "version": "0.3.1",
    "sections": [
      [
        ["B"]
      ],
      [
        [1, "P", [
          [[0], 0, "hello world"]
        ]]
      ]
    ]
  }
))

rendered = MobileDoc.Text.Renderer.render(mobiledoc)
# renders hello world
```
