function Get-LifeNumber {
    param (
    [Parameter(Mandatory = $true)]   
    [System.DateOnly]$BirthDate 
    )
   $table = (
    @{number = 1; Type ='The Leader'; values = 'Leadership, independence'},
    @{number = 2; Type ='The Peacemaker'; values = 'Compassion, determination'},
    @{number = 3; Type ='The Creative'; values = 'Magnetism, extroversion, communication skills'},
    @{number = 4; Type ='The Manager'; values = ' Stability, logic, loyalty'},
    @{number = 5; Type ='The Adventurer'; values = ' Free-spirited, adaptability'},
    @{number = 6; Type ='The Nurturer'; values = 'Protective, selflessness'},
    @{number = 7; Type ='The Seeker'; values = 'Curiosity, thoroughness'},
    @{number = 8; Type ='The Powerhouse'; values = 'Realism, unity'},
    @{number = 9; Type ='The Humanitarian'; values = 'Integrity, acceptance'},
    @{number = 11; Type ='The Inspired Healer'; values = 'Spirituality, balance, positivity'},
    @{number = 22; Type ='The Master Teacher'; values = 'Organization, creativity, practicality'},
    @{number = 33; Type ='The Illuminated Guide'; values = 'Compassion, creativity, responsibility'}
   )

    function reduce {
        param (
            [string]$digits
        )
        if($digits -notin 11,22,33){
            while ($digits.Length -gt 1 ) {
                Write-Verbose "Reduce $($digits)" 
                $digits = ($digits.ToCharArray() | ForEach-Object { $_.ToString() } |Measure-Object -Sum).Sum.ToString()
            }
        }
        return $digits
    }
    $parts = ''
    Foreach ($part in ($BirthDate.day, $BirthDate.month,$birthdate.year)){
      $parts ="$($parts)$(reduce $part)" 
    }
    $lifenumber = reduce $parts
    $result = $table | Where-Object { $_.number -eq $lifenumber }

    return "Your Life Number is $lifenumber, which represents '$($result.Type)'. The key values associated with this number are: $($result.values)."
}


