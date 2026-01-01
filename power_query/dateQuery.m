let
    // Parameters
    StartDate = #date(2013, 1, 1),
    EndDate   = #date(2030, 12, 31),

    // Create Date List
    DateList = List.Dates(
        StartDate,
        Duration.Days(EndDate - StartDate) + 1,
        #duration(1, 0, 0, 0)
    ),

    // Convert to Table
    DateTable = Table.FromList(
        DateList,
        Splitter.SplitByNothing(),
        {"Date"}
    ),

    // Set Date Column Type
    ChangeDateType = Table.TransformColumnTypes(
        DateTable,
        {{"Date", type date}}
    ),

    // Date Attributes
    AddYear        = Table.AddColumn(ChangeDateType, "Year", each Date.Year([Date]), Int64.Type),
    AddMonthNo     = Table.AddColumn(AddYear, "Month No", each Date.Month([Date]), Int64.Type),
    AddMonthName   = Table.AddColumn(AddMonthNo, "Month Name", each Date.MonthName([Date]), type text),
    AddMonthShort  = Table.AddColumn(AddMonthName, "Month Short", each Text.Start(Date.MonthName([Date]), 3), type text),
    AddQuarter     = Table.AddColumn(AddMonthShort, "Quarter", each "Q" & Text.From(Date.QuarterOfYear([Date])), type text),
    AddYearMonth   = Table.AddColumn(AddQuarter, "Year-Month", each Date.ToText([Date], "yyyy-MM"), type text),

    // Week & Day Attributes
    AddDayNo       = Table.AddColumn(AddYearMonth, "Day No", each Date.Day([Date]), Int64.Type),
    AddDayOfWeekNo = Table.AddColumn(AddDayNo, "Day Of Week No", each Date.DayOfWeek([Date], Day.Monday) + 1, Int64.Type),
    AddDayName     = Table.AddColumn(AddDayOfWeekNo, "Day Name", each Date.DayOfWeekName([Date]), type text),
    AddDayShort    = Table.AddColumn(AddDayName, "Day Short", each Text.Start(Date.DayOfWeekName([Date]), 3), type text),
    AddWeekNo      = Table.AddColumn(AddDayShort, "Week No", each Date.WeekOfYear([Date]), Int64.Type),

    // Flags
    AddIsWeekend     = Table.AddColumn(AddWeekNo, "Is Weekend", each if Date.DayOfWeek([Date], Day.Monday) >= 5 then 1 else 0, Int64.Type),
    AddIsToday       = Table.AddColumn(AddIsWeekend, "Is Today", each if [Date] = Date.From(DateTime.LocalNow()) then 1 else 0, Int64.Type),
    AddYearMonthSort = Table.AddColumn(AddIsToday, "YearMonthSort", each [Year] * 100 + [Month No], Int64.Type)

in
    AddYearMonthSort