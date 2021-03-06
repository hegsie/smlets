
function Get-ParentEnum
{
    param ( $enum )
    if ( ! $enum ) { return }
    write-host -for blue $enum
    if ( $enum -is [string] ) { $enum = get-scsmEnumeration "^${enum}$" }
    if ( $enum -is [guid] )   { $enum = Get-SCSMEnumeration -id $enum }
    if ( $enum.Parent )
    {
    write-host -for red $enum.parent.id
        get-ParentEnum $enum.Parent.Id
    }
    get-scsmchildEnumeration -Enumeration $enum|sort -uniq Name
}

function Get-EnumList
{
    param ( $e )
    Get-ParentEnum $e |sort -uniq Name|sort Ordinal
}

Get-EnumList ProblemStatusEnum
