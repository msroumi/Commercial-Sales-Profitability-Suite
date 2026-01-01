let
    Source = _Source_Superstore,
    // Merge to get LocationKey
    #"Merged Queries" = Table.NestedJoin(Source, {"Country", "State", "City", "Postal Code"}, Dim_Location, 
    {"Country", "State", "City", "Postal Code"}, "Dim_Location", JoinKind.LeftOuter),
    #"Expanded Dim_Location" = Table.ExpandTableColumn(#"Merged Queries", "Dim_Location", {"LocationKey"}, {"LocationKey"}),
    
    // Select only Fact columns and Keys
    #"Select Columns" = Table.SelectColumns(#"Expanded Dim_Location", {
        "Order ID", "Order Date", "Ship Date", "Ship Mode", 
        "Customer ID", "Product ID", "LocationKey", 
        "Sales", "Quantity", "Discount", "Profit"
    })
in
    #"Select Columns"