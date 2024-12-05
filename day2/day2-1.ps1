enum ReportDirection {
    Negative = -1
    Zero = 0
    Positive = 1
}

$inputfile = Get-Content ./day2_input.txt
$linenum = 0
$goodreports = 0
foreach($line in $inputfile) 
{ 
    $reportBad = $false
    $Reportdirection = [ReportDirection]::Zero
    $reportline = $line -split '\s+'
    for($i = 0; $i -lt ($reportline.count-1); $i++)
    {
        $side1 = $reportline[$i]
        $side2 = $reportline[$i+1]
        $distance = $side2 - $side1
        $direction = [Math]::Sign($distance)

        if($Reportdirection -eq [ReportDirection]::Zero)
        {
            $Reportdirection = [ReportDirection]$direction
        }
        else
        {
            if($direction -ne $Reportdirection)
            {
                write-host "Line $linenum : Report bad for Direction change. was $($Reportdirection), now $($direction)"
                $reportBad = $true
                break
            }
        }

        if($distance -eq 0 -or [Math]::abs($distance) -gt 3)
        {
            write-host "Line $linenum : report bad for distance of $distance"
            $reportBad = $true
            break
        }
    }
    if(!$reportBad)
    {
        write-host "Line $linenum : GOOD"
        $goodreports++
    }
    $linenum++
}
$goodreports