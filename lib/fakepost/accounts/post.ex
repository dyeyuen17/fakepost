defmodule Fakepost.Accounts.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Fakepost.Accounts.Post
  alias Fakepost.Accounts.User
  alias Fakepost.Accounts.Comment

  schema "posts" do
    field :body, :string
    belongs_to :user, User
    has_many :comments, Comment


    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:body])
    |> validate_required([:body])
    |> assoc_constraint(:user)
  end
end
