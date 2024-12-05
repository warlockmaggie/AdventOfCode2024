[Flags()] enum Directions {
    Up = 1
    Right = 2
    Down = 4
    Left = 8
}
# Up, UpRight, Right, RightDown, Down, DownLeft, Left, UpLeft
$eightDir = @(1,3,2,6,4,12,8,9)
$chars = @('X','M','A','S')

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
function findXmas($matrix, $xIndex, $yIndex)
{
    $successes = 0
    foreach($dir in $eightDir)
    {
        try {
        ($tempX, $tempY) = moveOneStep $xIndex $yIndex $dir
        foreach($c in $chars[1..3])
        {
            if(!(isinRange $tempX 0 $matrix.count-1) -or !(isInRange $tempY 0 $matrix.count))
            {
                throw "index too large ($tempX $tempY)"
                break
            }
            if($matrix[$tempX][$tempY] -ne $c)
            {
                throw "$tempX $tempY $c $([Directions]$dir)"
                break
            }
            else {
                ($tempX, $tempY) = moveOneStep $tempX $tempY $dir
            }
        }
        write-host "found XMAS at $xIndex $yIndex $([Directions]$dir)"
        $successes+=1
        }
        catch {
            continue
        }
    }
    return $successes
}
function scanMatrix($matrix)
{
    $hits = 0
    for($x = 0;$x -lt $matrix.Count; $x++)
    {
        for($y = 0;$y -lt $matrix.Count; $y++)
        {
            if($matrix[$x][$y] -eq $chars[0])
            {
                $hits += findXmas $matrix $x $y
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


