codeunit 50200 "NC365EX Vendor Name" implements "NC365 Predefined Mapping V2"
{
    procedure GetMappedTableNo(): Integer
    begin
        exit(Database::"Vendor");
    end;

    procedure GetMappedFieldNo(): Integer
    begin
        exit(2);
    end;

    procedure GetDescription(): Text[250]
    begin
        exit('Maps to the ''Name'' field of the ''Vendor'' table in the Microsoft Base Application extension.');
    end;

    procedure GetAllowedDataTypes(): List of [Enum "NC365 Attribute Data Type"]
    var
        AllowedDataTypes: List of [Enum "NC365 Attribute Data Type"];
    begin
        AllowedDataTypes.Add(Enum::"NC365 Attribute Data Type"::"Text");
        AllowedDataTypes.Add(Enum::"NC365 Attribute Data Type"::Dropdown);
        exit(AllowedDataTypes);
    end;

    procedure GetAvailableParameterCodes(): Dictionary of [Code[50], Boolean]
    begin
    end;

    procedure GetValue(ItemNo: Code[20]; VariantCode: Code[20]; Parameters: Dictionary of [Code[50], Text]): Variant
    var
        Item: Record Item;
        Vendor: Record Vendor;
    begin
        if not Item.Get(ItemNo) then
            exit;

        if not Vendor.Get(Item."Vendor No.") then
            exit;

        exit(Vendor.Name);
    end;
}
