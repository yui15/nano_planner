import NanoPlanner.Repo
alias NanoPlanner.Schedule.PlanItem

now = 
  "Asia/Tokyo"
  |> DateTime.now!()
  |> DateTime.truncate(:second)

time0 =
  now
  |> Timex.beginning_of_day()
  |> DateTime.shift_zone!("Etc/UTC")

time1 =
  now
  |> Timex.beginning_of_year()
  |> DateTime.shift_zone!("Etc/UTC")

insert!(%PlanItem{
  name: "読書",
  description: "『走れメロス』を読む",
  starts_at: Timex.shift(time0, days: 1, hours: 10),
  ends_at: Timex.shift(time0, days: 1, hours: 11)
})

insert!(%PlanItem{
  name: "買い物",
  description: "洗剤を買う",
  starts_at: Timex.shift(time0, hours: 16),
  ends_at: Timex.shift(time0, hours: 16, minutes: 30)
})

insert!(%PlanItem{
  name: "帰省",
  description: "新幹線の指定席を取る。\nお土産を買う。",
  starts_at: Timex.shift(time1, years: 1, days: -2),
  ends_at: Timex.shift(time1, years: 1, days: 3)
})

insert!(%PlanItem{
  name: "買い物",
  description: "猫の餌を買う",
  starts_at: Timex.shift(time0, days: 3, hours: 11),
  ends_at: Timex.shift(time0, days: 3, hours: 11, minutes: 30)
})

insert!(%PlanItem{
  name: "歯医者",
  description: "",
  starts_at: Timex.shift(time0, days: 10, hours: 15),
  ends_at: Timex.shift(time0, days: 10, hours: 16)
})
