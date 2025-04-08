codeunit 50202 "NC365EX Inventory Calculation" implements "NC365 Inventory Calc. Provider"
{
    procedure Calculate(LocationCode: Code[10]; ItemNo: Code[20]; VariantCode: Code[10]): Decimal
    var
        Item: Record Item;
        NC365Item: Record "NC365 Item";
        NC365ItemVariant: Record "NC365 Item Variant";
        Inventory: Decimal;
    begin
        if not NC365Item.Get(ItemNo, 'GLOBAL') then
            exit;

        if VariantCode <> '' then begin
            NC365ItemVariant.SetRange("Item No.", ItemNo);
            NC365ItemVariant.SetRange("Code", VariantCode);
            if NC365ItemVariant.IsEmpty() then
                exit;
        end;

        if not Item.Get(ItemNo) then
            exit;

        if LocationCode <> '' then
            Item.SetFilter("Location Filter", LocationCode);

        if VariantCode <> '' then
            Item.SetFilter("Variant Filter", VariantCode);

        Item.CalcFields(Inventory, "Qty. on Sales Order");
        Inventory := Item.Inventory - Item."Qty. on Sales Order";

        if NC365Item."Qty Uses Decimals" then
            exit(Inventory)
        else
            exit(Round(Inventory, 1, '<'));
    end;

}
