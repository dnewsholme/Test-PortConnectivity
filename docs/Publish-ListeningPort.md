---
external help file: test-portconnectivity-help.xml
Module Name: Test-PortConnectivity
online version:
schema: 2.0.0
---

# Publish-ListeningPort

## SYNOPSIS
Open a listening TCP port

## SYNTAX

```
Publish-ListeningPort [-port] <Int32> [-exitonconnect] [[-RemoteDestination] <String>]
 [[-credential] <PSCredential>] [-asJob] [<CommonParameters>]
```

## DESCRIPTION
Open a listening TCP port

## EXAMPLES

### EXAMPLE 1
```
Publish-ListeningPort -port 443
```

### EXAMPLE 2
```
Publish-ListeningPort -port 443 -exitonconnect
```

## PARAMETERS

### -port
Port number

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -exitonconnect
Cause the function to close the port after the first connection to the port.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -RemoteDestination
{{Fill RemoteDestination Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -credential
{{Fill credential Description}}

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -asJob
{{Fill asJob Description}}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Daryl Newsholme

## RELATED LINKS
