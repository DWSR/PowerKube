---
external help file: PowerKube.dll-Help.xml
Module Name: PowerKube
online version:
schema: 2.0.0
---

# Get-K8sContext

## SYNOPSIS
Gets contexts listed in the config file

## SYNTAX

```
Get-K8sContext [-KubeConfig <String>] [[-Context] <String>] [<CommonParameters>]
```

## DESCRIPTION
Gets contexts listed in the config file

## EXAMPLES

### Get all contexts

```powershell
PS C:\> Get-K8sContext
```

### Get a specific context

```powershell
PS C:\> Get-K8sContext 'somecontext'
```

## PARAMETERS

### -Context
The specific context to retrieve

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -KubeConfig
The config file to use

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### k8s.KubeConfigModels.Context

## NOTES

## RELATED LINKS
