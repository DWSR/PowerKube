using System;
using System.Management.Automation;

namespace PowerKube.Commands.Base
{
    public abstract class BaseContextCommand : Cmdlet
    {
        [Parameter()]
        public string KubeConfig { get; set; }

        [Parameter(Position = 0)]
        public string Context { get; set; }
    }
}
