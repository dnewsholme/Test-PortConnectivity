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
    [cmdletbinding()]
    param(

        [Parameter(Mandatory = $true, Position = 0)][int][ValidateRange(0, 65535)]$port,
        [Parameter(Mandatory = $false, Position = 1)][switch]$exitonconnect,
        [Parameter(Mandatory = $false, Position = 2, ParameterSetName = "remote")][string]$RemoteDestination,
        [Parameter(Mandatory = $false, Position = 3, ParameterSetName = "remote")][pscredential]$credential,
        [Parameter(Mandatory = $false, Position = 4)][switch]$asJob



    )
    if ($remotedestination) {
        $parms = @{
            Computername = $RemoteDestination
            credential        = $credential
        }
        if ($asJob){
            $parms += @{"AsJob"=$true}
        }
        Invoke-command  @parms -ScriptBlock ${Function:Open-Port} -ArgumentList $port, $exitonconnect

    }
    Else {
        if ($asJob){
            Start-Job -ScriptBlock ${Function:Open-Port} -ArgumentList $port, $exitonconnect
        }
        Else{
            $parms = @{
                port          = $port
                exitonconnect = $exitonconnect
            }
            Open-Port @parms
        }


    }

}

Function Open-Port {
    [cmdletbinding()]
    Param (
        [Parameter(Mandatory = $true, Position = 0)][int][ValidateRange(0, 65535)]$port,
        [Parameter(Mandatory = $false, Position = 1)][switch]$exitonconnect
    )
    Begin {

    }
    Process {
        # Open windows firewall
        $rule = New-NetFirewallRule -DisplayName "[POWERSHELL PORT TEST] inbound TCP port $port" -Direction inbound -LocalPort $port -Protocol TCP -Action Allow
        # Create endpoint and listen on port
        $endpoint = new-object System.Net.IPEndPoint ([system.net.ipaddress]::any, $port)
        $listener = new-object System.Net.Sockets.TcpListener $endpoint
        $listener.server.ReceiveTimeout = 3000
        $listener.start()
        try {
            Write-Verbose "$($env:ComputerName) on port $port, press CTRL+C to cancel" -Verbose
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
            # Remove windows firewall exception
            Remove-NetFirewallRule -Name $rule.Name
            $listener.stop()

        }
    }
    End {

    }

}