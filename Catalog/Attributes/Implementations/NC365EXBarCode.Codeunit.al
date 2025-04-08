codeunit 50201 "NC365EX Bar Code" implements "NC365 Predefined Mapping V2"
{
    procedure GetMappedTableNo(): Integer
    begin
        exit(Database::"Item Reference");
    end;

    procedure GetMappedFieldNo(): Integer
    begin
        exit(6);
    end;

    procedure GetDescription(): Text[250]
    begin
        exit('Maps to the ''Reference No.'' field for ''Reference Type'' ''Bar Code'' in the ''Item Reference'' table in the Microsoft Base Application extension.');
    end;

    procedure GetAllowedDataTypes(): List of [Enum "NC365 Attribute Data Type"]
    var
        AllowedDataTypes: List of [Enum "NC365 Attribute Data Type"];
    begin
        AllowedDataTypes.Add(Enum::"NC365 Attribute Data Type"::Text);
        exit(AllowedDataTypes);
    end;

    procedure GetAvailableParameterCodes(): Dictionary of [Code[50], Boolean]
    var
        Parameters: Dictionary of [Code[50], Boolean];
    begin
        Parameters.Add(UoMCodeParameterKeyTok, false);
        exit(Parameters);
    end;

    procedure GetValue(ItemNo: Code[20]; VariantCode: Code[20]; Parameters: Dictionary of [Code[50], Text]): Variant
    var
        ItemReference: Record "Item Reference";
        UnitofMeasureCode: Text;
    begin
        if Parameters.ContainsKey(UoMCodeParameterKeyTok) then
            UnitofMeasureCode := Parameters.Get(UoMCodeParameterKeyTok);

        ItemReference.SetRange("Item No.", ItemNo);
        ItemReference.SetRange("Reference Type", ItemReference."Reference Type"::"Bar Code");

        if VariantCode = '' then
            ItemReference.SetFilter("Variant Code", '%1', '')
        else
            ItemReference.SetRange("Variant Code", VariantCode);

        if UnitofMeasureCode = '' then
            ItemReference.SetFilter("Unit of Measure", '%1', '')
        else
            ItemReference.SetRange("Unit of Measure", UnitofMeasureCode);

        if ItemReference.FindFirst() then
            exit(ItemReference."Reference No.");
    end;

    var
        UoMCodeParameterKeyTok: Label 'UNIT OF MEASURE CODE', Locked = true;
}