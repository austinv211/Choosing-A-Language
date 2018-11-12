<#
NAME: PowerShellDemos.ps1
AUTHOR: Austin Vargason
#>


#selection sort function
function Sort-WithSelectionSort() {
    
    param (
        [Parameter(Mandatory=$true)]
        [int[]]$array
    )


    for ( $i = 0; $i -lt $array.Length - 1; $i++) {
        $min = $array[$i]
        $minIndex = $i

        for ( $j = $i + 1; $j -lt $array.Length; $j++) {
            if ($min -gt $array[$j]) {
                $min = $array[$j]
                $minIndex = $j
            }
        }

        if ($i -ne $minIndex) {
            $temp = $array[$i]
            $array[$i] = $array[$minIndex]
            $array[$minIndex] = $temp
        }
    }

    return $array
}

#Section to run selection sort
$testList = @( 13, 21, 1, 4, 90, 123, 18, 2, 6, 5 );

$testList = Sort-WithSelectionSort($testList)

$testList

#measure the performance of the selection sort
Measure-Command -Expression {Sort-WithSelectionSort($testList)}

#for large list
$largeTestList = Get-Content -Path "..\largeListOfNumbers.txt"

$largeTestList = Sort-WithSelectionSort($largeTestList)

$largeTestList

#measure the performance of the selection sort
Measure-Command -Expression {Sort-WithSelectionSort($largeTestList)}


#things that powershell is good for
#less code to write, easy to get things done, especially with IT tasks, sending code remotely, working with DSC, working with O365.

#Powershell is the general IT personell's magic toolbox.

#Because of the speed it lacks in performing certain tasks, I think powershell is at its best when combined with C#, C# can do the heavy lifting and powershell can be the technical wizard easily performing IT tasks.

#Some examples of easy IT tasks competed with powershell

#stopping a service

Get-Service -Name COSDLanSwitchService | Stop-Service

#sending code to a remote computer

Invoke-Command -ComputerName "HPS8883-W7" -ScriptBlock {Get-ChildItem "C:\Users"}

#with an example of some really cool stuff

#enter a search term and find a wikipedia article on it and return as html

$searchTerm = Read-Host -Prompt "Enter a search term"
Invoke-WebRequest -Uri "https://en.wikipedia.org/wiki/$searchTerm"

#get a list of all computers in AD that have logged on recently
$time = (Get-Date).AddDays(-90)

Get-ADComputer -Filter {LastLogonTimeStamp -lt $time} -Properties LastLogonTimeStamp

#things that help make powershell even easier

#the help system

#get help provides a super detailed help system that can even redirect you to the microsoft article online
get-help "get-service" -Online

#the pipeline allows you to pipe results from one command into another

#aliasing allows you to type powershell in the format you are used to
Get-Alias
