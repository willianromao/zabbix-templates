# Get-WmiObject -List | select name > C:\CLASSES.TXT
$dbs = Get-WmiObject Win32_PerfFormattedData_MSSQLRM_MSSQLRMDatabases | Select Name
$idx = 1
echo '{ "data":  ['

foreach ($perfdbs in $dbs)
{
    if ($idx -lt $dbs.Count)
    {
        $line= "{ `"{#DBS}`" : `"" +$perfdbs.Name + "`" },"
        echo $line
    }
    elseif ($idx -ge $dbs.Count)
    {
    $line= "{ `"{#DBS}`" : `"" + $perfdbs.Name + "`" }"
    echo $line
    }
    $idx++;
}

echo ']}'