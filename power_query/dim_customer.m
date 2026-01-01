let
    Source = _Source_Superstore,
    #"Removed Other Columns" = Table.SelectColumns(Source,{"Customer ID", "Customer Name", "Segment"}),
    #"Removed Duplicates" = Table.Distinct(#"Removed Other Columns", {"Customer ID"})
in
    #"Removed Duplicates"