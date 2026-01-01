let
    Source = _Source_Superstore,
    #"Grouped Rows" = Table.Group(Source, {"Product ID"}, {
        {"Product Name", each List.Max([Product Name]), type nullable text}, 
        {"Category", each List.Max([Category]), type nullable text}, 
        {"Sub-Category", each List.Max([#"Sub-Category"]), type nullable text}
    })
in
    #"Grouped Rows"