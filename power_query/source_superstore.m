let
    Source = Csv.Document(File.Contents("D:\Muntasir Abu Roumi\Power BI\Commercial Sales Performance & Profitability Dashboard\Superstore.csv"),
    [Delimiter=",", Columns=21, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"Row ID", Int64.Type}, {"Order ID", type text}, 
    {"Order Date", type date}, {"Ship Date", type date}, {"Ship Mode", type text}, {"Customer ID", type text}, 
    {"Customer Name", type text}, {"Segment", type text}, {"Country", type text}, {"City", type text}, {"State", type text}, 
    {"Postal Code", Int64.Type}, {"Region", type text}, {"Product ID", type text}, {"Category", type text}, {"Sub-Category", type text}, 
    {"Product Name", type text}, {"Sales", type number}, {"Quantity", Int64.Type}, {"Discount", type number}, {"Profit", type number}})
in
    #"Changed Type"