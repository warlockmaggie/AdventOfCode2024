$list1 = $list2 = New-Object System.Collections.Generic.List[Int]
$inputfile = Get-Content ./day1_input.txt
foreach($line in $inputfile) 
{ 
    $blah = $line -split '\s+'
    $list1 += [int]$blah[0]
    $list2 += [int]$blah[1]
}

$similarity = 0
foreach($val in $list1)
{
    $similarity += $val*($list2 | where {$_ -eq $val} | measure).Count
}
$similarity