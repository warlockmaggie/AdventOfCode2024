[Flags()] enum Directions {
    Up = 1
    Right = 2
    Down = 4
    Left = 8
}
# Up, UpRight, Right, RightDown, Down, DownLeft, Left, UpLeft
$twoDir = @(3,9)

function moveOneStep($x,$y,[Directions]$direction)
{
    $xAdd = $yAdd = 0
    if($direction.hasFlag([Directions]::Right))
    {
        $yAdd = 1
    }
    elseif ($direction.HasFlag([Directions]::Left)) {
        $yAdd = -1
    }
    if($direction.hasFlag([Directions]::Up))
    {
        $xAdd = -1
    }
    elseif ($direction.HasFlag([Directions]::Down)) {
        $xAdd = 1
    }
    $x += $xAdd
    $y += $yAdd
    return ($x, $y)
}

function isInRange($n, $min, $max)
{
    return ($n -ge $min -and $n -le $max)
}

function checkCorner($matrix, $x,$y,$dir,$char)
{
    ($tempX, $tempY) = moveOneStep $x $y $dir
    if(!(isinRange $tempX 0 $matrix.count-1) -or !(isInRange $tempY 0 $matrix.count))
    {
            return $false
    }
    switch($char)
    {
        
        'M' {
            if($matrix[$tempX][$tempY] -eq "S")
            {
                return $true
            }
            break
        }
        'S' {
            if($matrix[$tempX][$tempY] -eq "M")
            {
                return $true
            }
            break
        }
    }
    return $false
}
function findMasX($matrix, $xIndex, $yIndex)
{
    $success = $true
    foreach($dir in $twoDir)
    {
        if($success)
        {
            try {
                ($tempX, $tempY) = moveOneStep $xIndex $yIndex $dir
                if(!(isinRange $tempX 0 $matrix.count-1) -or !(isInRange $tempY 0 $matrix.count))
                {
                        $success = $false
                        throw "index too large ($tempX $tempY)"
                }
                if($matrix[$tempX][$tempY] -match '[MS]')
                {
                    $dir = [Directions](15-$dir)
                    if(checkCorner $matrix $xIndex $yIndex $dir $Matches[0])
                    {
                        
                        $success = $true
                    }
                    else {
                        $success = $false
                    }
                }
                else{
                    $success = $false
                }     
            }
            catch {
                $success = $false
                continue
            }
        }
    }
    if($success)
    {
        write-host "$xIndex $yIndex $($Matches[0]) $([Directions]$dir)"
        return 1
    }
    return 0
}
function scanMatrix($matrix)
{
    $hits = 0
    for($x = 0;$x -lt $matrix.Count; $x++)
    {
        for($y = 0;$y -lt $matrix.Count; $y++)
        {
            if($matrix[$x][$y] -eq "A")
            {
                $hits += findMasX $matrix $x $y
            }
        }
    }
    return $hits
}


$inputfile = Get-Content ./day4_input.txt
$matrix = [System.Collections.ArrayList]::new()

foreach($line in $inputfile)
{
    $matrix.Add([System.Collections.ArrayList]::new(($line -split '' | where {$_.length -gt 0}))) | out-null
}
scanMatrix $matrix