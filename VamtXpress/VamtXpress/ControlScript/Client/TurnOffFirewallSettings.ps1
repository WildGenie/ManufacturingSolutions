netsh advfirewall firewall set rule group = "Windows Management Instrumentation (WMI)" new enable = no

netsh advfirewall firewall set rule name = "Windows Management Instrumentation (Async-in)" new remoteip = localip enable = no

netsh advfirewall firewall set rule name = "Windows Management Instrumentation (DCOM-in)" new remoteip = localip enable = no

netsh advfirewall firewall set rule name = "Windows Management Instrumentation (WMI-in)" new remoteip = localip enable = no

netsh advfirewall firewall set rule group = "File and Printer Sharing" new enable = no

#netsh firewall set service RemoteAdmin disable?

netsh advfirewall firewall set rule group = "Remote Administration" new enable = no