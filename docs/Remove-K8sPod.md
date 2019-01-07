---
external help file: PowerKube.dll-Help.xml
Module Name: PowerKube
online version:
schema: 2.0.0
---

# Remove-K8sPod

## SYNOPSIS
Removes the specified Kubernetes pods.

## SYNTAX

### Pipeline
```
Remove-K8sPod [-APIVersion <String>] -InputObject <PSObject> [-Force] [-GracePeriod <Int32>]
 [-Context <String>] [-Cluster <String>] [-KubeConfig <String>] [-SkipCertificateCheck] [<CommonParameters>]
```

### RemoveMany
```
Remove-K8sPod [-APIVersion <String>] [-Namespace <String>] [-Name] <String> [-LabelSelector <String[]>]
 [-FieldSelector <String[]>] [-Force] [-GracePeriod <Int32>] [-PropagationPolicy <PropagationPolicy>]
 [-Context <String>] [-Cluster <String>] [-KubeConfig <String>] [-SkipCertificateCheck] [<CommonParameters>]
```

### RemoveAll
```
Remove-K8sPod [-APIVersion <String>] [-Namespace <String>] [-LabelSelector <String[]>]
 [-FieldSelector <String[]>] [-Force] [-GracePeriod <Int32>] [-All] [-PropagationPolicy <PropagationPolicy>]
 [-Context <String>] [-Cluster <String>] [-KubeConfig <String>] [-SkipCertificateCheck] [<CommonParameters>]
```

## DESCRIPTION
Removes the specified Kubernetes pods.

## EXAMPLES

### Nuke it from orbit
```powershell
PS C:\> Get-K8sPod -AllNamespaces | Remove-K8sPod
```

Removes ever pod from every namespace. Be careful!

## PARAMETERS

### -APIVersion
The API Group to use.

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

### -All
Whether or not to remove all pods in the specified namespace.

```yaml
Type: SwitchParameter
Parameter Sets: RemoveAll
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Cluster
Which cluster to use from the specified Kubernetes config file.

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
Which context to use from the specified Kubernetes config file.

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
Only delete pods whose fields match this criteria.

```yaml
Type: String[]
Parameter Sets: RemoveMany, RemoveAll
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Whether or not to force the deleteion.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: f

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -GracePeriod
Wait this many seconds for the pods to terminate gracefully.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
InputObject from the pipeline

```yaml
Type: PSObject
Parameter Sets: Pipeline
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
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

### -LabelSelector
Only delete pods whose labels match these.

```yaml
Type: String[]
Parameter Sets: RemoveMany, RemoveAll
Aliases: l

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
The name of a pod to delete.

```yaml
Type: String
Parameter Sets: RemoveMany
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Namespace
The namespace to delete the pod in.

```yaml
Type: String
Parameter Sets: RemoveMany, RemoveAll
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PropagationPolicy
Whether or not to orphan, delete asynchronously, or delete asynchronously dependant objects.

```yaml
Type: PropagationPolicy
Parameter Sets: RemoveMany, RemoveAll
Aliases:
Accepted values: Orphan, Background, Foreground

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SkipCertificateCheck
Whether or not to skip checking the API server's certificate.

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

### System.Management.Automation.PSObject

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
