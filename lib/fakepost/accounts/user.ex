defmodule Fakepost.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Fakepost.Accounts.User
  alias Fakepost.Accounts.Post
  alias Fakepost.Accounts.Comment


  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string
    has_many :posts, Post
    has_many :comments, Comment

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :name, :password])
    |> validate_required([:email, :name, :password])
    |> validate_format(:email, ~r/\S+@\S+\.\S{1,4}+/)
    |> password_hash()
  end

  def password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end

end
