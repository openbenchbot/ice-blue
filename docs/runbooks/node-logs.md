# Node logs

`node-log-collector` is a DaemonSet in `kube-system`, shipped with every overlay. It reads node logs for the platform logging pipeline.

The only host mount is `/var/log`, and the volume mount is read-only. The container runs as a non-root user, drops all capabilities, and uses a read-only root filesystem. It does not mount the runtime socket, the kubelet credential directory, or the host process tree.

Change the mount only in that DaemonSet, and keep the same scope. Application logs stay on stdout and are collected from the node log files this agent already reads.
