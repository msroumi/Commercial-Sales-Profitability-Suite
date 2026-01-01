let
    Source = _Source_Superstore,
    #"Removed Other Columns" = Table.SelectColumns(Source,{"Country", "City", "State", "Postal Code", "Region"}),
    #"Removed Duplicates" = Table.Distinct(#"Removed Other Columns"),
    #"Sorted Rows" = Table.Sort(#"Removed Duplicates",{{"Country", Order.Ascending}, {"State", Order.Ascending}, 
    {"City", Order.Ascending}}),
    #"Added Index" = Table.AddIndexColumn(#"Sorted Rows", "LocationKey", 1, 1, Int64.Type)
in
    #"Added Index"