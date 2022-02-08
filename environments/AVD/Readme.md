# Azure Virtual Desktop PoC at UFST

## Templates:

https://github.com/jamesatighe/AVD-BICEP/blob/main/Bicep/mainBuild.bicep

## Infrastructure:

To do:
- AVD
    - Management Plane
        - Host Pools
            - Light: Pooled
            - Medium: Pooled
            - Heavy: Personal
        - RDP Settings
- VNET
    - Service Endpoints
        - Storage
        - Key Vault
    - NSG
    - Route Table
    - Peering

Monitoring (host plane)