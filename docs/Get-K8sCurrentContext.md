---
external help file: PowerKube.dll-Help.xml
Module Name: PowerKube
online version:
schema: 2.0.0
---

# Get-K8sCurrentContext

## SYNOPSIS
Gets the current context, and optionally namespace, as a string.

## SYNTAX

```
Get-K8sCurrentContext [-KubeConfig <String>] [-IncludeNamespace] [-NamespaceSeparator <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Gets the current context, and optionally namespace, as a string. Useful for prompts.

## EXAMPLES

### Get the current context

```powershell
PS C:\> Get-K8sCurrentContext
```

### Get the current context including namespace

```powershell
PS C:\> Get-K8sCurrentContext -IncludeNamespace
```

## PARAMETERS

### -IncludeNamespace
Whether or not to include the namespace in the output

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -KubeConfig
Which config file to use.

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

### -NamespaceSeparator
The string to separate the context and namespace with

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

### System.String

## NOTES

## RELATED LINKS
