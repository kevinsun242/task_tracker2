defmodule TaskTrackerWeb.TimeblockView do
  use TaskTrackerWeb, :view
  alias TaskTrackerWeb.TimeblockView

  def render("index.json", %{time: time}) do
    %{data: render_many(time, TimeblockView, "timeblock.json")}
  end

  def render("show.json", %{timeblock: timeblock}) do
    %{data: render_one(timeblock, TimeblockView, "timeblock.json")}
  end

  def render("timeblock.json", %{timeblock: timeblock}) do
    %{id: timeblock.id,
      start: timeblock.start,
      end: timeblock.end}
  end
end
