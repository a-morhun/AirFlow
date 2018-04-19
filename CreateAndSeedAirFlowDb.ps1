$sqlCompactDbPath = (Get-Location).Path + "\AirFlow\App_Data\AirFlowDb.sdf"
if (Test-Path $sqlCompactDbPath) 
{
    exit
}

$binpath = "C:\Program Files\Microsoft SQL Server Compact Edition\v4.0\Desktop\";
[Reflection.Assembly]::LoadFile("$binpath\System.Data.SqlServerCe.dll") | Out-Null
$connectionString = "Data Source='$sqlCompactDbPath';"

$engine = New-Object "System.Data.SqlServerCe.SqlCeEngine" $connectionString
$engine.CreateDatabase();
$engine.Dispose();

$seedScript = [IO.File]::ReadAllText("$scriptLocation\AirFlow.Db\Seed\Seed.sql")
$seedScriptBatched = $seedScript -split "GO\r\n"

$connection = New-Object "System.Data.SqlServerCe.SqlCeConnection" $connectionString

$command = New-Object "System.Data.SqlServerCe.SqlCeCommand"
$command.CommandType = [System.Data.CommandType]"Text"
$command.Connection = $connection

$shouldDropDb = $false;
Try
{
    $connection.Open()

    foreach($batch in $seedScriptBatched)
    {
        if ($batch.Trim() -ne "")
        {
            $command.CommandText = $batch
            $command.ExecuteNonQuery() | Out-Null
        }
    }

    Write-Output("DB successdully created")
}
Catch
{
    Write-Output("An error occurred: $_.Exception.Message")
    $shouldDropDb = $true;
}
Finally
{
    $command.Dispose()  | Out-Null
    $connection.Close() | Out-Null
    $connection.Dispose | Out-Null

    if($shouldDropDb)
    {
        Remove-Item $sqlCompactDbPath
    }
}