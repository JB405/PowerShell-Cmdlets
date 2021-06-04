Function Get-DayDate {      
<#
    .SYNOPSIS
        Returns the date for day occurrence 
    .DESCRIPTION
        This cmdlet returns the date for a given dayof the week and occurrence for a givin month and year
    .PARAMETER Occruance
        Specifies the occurrence of the day of week (First,Second,Thrid,Fourth or last), the default is Second
    .PARAMETER DayOfWeek
        Specifies DayOfWeek ( Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday )to find the date of default is Tuesday 
    .PARAMETER Month
        Specifies the month number to find the day of, default is the current month
    .PARAMETER Year
        Specifies the yeah of what month and day to return the date, default is current year
    .EXAMPLE
        PS> Get-DayDate Second Tuesday 
    .EXAMPLE
        PS> Get-DayDate -Occurrence Last -DayOfWeek Friday -Month 12 -Year 2021
    .EXAMPLE
        PS> (1..12) | %{ get-day -Occurrence Thrid -DayOfWeek Thursday -Month $_ -Year 2022 }
    .Link
        https://github.com/JB405/PowerShell-Cmdlets
    .Notes 
#>

    [CmdletBinding()]
    param (
        [validateset('First','Second','Thrid','Fourth','Last')]
        [Parameter(Position=0)][string]$Occurrence ='Second',
        [validateset('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday')]
        [Parameter(Position=1)][String]$DayOfWeek = 'Tuesday',
        [ValidateRange(0,12)]
        [Int]$Month =(Get-Date).Month,
        [ValidateRange(0001,9999)]
        [Int]$Year =(Get-Date).Year

    )       
        $Date = (Get-Date -Year $Year -Month $Month -Day 1)   
        # Find match DOW
        While($Date.DayOfWeek -ne $DayOfWeek) {$Date = $Date.AddDays(1)}
        Switch ($Occurrence) {
            'First'  { $Date             }
            'Second' { $Date.AddDays(7)  }
            'Thrid'  { $Date.AddDays(14) }
            'Fourth' { $Date.AddDays(21) }
            'Last'  {   
                while($Date.Month -eq $Month) {
                    if( $Date.Month -ne $Date.AddDays(7).Month ) {$Date}
                    $Date = $Date.AddDays(7)
                } #While
            } #Last
            Default { Write-Warning "Somthing is amiss in the universe" }
        } #Switch
}#function
