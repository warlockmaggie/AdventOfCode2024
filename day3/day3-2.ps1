$found = select-string -PSPath ./day3_input.txt -Pattern '(mul)\((\d+),(\d+)\)|(do(?:n''t)?)\(\)' -AllMatches 
$sum = 0
$do = $true
foreach($match in $found.Matches) 
{
    if($match.Groups[4].Value -eq 'do')
    {
        $do = $true
    }
    if($match.Groups[4].Value -eq 'don''t')
    {
        $do = $false
    }
    if($do -and $match.Groups[1].Value -eq 'mul')
    {
        $sum += ([int]$match.Groups[2].Value * [int]$match.Groups[3].Value)
    }    
}
$sum