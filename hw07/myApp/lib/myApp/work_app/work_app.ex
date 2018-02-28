defmodule MyApp.Work_app do
  @moduledoc """
  The Work_app context.
  """

  import Ecto.Query, warn: false
  alias MyApp.Repo

  alias MyApp.Work_app.Work

  @doc """
  Returns the list of works.

  ## Examples

      iex> list_works()
      [%Work{}, ...]

  """
  def list_works do
    Repo.all(Work)
    |> Repo.preload(:user)
  end

  @doc """
  Gets a single work.

  Raises `Ecto.NoResultsError` if the Work does not exist.

  ## Examples

      iex> get_work!(123)
      %Work{}

      iex> get_work!(456)
      ** (Ecto.NoResultsError)

  """
  def get_work!(id) do 
    Repo.get!(Work, id)
    |> Repo.preload(:user)
  end

  @doc """
  Creates a work.

  ## Examples

      iex> create_work(%{field: value})
      {:ok, %Work{}}

      iex> create_work(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_work(attrs \\ %{}) do
    %Work{}
    |> Work.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a work.

  ## Examples

      iex> update_work(work, %{field: new_value})
      {:ok, %Work{}}

      iex> update_work(work, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_work(%Work{} = work, attrs) do
    work
    |> Work.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Work.

  ## Examples

      iex> delete_work(work)
      {:ok, %Work{}}

      iex> delete_work(work)
      {:error, %Ecto.Changeset{}}

  """
  def delete_work(%Work{} = work) do
    Repo.delete(work)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking work changes.

  ## Examples

      iex> change_work(work)
      %Ecto.Changeset{source: %Work{}}

  """
  def change_work(%Work{} = work) do
    Work.changeset(work, %{})
  end


  alias MyApp.Work_app.Duration

  @doc """
  Returns the list of durations.

  ## Examples

      iex> list_durations()
      [%Duration{}, ...]

  """
  def list_durations do
    Repo.all(Duration)
  end

  @doc """
  Gets a single duration.

  Raises `Ecto.NoResultsError` if the Duration does not exist.

  ## Examples

      iex> get_duration!(123)
      %Duration{}

      iex> get_duration!(456)
      ** (Ecto.NoResultsError)

  """
  def get_duration!(id), do: Repo.get!(Duration, id)

  @doc """
  Creates a duration.

  ## Examples

      iex> create_duration(%{field: value})
      {:ok, %Duration{}}

      iex> create_duration(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_duration(attrs \\ %{}) do
    %Duration{}
    |> Duration.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a duration.

  ## Examples

      iex> update_duration(duration, %{field: new_value})
      {:ok, %Duration{}}

      iex> update_duration(duration, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_duration(%Duration{} = duration, attrs) do
    duration
    |> Duration.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Duration.

  ## Examples

      iex> delete_duration(duration)
      {:ok, %Duration{}}

      iex> delete_duration(duration)
      {:error, %Ecto.Changeset{}}

  """
  def delete_duration(%Duration{} = duration) do
    Repo.delete(duration)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking duration changes.

  ## Examples

      iex> change_duration(duration)
      %Ecto.Changeset{source: %Duration{}}

  """
  def change_duration(%Duration{} = duration) do
    Duration.changeset(duration, %{})
  end
end
