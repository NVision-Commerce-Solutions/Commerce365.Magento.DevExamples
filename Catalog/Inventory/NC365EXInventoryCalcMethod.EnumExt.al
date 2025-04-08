enumextension 50201 "NC365EX Inventory Calc. Method" extends "NC365 Inventory Calc. Method"
{
    value(50200; "Custom Calculation")
    {
        Caption = 'Custom Inventory Calculation';
        Implementation = "NC365 Inventory Calc. Provider" = "NC365EX Inventory Calculation";
    }
}
