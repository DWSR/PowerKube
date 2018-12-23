---
external help file: PowerKube.dll-Help.xml
Module Name: PowerKube
online version:
schema: 2.0.0
---

# Get-K8sPod

## SYNOPSIS
{{Fill in the Synopsis}}

## SYNTAX

### AllNamespaces
```
Get-K8sPod [[-Name] <String>] [-LabelSelector <String[]>] [-FieldSelector <String[]>] [-AllNamespaces]
 [-Context <String>] [-Cluster <String>] [-KubeConfig <String>] [-SkipCertificateCheck] [<CommonParameters>]
```

### OneNamespace
```
Get-K8sPod [[-Name] <String>] [-LabelSelector <String[]>] [-FieldSelector <String[]>] [-Namespace <String>]
 [-Context <String>] [-Cluster <String>] [-KubeConfig <String>] [-SkipCertificateCheck] [<CommonParameters>]
```

## DESCRIPTION
{{Fill in the Description}}

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -AllNamespaces
{{Fill AllNamespaces Description}}

```yaml
Type: SwitchParameter
Parameter Sets: AllNamespaces
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Cluster
{{Fill Cluster Description}}

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

### -Context
{{Fill Context Description}}

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

### -FieldSelector
{{Fill FieldSelector Description}}

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -KubeConfig
{{Fill KubeConfig Description}}

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

### -LabelSelector
{{Fill LabelSelector Description}}

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: l

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
{{Fill Name Description}}

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

### -Namespace
{{Fill Namespace Description}}

```yaml
Type: String
Parameter Sets: OneNamespace
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SkipCertificateCheck
{{Fill SkipCertificateCheck Description}}

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
