defmodule Fakepost.Accounts.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  alias Fakepost.Accounts.Comment
  alias Fakepost.Accounts.Post
  alias Fakepost.Accounts.User


  schema "comments" do
    field :content, :string
    belongs_to :user, User
    belongs_to :post, Post

    timestamps()
  end

  @doc false
  def changeset(%Comment{} = comment, attrs) do
    comment
    |> cast(attrs, [:content])
    |> validate_required([:content])
  end
end
