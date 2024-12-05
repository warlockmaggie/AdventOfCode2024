$found = select-string -PSPath ./day3_input.txt -Pattern '(mul\(\d+,\d+\))' -AllMatches 
$sum = 0
foreach($match in $found.Matches.Value) 
{
    $nums = $match.split('(')[1].split(')')[0].split(',')
    $sum += ([int]$nums[0] * [int]$nums[1])
}
$sum
