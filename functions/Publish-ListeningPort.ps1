<#
.SYNOPSIS
Open a listening TCP port

.DESCRIPTION
Open a listening TCP port

.PARAMETER port
Port number

.PARAMETER exitonconnect
Cause the function to close the port after the first connection to the port.

.EXAMPLE
Publish-ListeningPort -port 443

.EXAMPLE
Publish-ListeningPort -port 443 -exitonconnect

.NOTES
Daryl Newsholme
#>

function Publish-ListeningPort {
    param(

        [Parameter(Mandatory = $true, Position = 0)][int][ValidateRange(0, 65535)]$port,
        [Parameter(Mandatory = $false, Position = 1)][switch]$exitonconnect,
        [Parameter(Mandatory = $false, Position = 2)][string]$RemoteDestination,
        [Parameter(Mandatory = $false, Position = 3)][pscredential]$credential


    )
    if ($remotedestination){
        Invoke-command -ComputerName $remotedestination -Credential $credential -ScriptBlock ${Function:Open-Port} -ArgumentList $port,$exitonconnect

    }
    Else {
        switch ($exitonconnect){
            True{
                Open-Port -port $port -exitonconnect

            }
            False {
                Open-Port -port $port

            }
        }
    }

}

Function Open-Port {
    Param (
        [Parameter(Mandatory = $true, Position = 0)][int][ValidateRange(0, 65535)]$port,
        [Parameter(Mandatory = $false, Position = 1)][switch]$exitonconnect
    )
    $endpoint = new-object System.Net.IPEndPoint ([system.net.ipaddress]::any, $port)
    $listener = new-object System.Net.Sockets.TcpListener $endpoint
    $listener.server.ReceiveTimeout = 3000
    $listener.start()
    try {
        Write-Verbose "Listening on port $port, press CTRL+C to cancel"
        While ($true) {
            if (!$listener.Pending()) {
                Start-Sleep -Seconds 1;
                continue;
            }
            $client = $listener.AcceptTcpClient()
            $client.client.RemoteEndPoint | Add-Member -NotePropertyName DateTime -NotePropertyValue (get-date) -PassThru
            $client.close()
            if ($exitonconnect) {
                break
            }
        }
    }
    catch {
        Write-Error $_
    }
    finally {
        $listener.stop()

    }

}