---
external help file: PowerKube.dll-Help.xml
Module Name: PowerKube
online version:
schema: 2.0.0
---

# Switch-K8sContext

## SYNOPSIS
Changes the current Kubernetes context based for the specified config file.

## SYNTAX

```
Switch-K8sContext [-Context] <String> [-KubeConfig <String>] [<CommonParameters>]
```

## DESCRIPTION
Changes the current Kubernetes context based for the specified config file.

## EXAMPLES

### Change context in the default config file

This changes the current context according to the default config file to `docker-for-desktop`.

```powershell
PS C:\> Switch-K8sContext docker-for-desktop
```


## PARAMETERS

### -Context
The name of the context to change to.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -KubeConfig
The path to the Kubernetes config file to modify.

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

### System.Void

## NOTES

## RELATED LINKS
