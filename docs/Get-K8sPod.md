---
external help file: PowerKube.dll-Help.xml
Module Name: PowerKube
online version:
schema: 2.0.0
---

# Get-K8sPod

## SYNOPSIS
Lists Kubernetes pods

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
Lists Kubernetes pods

## EXAMPLES

### List pods in the current namespace

```powershell
PS C:\> Get-K8sPod
```

### List pods in all namespaces in this cluster

```powershell
PS C:\> Get-K8sPod -AllNamespaces
```

## PARAMETERS

### -AllNamespaces
Whether or not to list pods from all namespaces

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
Which cluster to list pods in.

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
Which context to list pods in.

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
Only list pods whose fields match this criteria.

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
The kube config file to use.

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
Only list pods whose labels match this.

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
The name of a specific pod to get

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
The name of the namespace to list pods in

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
Whether or not to validate the certificate presented by the API.

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
