$list1 = $list2 = New-Object System.Collections.Generic.List[Int]
$inputfile = Get-Content ./day1_input.txt
foreach($line in $inputfile) 
{ 
    $blah = $line -split '\s+'
    $list1 += [int]$blah[0]
    $list2 += [int]$blah[1]
}

$list1 = $list1 | Sort-Object
$list2 = $list2 | Sort-Object
$sum = 0
for($i = 0; $i -lt $list1.count; $i++)
{
    $sum += [System.Math]::Abs(($list1.Item($i) - $list2.Item($i)))
}
$sum
