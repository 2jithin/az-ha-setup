resource "azurerm_virtual_network" "vNetTemplate" {
  resource_group_name = azurerm_resource_group.rgTemplate.name
  name                = "vNetTemplate"
  location            = "Germany West Central"

  address_space = [
    "10.0.0.0/16",
  ]

  tags = {
    template = "true"
  }
}

resource "azurerm_lb" "lbTemplate" {
  resource_group_name = azurerm_resource_group.rgTemplate.name
  name                = "lbTemplate"
  location            = "Germany West Central"

  frontend_ip_configuration {
    public_ip_address_id = azurerm_public_ip.publicIPTemplate.id
    name                 = "frontendIPConfTemplate"
  }

  tags = {
    template = "true"
  }
}

resource "azurerm_resource_group" "rgTemplate" {
  name     = "rgTemplate"
  location = "Germany West Central"

  tags = {
    template = "true"
  }
}

resource "azurerm_public_ip" "publicIPTemplate" {
  resource_group_name = azurerm_resource_group.rgTemplate.name
  name                = "publicIPTemplate"
  location            = "Germany West Central"
  allocation_method   = "Static"

  tags = {
    template = "true"
  }
}

resource "azurerm_virtual_machine" "vmTemplate" {
  vm_size             = "Standard_DS1_v2"
  resource_group_name = azurerm_resource_group.rgTemplate.name
  name                = "vmTemplate"
  location            = "Germany West Central"

  network_interface_ids = [
    azurerm_network_interface.netInterfaceTemplate.id,
  ]

  os_profile {
    computer_name  = "hostnameTemplate"
    admin_username = "userTemplate"
    admin_password = "1Wk#Fj#^ZC>wDAnMj8]H)p8F)kr>a"
  }

  storage_os_disk {
    name              = "osDiskTemplate"
    managed_disk_type = "Standard_LRS"
    create_option     = "FromImage"
    caching           = "ReadWrite"
  }

  tags = {
    template = "true"
  }
}

resource "azurerm_network_interface" "netInterfaceTemplate" {
  resource_group_name = azurerm_resource_group.rgTemplate.name
  name                = "netInterfaceTemplate"
  location            = "Germany West Central"

  ip_configuration {
    subnet_id                     = azurerm_subnet.subnetTemplate.id
    private_ip_address_allocation = dynamic
    name                          = "ipConfTemplate"
  }

  tags = {
    template = "true"
  }
}

resource "azurerm_subnet" "subnetTemplate" {
  virtual_network_name = azurerm_virtual_network.vNetTemplate.name
  resource_group_name  = azurerm_resource_group.rgTemplate.name
  name                 = "subnetTemplate"

  address_prefixes = [
    "10.0.2.0/24",
  ]
}

