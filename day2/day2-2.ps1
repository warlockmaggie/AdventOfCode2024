enum ReportDirection {
    Negative = -1
    Zero = 0
    Positive = 1
}

function isSafe($report)
{
    $reportSafe = $true
    $Reportdirection = [ReportDirection]::Zero
    for($i = 0; $i -lt ($report.count-1); $i++)
    {
        $side1 = $report[$i]
        $side2 = $report[$i+1]
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
                #write-host "Line $linenum : Report bad for Direction change. was $($Reportdirection), now $($direction)"
                $reportSafe = $false
                break
            }
        }

        if($distance -eq 0 -or [Math]::abs($distance) -gt 3)
        {
            #write-host "Line $linenum : report bad for distance of $distance"
            $reportSafe = $false
            break
        }
    }
    return $reportSafe
}

$inputfile = Get-Content ./day2_input.txt
$linenum = 0
$goodreports = 0
foreach($line in $inputfile) 
{ 
    $reportSafe = $true
    $reportline = [System.Collections.ArrayList]::new(@($line -split '\s+'))
    $reportSafe = isSafe $reportline
    if(!$reportSafe)
    {
        $subreportSafe = $true
        $badcount = 0
        for($j = 0; $j -lt $reportline.count; $j++)
        {
            $newreport = [System.Collections.ArrayList]::new($reportline)
            $newreport.RemoveAt($j)
            $subreportSafe = isSafe $newreport
            if(!$subreportSafe)
            {
                continue
            }
            else {
                write-host "Safe if level $j is removed [$reportline] > [$newreport]"
                $reportSafe = $true
            }
        }

    }
    if($reportSafe)
    {
        $goodreports++
    }
    write-host "Line $linenum : $($reportSafe)"
    $linenum++
}
$goodreports